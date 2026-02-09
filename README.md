# Post-Quantum Cryptography Research: ML-DSA Implementation in IoT MQTT

## Overview

This repository contains the research documentation and LaTeX paper for our fourth academic paper focusing on **implementation challenges in post-quantum cryptography**. Rather than exploring theoretical security aspects, we examine practical deployment issues, performance optimization, and real-world implementation considerations for quantum-resistant algorithms.

## Research Focus

### Primary Objective
Investigate the practical challenges of deploying **ML-DSA (Module-Lattice-Based Digital Signature Algorithm)**, the NIST standard for post-quantum digital signatures based on CRYSTALS-Dilithium, in constrained IoT environments.

### Key Research Areas

1. **IoT Resource Constraints**
   - ARM Cortex-M4 microcontroller analysis
   - Memory and computational resource requirements
   - Energy efficiency considerations

2. **MQTT Protocol Integration**
   - MQTT message security enhancements
   - Message authentication with post-quantum signatures
   - Protocol overhead and bandwidth implications

3. **Performance Analysis**
   - Signature generation and verification timing
   - Memory footprint and RAM requirements
   - Comparison with classical alternatives

4. **Hybrid Approaches**
   - Classical-quantum signature combinations
   - Fallback mechanisms for constrained devices
   - Migration strategies for existing systems

## Project Structure

```
playful-eagle/
├── code/              # Implementation code and prototypes
├── docs/              # Research documentation and analysis
├── tex/               # LaTeX source files for paper writing
├── .github/           # CI/CD workflows and automation
└── Makefile           # Build and compilation scripts
```

## Research Progress

- [x] **Literature Review** - Analyzed existing post-quantum implementations
- [x] **ML-DSA Specification** - Studied NIST FIPS 204 standard
- [x] **IoT Constraints Analysis** - Identified resource limitations
- [x] **MQTT Integration Design** - Designed security architecture
- [ ] **Prototype Implementation** - Development phase (in progress)
- [ ] **Performance Testing** - Benchmarks and analysis
- [ ] **Paper Drafting** - Writing and revision

## Getting Started

### Build the Paper

```bash
# Compile LaTeX sources
make

# View the compiled PDF
open tex/main.pdf
```

### Install Dependencies

```bash
# Python dependencies
pip install -r requirements.txt

# LaTeX tools (ensure TeX Live or MiKTeX is installed)
# Required packages: latexmk, biber, pdflatex
```

## Documentation

- [Research Process](./docs/pqc-status.md) - Overview of post-quantum cryptography research
- [Implementation Notes](./docs/implementation-notes.md) - Technical details
- [Paper Draft](./tex/main.tex) - Main paper source

## Research Methodology

1. **Problem Identification** - Analyze post-quantum cryptographic deployment challenges
2. **Case Study** - Focus on ML-DSA in ARM Cortex-M4 environments
3. **Prototype Development** - Build working implementations
4. **Performance Benchmarking** - Measure and optimize
5. **Academic Writing** - Document findings and contribute to the field

## License

This research project is maintained for academic purposes.

## Contributors

- Primary Researcher: [Author Name]
- Collaboration: [Collaborators/Institution]

---

> While our major work has covered security aspects, we now shift our focus to implementation challenges in post-quantum cryptography. This gives us the opportunity to explore practical deployment issues, performance optimization, and real-world implementation considerations without theoretical limitations.
