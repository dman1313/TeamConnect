# System Architecture Specification

This document details the high-level architecture and infrastructural components of AGORA Agentic Goal-Oriented Reflective Adaptive academy.

## 1. High-Level Architectural Pattern
The platform utilizes a modern, serverless Backend-as-a-Service (BaaS) architecture prioritizing rapid iteration, real-time synchronization, and high availability.

### 1.1. Frontend Architecture
The presentation layer is responsible for managing the educational state machine and capturing user intent.
- **Framework:** The application is built using a component-based frontend library optimized for high responsiveness.
- **[Missing] CSS Strategy:** The aesthetic execution utilizes utility-first CSS frameworks (Tailwind) to implement a strict, accessible design system characterized by glassmorphism and modern typography.
- **[Missing] Native Voice Integration:** To bypass reliance on external transcription APIs, the frontend leverages the native browser Web Speech API for instantaneous voice dictation.

### 1.2. Backend Infrastructure
The persistent and real-time computing layers are managed via a centralized BaaS platform.
- **[Missing] Supabase Core:** The system utilizes Supabase for end-to-end backend management.
- **Relational Storage:** Core entity tracking (users, goals, tokens) is handled by a fully managed PostgreSQL database.
- **[Missing] Real-Time Synchronization:** The architecture leverages WebSocket-based real-time subscriptions to ensure instantaneous synchronization of state machine transitions, typing indicators, and multi-user consensus across all client interfaces.
- **Serverless Compute:** Business logic, including all interactions with the Agentic Orchestrator, is executed within isolated Edge Functions to ensure security and scalability.

## 2. Multi-Agent AI Framework

AGORA moves away from a monolithic "chatbot" architecture in favor of a specialized **Multi-Agent Coordination Framework**. Complex tasks are distributed across specialized agents.

### 2.1. Agent Specializations
- **The Strategist Agent (Reasoning & Planning):** Serves as the core logic engine. It decomposes complex educational objectives into manageable steps and formulates the adaptive strategy.
- **The Mediator Agent (Interaction):** Handles the paraphrasing loop and Socratic guidance. It is responsible for detecting emotional cues and applying the Empathy Loop.
- **The Designer Agent (Content):** Interacts exclusively with the RAG system to dynamically generate Pedagogical Tools (flashcards, summaries) tailored to the exact specifications of the Strategist.

### 2.2. Dual-Memory System Architecture
To achieve true "Continual Learning" (where the system learns how to teach the specific user better over time), the architecture implements a bifurcated memory system:
- **Short-Term Memory:** Held in fast-access temporary storage (e.g., Redis). Holds context, current goal trajectory, and temporary data necessary for the immediate session's reasoning.
- **Long-Term Memory:** Stored natively in the PostgreSQL/pgvector database. Houses historical interactions, successful strategies, and highly personalized learner profiles. This allows the Strategist agent to reference past sessions when deciding current difficulty levels.

## 3. Knowledge Base (Dynamic RAG)
The retrieval architecture for educational content.
- The system employs a graph-based indexing strategy, linking discrete chunks of Markdown text semantically.
- **[Missing] Vector Storage:** Semantic search is executed using a dedicated Vector Store (pgvector) to retrieve highly relevant context for the Designer Agent.
