# RAG and Knowledge Graph Specification

The Dynamic Retrieval-Augmented Generation (RAG) system serves as the adaptive curriculum backbone of the platform, bridging user intent with curated knowledge.

## 1. Graph-Based Indexing Architecture
Instead of relying on a standard, flat vector database approach, the system constructs knowledge akin to a networked graph (the "Obsidian LLM" method).
- **Nodes:** Discretized chunks of learning material, including user-uploaded documents, web resources, and agent-generated summaries.
- **Edges:** Semantic relationships and linking metadata connecting related concepts across the knowledge base.
- **Traversal Engine:** The system dynamically traverses this graph based on the user's requested depth. High-level requests retrieve central nodes, while deep-reading requests retrieve specialized peripheral nodes.

## 2. Ingestion and Processing Pipeline
The sequential process for incorporating new knowledge into the platform.
1. **Document Reception:** The system accepts text-based inputs via user uploads (e.g., PDFs) or external URLs.
2. **Chunking Strategy:** The raw text is systematically split into logical Markdown-formatted chunks to preserve hierarchical context.
3. **Semantic Embedding:** The chunks are processed through an embedding model and stored natively in the backend vector storage.
4. **Contextual Linking:** An automated LLM pass evaluates the new chunks, extracting key concepts to map semantic edges to existing nodes within the team's localized knowledge graph.

## 3. Pedagogical Generation Pipeline
The system responsible for transforming static text into active learning tools.
- **- [Missing] Format Extraction:** Upon retrieving relevant graph nodes, the text is passed through the Pedagogical Generator. This component automatically restructures the raw text into active study formats, such as structured flashcards or multiple-choice question banks, tailored to the group's current goal.
- **Security and Scoping:** Resources uploaded to a specific group are cryptographically tagged with the team identifier in the vector metadata. This guarantees that pedagogical generation queries are securely isolated to the authorized team's domain.
