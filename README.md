# AGORA Agentic Goal-Oriented Reflective Adaptive academy

Welcome to AGORA Agentic Goal-Oriented Reflective Adaptive academy! This project was built to deliver secure, accessible, agentic self-development tools for individuals and small groups. It serves as an empathetic "Cognitive Coach" to help users formulate goals, set strict success criteria, generate dynamic learning materials, and foster group collaboration.

## 🚀 Features
* **Cognitive Agent Coaching:** An LLM-driven orchestrator that uses the paraphrase-and-pause technique to guide users to their own goals without AI bias.
* **WebRTC Video Conferencing:** Built-in video calling with Real-Time Speech-to-Text (STT) and automated session summaries.
* **Dynamic RAG & Pedagogical Generators:** Auto-generates flashcards, quizzes, and mindmaps from an Obsidian-style semantic knowledge graph.
* **Gamification Economy:** Rewards users with tokens for success, and utilizes an Empathy Loop to award "Recovery Tokens" when users struggle, preventing platform abandonment.
* **Offline-Ready UI:** A gorgeous, shadcn-inspired Vanilla HTML/CSS/JS frontend that runs entirely locally with zero build dependencies, featuring horizontal swipe-card triage.
* **Role-Based Access Control (RBAC):** Built-in Supabase PostgreSQL schema with Row Level Security ensuring complete data isolation between study teams.

## 📁 Directory Structure
```
advanced-learning-platform/
├── docs/                       # Formal System Design Specifications
├── supabase/                   
│   ├── migrations/             # Full PostgreSQL Schema with RLS and RBAC
├── index.html                  # Main UI Entrypoint (Zero Build Required)
├── style.css                   # Glassmorphism Styles (shadcn aesthetic)
├── app.js                      # Cognitive Chat & State Logic
└── README.md
```

## 🛠 Getting Started (Offline Demo)
Since the application was built to bypass hackathon network restrictions, the frontend has **zero dependencies** and requires **zero build steps**.

1. Simply clone the repository.
2. Double-click the `index.html` file to open it in Chrome or Safari.
3. Interact with the chat, use the voice dictation (Web Speech API), and swipe the action cards!

## 💾 Database Schema
The database architecture is designed for **Supabase**. To initialize the database once internet is restored:
1. Ensure the Supabase CLI is installed.
2. Run `supabase start`.
3. The migrations in `supabase/migrations/` will automatically apply the tables and RLS policies.

## 👥 Contributors
Developed by dman1313 for Hack1.
