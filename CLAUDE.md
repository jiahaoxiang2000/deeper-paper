# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a research project focused on post-quantum cryptography implementation issues, specifically examining ML-DSA (Module-Lattice-Based Digital Signature Algorithm) integration in IoT MQTT environments. The project combines academic research documentation with LaTeX paper writing for cryptographic analysis.

## Key Commands

### Development Environment Setup
```bash
make setup          # Install dependencies with uv and create necessary directories
make clean          # Clean up temporary files and Python caches
```

### Python Environment
```bash
uv sync             # Install Python dependencies (all-in-mcp>=0.2.7)
```

### LaTeX Document Compilation
```bash
cd tex/
latexmk -pdf index.tex    # Compile the main research paper to PDF
latexmk -c               # Clean LaTeX auxiliary files
```

The LaTeX configuration uses:
- `pdflatex` with synctex, shell-escape, and error reporting enabled
- Automatic bibtex processing for citations
- IACR Transactions class for TCHES journal format

## Repository Architecture

### Research Documentation (`docs/`)
- **pqc-status.md**: Comprehensive analysis of NIST's post-quantum cryptography standardization process, including FIPS 203/204/205 standards, algorithm performance characteristics, and migration timelines
- **ML-DSA.md**: Technical documentation on Module-Lattice-Based Digital Signature Algorithm
- **migration-protocol.md**: Protocol migration strategies for post-quantum cryptography
- **select-dsa-protocol.md**: Digital signature algorithm selection guidance
- **pdf/**: Collection of NIST publications and standards documents

### LaTeX Paper (`tex/`)
- **index.tex**: Main research paper on ML-DSA implementation in IoT MQTT environments
- **iacrtrans.cls**: IACR Transactions journal class for TCHES/TOSC submissions
- **latexmkrc**: LaTeX compilation configuration with PDF mode and bibliography processing
- **biblio.bib**, **abbrev3.bib**: Bibliography files for cryptographic references
- **settings.tches.tex**, **settings.tosc.tex**: Journal-specific formatting settings

### Research Assets
- **downloads/**: Research papers and cryptographic bibliography files
- **utils/**: Empty utility directory for future tooling

## Document Compilation Details

The main research paper (`tex/index.tex`) is configured for:
- IACR Transactions on Cryptographic Hardware and Embedded Systems (TCHES)
- Focus on "Post-Quantum Authentication for IoT: Optimizing ML-DSA Digital Signatures in Resource-Constrained MQTT Environments"
- Authors: Jiahao Xiang, Lang Li (Hengyang Normal University)
- Keywords: Post-Quantum Cryptography, ML-DSA, Digital Signatures, MQTT Protocol, IoT Security, Resource-Constrained Devices

## Research Context

The project addresses NIST's post-quantum cryptography standards (FIPS 203, 204, 205) with specific focus on:
- ML-DSA (CRYSTALS-Dilithium based) implementation challenges
- IoT device resource constraints (ARM Cortex-M4 microcontrollers)
- MQTT protocol integration for post-quantum migration
- Performance analysis of signature generation/verification in constrained environments
- Hybrid classical-quantum authentication approaches