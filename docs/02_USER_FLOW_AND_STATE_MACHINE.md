# User Flow and State Machine Specification

The platform's core educational experience is architected as a rigid, reflective state machine. The progression logic is explicitly modeled on **Gibbs' Reflective Cycle** (Analyze -> Reflect -> Enact -> Impact), ensuring users engage in continuous self-improvement loops.

## State Transitions

### State 0: Onboarding and Team Assembly (The Context Phase)
The initial state where the user enters the platform and establishes their learning context.
- **Trigger:** Initial user connection.
- **[Missing] Magic Link Auth:** Users authenticate using frictionless email magic links.
- **Decision Matrix:** The user selects either Solo Mode or Group Mode.
- **Outcome:** In Solo Mode, a Synthetic Companion is instantiated. In Group Mode, an invite code is generated. Transition to State 1 occurs upon team assembly.

### State 1: Goal Formulation (The 'Analyze' Phase)
The cognitive coaching phase where the raw desire is analyzed and refined into an actionable target.
- **Trigger:** Successful completion of State 0.
- **Execution:** The agent engages the group using the paraphrase-and-pause loop. The agent forces the user to analyze *why* they want this goal and *what* foundational knowledge they lack.
- **Validation:** The system requires explicit alignment. Transition to State 2 only occurs when 100% of the team members trigger the "Aligned" consensus mechanism.
- **Fallback:** If alignment is rejected, the state resets the analytical coaching loop.

### State 2: Success Criteria Definition (The 'Reflect' Phase)
The phase where the subjective goal is translated into objective metrics.
- **Trigger:** 100% alignment in State 1.
- **Execution:** The agent enforces the definition of a binary (Yes/No) outcome based on the Brené Brown methodology. Users are forced to *reflect* on what definitive proof looks like.
- **Validation:** The group must agree on the proposed binary criteria.
- **Fallback:** Critical rollback to State 1 if fundamental disagreement occurs over the definition of success.

### State 3: Learning Material Curation (The 'Enact' Preparation Phase)
The phase where knowledge resources are mapped to the goal to prepare for action.
- **Trigger:** Criteria agreement in State 2.
- **Execution:** The platform queries the Dynamic RAG system. The user dictates the required depth (high-level summary versus deep reading) and format. The system curates the necessary documentation.
- **Transition:** Proceeds to State 4 once materials are delivered and consumed.

### State 4: Daily Actions & Feedback Loop (The 'Enact & Impact' Phase)
The continuous execution phase of the state machine.
- **Trigger:** Completion of State 3.
- **Execution (Enact):** The system proposes discrete action steps based on the curated materials. 
- **Validation & Feedback (Impact):** 
    - *Success:* Completion of steps triggers the token reward system. The Long-Term Memory is updated with the successful learning strategy.
    - *Struggle:* Negative feedback triggers the Empathy Loop. The state machine downgrades the difficulty, initiates recovery token protocols, and forces a micro-reflection on *why* the task failed.
