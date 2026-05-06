# User Flow and State Machine Specification

The platform's core educational experience is architected as a rigid state machine. Users cannot bypass stages; progress requires explicit completion of the current state's requirements.

## State Transitions

### State 0: Onboarding and Team Assembly
The initial state where the user enters the platform and establishes their learning context.
- **Trigger:** Initial user connection.
- **[Missing] Magic Link Auth:** Users authenticate using frictionless email magic links rather than complex password creation.
- **Decision Matrix:** The user selects either Solo Mode or Group Mode.
- **Outcome:** In Solo Mode, a Synthetic Companion is instantiated. In Group Mode, an invite code is generated. The system holds in State 0 until the required team members are connected. Transition to State 1 occurs upon team assembly.

### State 1: Goal Formulation
The cognitive coaching phase where the raw desire is refined into an actionable target.
- **Trigger:** Successful completion of State 0.
- **Execution:** The agent engages the group using the paraphrase-and-pause loop.
- **Validation:** The system requires explicit alignment. Transition to State 2 only occurs when 100% of the team members trigger the "Aligned" consensus mechanism.
- **Fallback:** If alignment is rejected, the state resets the coaching loop.

### State 2: Success Criteria Definition
The phase where the subjective goal is translated into objective metrics.
- **Trigger:** 100% alignment in State 1.
- **Execution:** The agent enforces the definition of a binary (Yes/No) outcome based on the Brené Brown methodology.
- **Validation:** The group must agree on the proposed binary criteria.
- **Fallback:** If a fundamental disagreement occurs over what constitutes success, the state machine issues a critical rollback to State 1.

### State 3: Learning Material Curation
The phase where knowledge resources are mapped to the goal.
- **Trigger:** Criteria agreement in State 2.
- **Execution:** The platform queries the Dynamic RAG system. The user dictates the required depth (high-level summary versus deep reading) and format. The system curates the necessary documentation.
- **Transition:** Proceeds to State 4 once materials are delivered and consumed.

### State 4: Daily Actions & Feedback Loop
The continuous execution phase of the state machine.
- **Trigger:** Completion of State 3.
- **Execution:** The system proposes a maximum of five discrete action steps based on the curated materials. 
- **Validation (Success):** Completion of steps triggers the token reward system and advances the curriculum complexity.
- **Validation (Struggle):** Negative feedback from the user triggers the Empathy Loop. The state machine downgrades the difficulty of the next action step and initiates recovery token protocols.
