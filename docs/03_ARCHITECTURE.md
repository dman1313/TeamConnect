# System Architecture Specification

This document details the high-level architecture and infrastructural components of the Advanced Learning Platform.

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
- **Serverless Compute:** Business logic, including all interactions with the LLM orchestrator, is executed within isolated Edge Functions to ensure security and scalability.

### 1.3. LLM Orchestrator
The cognitive engine of the platform.
- The orchestrator acts as the middle layer between the Edge Functions and external Large Language Models.
- It is solely responsible for generating paraphrased responses, generating pedagogical materials, and summarizing WebRTC sessions based on strict system boundaries.

### 1.4. Knowledge Base (Dynamic RAG)
The retrieval architecture for educational content.
- The system employs a graph-based indexing strategy, linking discrete chunks of Markdown text semantically.
- **[Missing] Vector Storage:** Semantic search is executed using a dedicated Vector Store (e.g., pgvector) to retrieve highly relevant context for the LLM orchestrator based on the user's current goal trajectory.
