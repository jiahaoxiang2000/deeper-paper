# Post-Quantum Cryptography (PQC) Status and Implementation Analysis

## Algorithm Standardization Timeline

### Published Standards (August 13, 2024)

- **FIPS 203** - ML-KEM (Module-Lattice-Based Key-Encapsulation Mechanism) - Based on CRYSTALS-Kyber
- **FIPS 204** - ML-DSA (Module-Lattice-Based Digital Signature Algorithm) - Based on CRYSTALS-Dilithium
- **FIPS 205** - SLH-DSA (Stateless Hash-Based Digital Signature Algorithm) - Based on SPHINCS+

### In Development

- **FIPS 206** - FN-DSA (FALCON Digital Signature Algorithm) - Expected summer 2025

### Future Standardization

- **HQC KEM** - Selected March 11, 2025 (Hamming Quasi-Cyclic Key-Encapsulation Mechanism)
- **On-Ramp Digital Signatures** - 14 second-round candidates for additional signature diversity

## Current Status (as of June 2025)

### NIST Standardization Process

NIST has been conducting a multi-round standardization process for post-quantum cryptography since 2016. The process is now largely complete with several algorithms standardized.

### Approved FIPS Standards (August 13, 2024)

1. **FIPS 203** - Module-Lattice-Based Key-Encapsulation Mechanism Standard

   - Based on CRYSTALS-KYBER
   - Primary algorithm for key encapsulation

2. **FIPS 204** - Module-Lattice-Based Digital Signature Standard

   - Based on CRYSTALS-Dilithium
   - Primary algorithm for digital signatures

3. **FIPS 205** - Stateless Hash-Based Digital Signature Standard
   - Based on SPHINCS+
   - Alternative signature algorithm

### Recent Updates (2025)

- **March 11, 2025**: HQC (Hamming Quasi-Cyclic) was selected for standardization over BIKE
- **January 7, 2025**: Draft NIST SP 800-227 "Recommendations for KEMs" released
- **February 25-26, 2025**: NIST Workshop on Guidance for KEMs held
- **NIST IR 8545**: Status Report on the Fourth Round of the NIST Post-Quantum Cryptography Standardization Process available
- **NIST IR 8547**: "Transition to PQC Standards" - Initial public draft with migration timeline
- **FIPS 206 (FN-DSA/Falcon)**: Under development, expected by summer 2025
- **On-Ramp Signatures**: 14 second-round candidates selected from 50 submissions

## Complete PDF Analysis Summary

**From Full Content Review of Both Presentations:**

### 2024 Presentation: "Are We There Yet? PQC" (17 pages)

- Focused on final standardization steps and fourth round evaluation
- Detailed algorithm selection rationale and implementation considerations
- Timeline toward summer 2024 publication (successfully achieved)
- Early discussion of transition strategies and hybrid approaches

#### From "Are We There Yet? PQC" (2024)

Based on NIST's 2024 presentation:

**Algorithm Performance Characteristics**

**CRYSTALS-Kyber (FIPS 203)**

- KEM based on structured lattices
- Good all-around performance and security
- Smallest ciphertexts among KEMs

**CRYSTALS-Dilithium (FIPS 204)**

- Digital signature based on structured lattices
- Good all-around performance and security
- Relatively simple implementation
- NIST recommends as the primary signature algorithm

**Falcon**

- Digital signature based on structured lattices
- Smaller bandwidth but much more complicated implementation
- Standard development came after others due to complexity

**SPHINCS+ (FIPS 205)**

- Stateless hash-based digital signature
- Solid security foundation
- Performance not as competitive compared to Dilithium/Falcon

### March 2025 Presentation: "PQC: The Road Ahead" (25 pages)

- Comprehensive 8-year process overview (2016-2025)
- Final fourth round decisions and HQC selection details
- Extensive migration planning and crypto agility emphasis
- Standards ecosystem integration (IETF, ISO, ETSI)
- Future work priorities and ongoing challenges

