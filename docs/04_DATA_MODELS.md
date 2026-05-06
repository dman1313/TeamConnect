# Data Model Specification

This document describes the core entities, their relationships, and the security policies governing the data architecture. 

## 1. Core Entities

### 1.1. User and Group Aggregates
The system tracks individual learners and their organizational structures.
- **User Entity:** Represents the individual learner. Stores identifying information, learning style preferences, and calculates aggregate token balances based on transaction history.
- **Team Entity:** Represents the collaborative learning environment. Contains an alphanumeric invite code and a boolean flag denoting whether the team comprises human users or a solo user paired with a synthetic companion.

### 1.2. Goal and Criteria Aggregates
The system records the output of the state machine's formulation phases.
- **Goal Entity:** Represents the agreed-upon objective for a Team. Tracks the description of the goal and its current execution status (Draft, Active, Completed, or Failed).
- **Success Criteria Entity:** Bound to a specific Goal. Defines the strict binary question that determines success and specifies the required verification method (e.g., manual acknowledgement versus photographic proof).

### 1.3. Action and Gamification Aggregates
The system logs the execution of the learning curriculum and the resulting economic rewards.
- **Action Item Entity:** Bound to a Goal. Represents discrete tasks assigned to users and tracks their completion status.
- **[Missing] Feedback Log Entity:** Records the user's daily emotional response to the action items, capturing a comfort level rating and sentiment. This data is critical for triggering the Empathy Loop.
- **[Missing] Token Ledger Entity:** An immutable transaction log recording every token awarded to a user, specifying the amount and the reason (e.g., standard task completion versus empathy recovery).

## 2. Security and Access Control

- **[Missing] Role-Based Access Control (RBAC):** The system implements a hierarchical role structure linking Users to Teams. The roles defined are Admin, Moderator, and Member.
- **[Missing] Row Level Security (RLS):** Data isolation is enforced at the database level. RLS policies dictate that read and write operations are strictly limited to the authenticated user's authorized Team context. For example, modifying a Goal's status requires explicit validation that the requesting user holds an Admin or Moderator role within that specific Team.
