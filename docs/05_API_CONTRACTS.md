# API and Interaction Contracts

This document specifies the communication interfaces between the frontend client and the backend services. All interactions are stateless and authenticated, utilizing a combination of RESTful execution and Real-Time event streaming.

## 1. Coaching and Orchestration Interfaces

### Cognitive Conversation Endpoint
- **Purpose:** Facilitates the primary interaction with the Cognitive Coach during the Goal Formulation state.
- **Contract:** The client transmits the current team identifier, the user's message, and the active state machine context. The backend validates the context and forwards the payload to the LLM orchestrator.
- **[Missing] Real-Time Streaming Output:** The endpoint returns an immediate acknowledgement. The actual response from the orchestrator is streamed back to the client asynchronously via a dedicated Real-Time WebSocket channel to simulate real-time typing and prevent connection timeouts.

### Success Criteria Registration Endpoint
- **Purpose:** Persists the finalized binary criteria agreed upon during State 2.
- **Contract:** The client transmits an array of binary questions bound to the specific goal identifier. The backend validates the schema and persists the criteria.

### Team Alignment Consensus Endpoint
- **Purpose:** Acts as the strict gatekeeper between State 1 and State 2.
- **Contract:** The client transmits a boolean vote from a specific user regarding the current goal. The backend aggregates these votes in real-time. The state machine transitions only when the aggregate alignment reaches 100%.

## 2. Curriculum Generation Interfaces

### Pedagogical Generation Endpoint
- **Purpose:** Triggers the Dynamic RAG system to produce structured learning materials.
- **Contract:** The client requests materials based on a specific goal identifier, providing parameters for formatting (e.g., flashcards, quizzes) and depth. The backend orchestrator retrieves relevant semantic chunks, synthesizes the material, and returns a structured object containing the pedagogical items.

## 3. Gamification Interfaces

### Action Completion Endpoint
- **Purpose:** Records task completion, processes user feedback, and executes token distribution logic.
- **Contract:** The client transmits the action identifier, subjective feedback, and any required verification proof. The backend updates the action status, logs the sentiment, and appends a new transaction to the Token Ledger based on the evaluation logic (standard reward vs. recovery reward).

## 4. Ancillary Interfaces

- **[Missing] Fallback Voice Transcription Endpoint:** An optional endpoint designed to accept audio payloads and return transcribed text. This serves as a fallback mechanism for clients operating on browsers that do not support the native Web Speech API.
