-- Enable the UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ==========================================
-- 1. ENUMS
-- ==========================================
CREATE TYPE role_type AS ENUM ('ADMIN', 'MODERATOR', 'MEMBER');
CREATE TYPE goal_status AS ENUM ('DRAFT', 'ACTIVE', 'COMPLETED', 'FAILED');
CREATE TYPE verification_type AS ENUM ('MANUAL_TICK', 'PHOTO_PROOF');
CREATE TYPE action_status AS ENUM ('PENDING', 'DONE', 'STRUGGLING');

-- ==========================================
-- 2. TABLES
-- ==========================================

-- USERS
CREATE TABLE public.users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    email TEXT UNIQUE NOT NULL,
    name TEXT,
    learning_style_preference TEXT DEFAULT 'visual',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- TEAMS
CREATE TABLE public.teams (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT NOT NULL,
    invite_code TEXT UNIQUE NOT NULL,
    is_synthetic BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- USER ROLES (RBAC)
CREATE TABLE public.user_roles (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    team_id UUID NOT NULL REFERENCES public.teams(id) ON DELETE CASCADE,
    role role_type NOT NULL DEFAULT 'MEMBER',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(user_id, team_id)
);

-- GOALS
CREATE TABLE public.goals (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    team_id UUID NOT NULL REFERENCES public.teams(id) ON DELETE CASCADE,
    description TEXT NOT NULL,
    status goal_status NOT NULL DEFAULT 'DRAFT',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- SUCCESS CRITERIA
CREATE TABLE public.success_criteria (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    goal_id UUID NOT NULL REFERENCES public.goals(id) ON DELETE CASCADE,
    question TEXT NOT NULL,
    verification_type verification_type NOT NULL DEFAULT 'MANUAL_TICK',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ACTION ITEMS
CREATE TABLE public.action_items (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    goal_id UUID NOT NULL REFERENCES public.goals(id) ON DELETE CASCADE,
    assigned_to UUID REFERENCES public.users(id) ON DELETE SET NULL,
    description TEXT NOT NULL,
    status action_status NOT NULL DEFAULT 'PENDING',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- FEEDBACK LOGS (Empathy Loop)
CREATE TABLE public.feedback_logs (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    action_id UUID NOT NULL REFERENCES public.action_items(id) ON DELETE CASCADE,
    comfort_level INTEGER CHECK (comfort_level >= 1 AND comfort_level <= 5),
    sentiment TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- TOKEN TRANSACTIONS (Gamification Ledger)
CREATE TABLE public.token_transactions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    team_id UUID NOT NULL REFERENCES public.teams(id) ON DELETE CASCADE,
    amount INTEGER NOT NULL,
    reason TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ==========================================
-- 3. ROW LEVEL SECURITY (RLS) POLICIES
-- ==========================================

-- Enable RLS on all tables
ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.teams ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_roles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.goals ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.success_criteria ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.action_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.feedback_logs ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.token_transactions ENABLE ROW LEVEL SECURITY;

-- Helper function to check if a user is in a team
CREATE OR REPLACE FUNCTION public.is_team_member(team_uuid UUID)
RETURNS BOOLEAN AS $$
BEGIN
  RETURN EXISTS (
    SELECT 1 FROM public.user_roles
    WHERE team_id = team_uuid AND user_id = auth.uid()
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Helper function to check if user is Admin or Moderator
CREATE OR REPLACE FUNCTION public.is_team_admin_or_mod(team_uuid UUID)
RETURNS BOOLEAN AS $$
BEGIN
  RETURN EXISTS (
    SELECT 1 FROM public.user_roles
    WHERE team_id = team_uuid 
    AND user_id = auth.uid() 
    AND role IN ('ADMIN', 'MODERATOR')
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Policy: Teams (Users can only view teams they are a part of)
CREATE POLICY "Users can view their teams" 
ON public.teams FOR SELECT 
USING (public.is_team_member(id));

-- Policy: Goals (Users can view goals for their teams)
CREATE POLICY "Users can view team goals" 
ON public.goals FOR SELECT 
USING (public.is_team_member(team_id));

-- Policy: Goals RBAC (Only ADMIN or MODERATOR can update goal status)
CREATE POLICY "Only Admins/Mods can update goals" 
ON public.goals FOR UPDATE 
USING (public.is_team_admin_or_mod(team_id));

-- Policy: Action Items (Users can view and update their team's actions)
CREATE POLICY "Users can view team actions" 
ON public.action_items FOR SELECT 
USING (
  EXISTS (
    SELECT 1 FROM public.goals g 
    WHERE g.id = action_items.goal_id AND public.is_team_member(g.team_id)
  )
);

CREATE POLICY "Users can update their team actions" 
ON public.action_items FOR UPDATE 
USING (
  EXISTS (
    SELECT 1 FROM public.goals g 
    WHERE g.id = action_items.goal_id AND public.is_team_member(g.team_id)
  )
);