### Key Implementation Research Areas Identified

1. **Algorithm-Specific Challenges**:

   - Falcon: Complex implementation despite smaller bandwidth
   - HQC vs BIKE: Performance trade-offs and security analysis maturity
   - Classic McEliece: Public key size limitations for practical deployment

2. **Integration Complexity**:

   - Protocol migration (TLS, IPSec, etc.)
   - Hybrid key establishment mechanisms
   - Testing and validation frameworks

3. **Performance Optimization**:

   - Cross-platform implementation variations
   - Hardware acceleration requirements
   - Memory and power consumption constraints

4. **Migration Strategy**:
   - Crypto agility implementation
   - Risk assessment frameworks
   - Timeline coordination across sectors

#### From "PQC: The Road Ahead" (March 2025)

Based on NIST's March 2025 presentation:

**FIPS 206 - FN-DSA (Falcon)**

- Hash-and-sign paradigm
- Smaller bandwidth and fast verification
- More complicated implementation than other algorithms
- Under development (expected by summer 2025)

**HQC Selection Rationale (March 11, 2025)**

- Selected over BIKE despite no clear performance winner
- HQC advantages:
  - Faster key generation and decapsulation
  - More mature analysis and security assurances
  - Better understood decryption failure rate analysis
- BIKE advantages:
  - Slightly faster encapsulation
  - Smaller key and ciphertext sizes
  - Recent decoder improvements announced

**Classic McEliece Decision**

- Not selected for standardization despite security confidence
- Challenges: Very large public keys (260KB to 1MB)
- Benefits: Small ciphertext sizes, fast operations
- Limited interest for practical deployment

**Migration Timeline (NIST IR 8547)**

- 112-bit security algorithms: Deprecated after 2030, disallowed after 2035
- 128-bit+ security algorithms: Disallowed after 2035
- Organizations may continue using 112-bit algorithms during PQC migration
- Covers RSA, ECDSA, EdDSA, DH, and MQV algorithms

**Draft NIST SP 800-227 - KEM Recommendations**

- Released January 7, 2025 (comment period ended March 7, 2025)
- Provides implementation and usage guidance for KEMs
- Includes hybrid key establishment guidance
- Workshop held February 25-26, 2025 for stakeholder feedback

**On-Ramp Signatures Progress**

- 14 candidates selected for second round (from 50 submissions)
- Algorithm categories: Multivariate, MPC-in-the-head, Lattice, Code-based, Symmetric, Isogeny
- Notable candidates: Mayo, UOV, HAWK, SQIsign, FAEST
- Focus on non-lattice alternatives to provide algorithmic diversity

## Implementation Considerations

**Standardization Approach**

- Standards follow thoroughly analyzed 3rd round specifications
- Minor tweaks to ensure successful implementation across various users
- Flexibility provided where appropriate
- Integration with existing cybersecurity ecosystem

**Key Implementation Challenges Identified**

- Integration with RNG and hash function standards
- Higher-level protocol compatibility
- Testing and validation procedures
- Feedback incorporation from implementers

**Open Issues**

- [Transition & Migration](https://www.nccoe.nist.gov/crypto-agility-considerations-migrating-post-quantum-cryptographic-algorithms)
  - Integration with existing cryptographic protocols [(Transport Layer Security (TLS) protocol and the Secure Shell (SSH) protocol and in hardware security modules (HSMs))](https://www.nccoe.nist.gov/sites/default/files/2023-12/pqc-migration-nist-sp-1800-38c-preliminary-draft.pdf)
  - **[Crypto agility](https://nvlpubs.nist.gov/nistpubs/CSWP/NIST.CSWP.39.ipd.pdf)** escribes the capabilities needed to replace and adapt cryptographic algorithms for protocols, applications, software, hardware, and infrastructures without interrupting the flow of a running system to achieve resiliency
