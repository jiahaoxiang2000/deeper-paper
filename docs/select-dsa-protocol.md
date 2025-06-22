# Post-Quantum Digital Signature Algorithm (DSA) and Network Protocol Selection Analysis

## Executive Summary

Based on IACR research from 2022-2025 and NIST FIPS 204-206 standards, this document analyzes the three standardized post-quantum digital signature algorithms and suitable network protocols for implementation research.

## Post-Quantum DSA Options (FIPS 204-206)

### 1. ML-DSA (FIPS 204) - Module-Lattice-Based Digital Signature Algorithm

**Based on CRYSTALS-Dilithium**

#### Key Characteristics:

- **Security Foundation**: Module Learning With Errors (M-LWE) problem over polynomial rings
- **Primary NIST Recommendation**: Designated as the main post-quantum signature algorithm
- **Performance**: Good all-around performance and security balance
- **Implementation**: Relatively simple compared to alternatives
- **Signature Sizes**: Moderate (larger than classical but smaller than hash-based)

#### Recent Research Findings (2022-2025):

1. **GPU Acceleration Research [1]**:
   - cuML-DSA achieves 170.7× to 294.2× speedup on server GPUs
   - Introduces depth-prior sparse ternary polynomial multiplication optimization
   - Branch elimination method for high-throughput servers
   - Critical for server environments requiring high signing throughput

#### Advantages:

- NIST's primary recommendation
- Balanced performance characteristics
- Mature security analysis
- Good implementation experience base

#### Disadvantages:

- Larger signatures than classical schemes
- Module lattice assumption (relatively new)

### 2. SLH-DSA (FIPS 205) - Stateless Hash-Based Digital Signature Algorithm

**Based on SPHINCS+**

#### Key Characteristics:

- **Security Foundation**: Hash function security (conservative foundation)
- **Stateless**: No need for state management unlike other hash-based schemes
- **Performance**: Slower than lattice-based alternatives
- **Signature Sizes**: Very large signatures

#### Recent Research Findings (2022-2025):

1. **Hardware Acceleration [2]**:

   - SLotH implementation achieves up to 300× speedup with specialized hardware
   - SHAKE variants: 4,903,978 cycles for 128f signature generation
   - SHA2 variants: approximately half the speed of SHAKE
   - Verification performance competitive with accelerated ECDSA/Dilithium

2. **Parameter Optimization [3]**:
   - New simplified security strength formula for parameter selection
   - Better understanding of security degradation with signature count
   - Enables more precise parameter tuning

#### Advantages:

- Most conservative security foundation (hash functions)
- No complex mathematical assumptions
- Stateless design simplifies implementation
- Good verification performance when accelerated

#### Disadvantages:

- Very large signature sizes
- Slow signing without hardware acceleration
- Limited practical deployment scenarios

### 3. FN-DSA (FIPS 206) - FALCON Digital Signature Algorithm

**Based on FALCON over NTRU lattices**

#### Key Characteristics:

- **Security Foundation**: NTRU lattice problems
- **Performance**: Smallest signatures, fast verification
- **Implementation**: Most complex due to floating-point requirements
- **Status**: Under development, expected summer 2025

#### Recent Research Findings (2022-2025):

1. **Security Vulnerabilities Discovered**:

   - **Rowhammer Attack [4] ⚠️**: Single bit flip can recover full key with few hundred million signatures
   - **Floating-Point Sensitivity [5]**: Small floating-point errors can cause key leakage
   - **Side-Channel Vulnerabilities [6]**: Power analysis attacks on Gaussian samplers

2. **Implementation Improvements**:
   - **Constant-Time Key Generation [7]**: Eliminates floating-point operations in key generation
   - **Compact Signatures [8]**: 30-40% signature size reduction techniques
   - **Alternative Samplers [9]**: Mitaka variant offers simpler, parallelizable implementation

#### Advantages:

- Smallest signature sizes among post-quantum schemes
- Fast verification
- Compact public keys
- NTRU lattice foundation

#### Disadvantages:

- Most complex implementation
- Floating-point arithmetic requirements
- Recent security vulnerabilities discovered
- Still under standardization (FIPS 206 pending)

## Network Protocol Analysis for Post-Quantum DSA Integration

### 1. Transport Layer Security (TLS) Protocol

**Primary Recommendation for Research**

#### Research Status (2022-2025):

1. **Comprehensive Performance Studies**:

   - TLS 1.3 post-quantum implementations widely studied
   - Performance impact well characterized across different network conditions
   - Packet loss rates above 3-5% significantly impact large signature schemes

2. **Implementation Maturity**:

   - Multiple working implementations (OpenSSL, s2n, etc.)
   - Hybrid approaches (classical + post-quantum) well-developed
   - Integration with major cryptographic libraries (liboqs)

3. **Real-World Deployment**:
   - Google and Cloudflare have conducted large-scale experiments
   - Proven feasibility for internet-scale deployment
   - Good understanding of network overhead implications

#### Protocol Characteristics:

- **Handshake Impact**: Certificate sizes directly affect handshake performance
- **Fragmentation Issues**: Large signatures may fragment across multiple packets
- **Hybrid Support**: Well-developed hybrid cryptography support
- **Industrial Adoption**: Widely used in enterprise and consumer applications

### 2. Secure Shell (SSH) Protocol

**Secondary Option for Research**

#### Research Status:

- Post-quantum integration studied alongside TLS
- OpenSSH implementations available
- Less comprehensive performance analysis than TLS

#### Protocol Characteristics:

- **Interactive Nature**: Different performance requirements than TLS
- **Long-lived Connections**: Less frequent handshakes than web protocols
- **Key Exchange Focus**: Primarily studies focus on key exchange rather than authentication

### 3. MQTT Protocol (IoT Focus)

**Emerging Research Area**

#### Recent Research (2025):

1. **KEM-MQTT Implementation [10]**:
   - Novel approach avoiding post-quantum signatures entirely
   - Uses KEMTLS approach for mutual authentication
   - Optimized for resource-constrained 8-bit AVR devices
   - 4.32 seconds handshake preparation on 8-bit AVR with Kyber-512

#### Protocol Characteristics:

- **Resource Constraints**: Critical for IoT deployments
- **Lightweight Requirements**: Signature size particularly important
- **Limited Research**: Post-quantum migration largely unexplored
- **Growing Importance**: Increasingly important for IoT security

## Recommended DSA and Protocol Combinations

### Option 1: ML-DSA + TLS (Primary Recommendation)

**Best for comprehensive research and practical deployment**

#### Rationale:

- ML-DSA is NIST's primary recommendation
- TLS has the most mature post-quantum research base
- Balanced performance characteristics
- Strong implementation ecosystem
- GPU acceleration possibilities for server environments

#### Research Opportunities:

- Certificate chain optimization
- Hybrid authentication strategies
- Performance optimization techniques
- Network condition impact analysis

### Option 2: FN-DSA + TLS (High-Impact Research)

**Best for compact signature research with security considerations**

#### Rationale:

- Smallest signatures among post-quantum schemes
- Significant recent security findings provide research opportunities
- Implementation challenges offer novel solutions
- FIPS 206 development timeline aligns with research schedule

#### Research Opportunities:

- Security hardening against discovered vulnerabilities
- Floating-point arithmetic alternatives
- Side-channel countermeasures
- Implementation simplification techniques

### Option 3: ML-DSA + IoT Protocols (Resource-Constrained Research)

**Best for IoT and resource-constrained environments with novel research opportunities**

#### Current Research Landscape (2022-2025):

While direct ML-DSA IoT protocol integration research is limited, several foundational studies provide crucial insights:

1. **Embedded System Performance Benchmarking [24]**:

   - Comprehensive evaluation of post-quantum algorithms including Dilithium on ARM Cortex-M4
   - Integration with pqm4 benchmarking framework for microcontroller evaluation
   - Performance analysis on STM32L4R5ZI with 640 KB RAM and 180 MHz clock
   - First systematic evaluation of all NIST PQC candidates on resource-constrained devices

2. **Side-Channel Security Research [25]**:

   - Systematic analysis of vulnerabilities in Kyber and Dilithium on ARM Cortex-M4
   - Custom countermeasures for simultaneous SCA/FIA protection
   - Performance overhead evaluation of security measures on microcontrollers
   - Critical insights for secure IoT deployment

3. **Domain-Specific Acceleration [26]**:
   - Hardware acceleration strategies for lattice-based signatures on resource-constrained devices
   - 24% and 47% performance improvements for sign/verify operations
   - Energy-delay product improvements of 44% and 67%
   - Demonstrates feasibility of efficient post-quantum signatures on IoT platforms

#### Alternative IoT Protocol Approaches:

**KEM-Based Protocols [10]**: Recent breakthrough research shows KEMTLS approach for MQTT eliminates need for post-quantum signatures entirely, achieving 4.32-second handshake on 8-bit AVR devices.

**Lightweight Identification [27]**: Lattice-based identification protocols specifically designed for IoT and smart card applications, avoiding signature overhead while maintaining security.

#### Research Gaps and Opportunities:

**Critical Research Needs**:

- Direct ML-DSA integration with IoT protocols (MQTT, CoAP, 6LoWPAN)
- Certificate chain optimization for resource-constrained environments
- Hybrid authentication strategies balancing security and performance
- Protocol-specific optimizations leveraging IoT communication patterns

**Novel Optimization Opportunities**:

- Memory-efficient signature verification techniques
- Adaptive security levels based on device capabilities
- Batch verification for sensor networks
- Energy-optimized signature operations for battery-powered devices

#### Implementation Challenges:

**Resource Constraints**:

- Limited RAM/Flash memory on IoT microcontrollers
- Computational overhead of lattice operations
- Energy consumption impact on battery life
- Real-time response requirements

**Protocol Integration Issues**:

- Certificate size impact on constrained network bandwidth
- Fragmentation handling for large signatures
- Protocol overhead in resource-limited environments
- Interoperability with existing IoT infrastructure

#### Rationale for ML-DSA + IoT Research:

- **Unexplored Territory**: Limited research on direct ML-DSA IoT protocol integration
- **NIST Standardization**: ML-DSA as primary post-quantum signature standard
- **Growing IoT Security Needs**: Increasing importance of quantum-resistant IoT security
- **Performance Optimization Potential**: Significant opportunities for novel optimizations
- **Real-World Impact**: Direct relevance to industrial and consumer IoT applications

#### Research Opportunities:

- **Resource Optimization Techniques**: Memory and computation efficient ML-DSA implementations
- **Certificate-less Authentication**: Alternative authentication methods reducing signature overhead
- **Hybrid Classical-Quantum Strategies**: Gradual migration approaches for existing IoT infrastructure
- **Protocol-Specific Optimizations**: Leveraging IoT communication patterns for efficiency gains
- **Cross-Layer Security**: Integration of signature schemes with IoT protocol stacks
- **Energy-Aware Implementations**: Battery life optimization for mobile IoT devices

## Implementation Considerations

### Certificate Chain Impact:

- Post-quantum signatures significantly increase certificate sizes
- TLS handshake performance directly affected by certificate chain length
- Root CA certificate caching strategies become critical
- Intermediate CA elimination techniques important

### Network Performance Factors:

- Packet loss rates above 3-5% significantly impact large signature schemes
- Network latency can hide computational overhead
- Fragmentation across multiple packets affects reliability
- Hybrid approaches provide migration flexibility

### Security Migration Strategies:

- Hybrid classical-quantum approaches recommended for transition
- Algorithm agility essential for future transitions
- Side-channel protection increasingly important
- Hardware acceleration beneficial for server deployments

## Conclusion

**Primary Recommendation**: ML-DSA with TLS protocol provides the best balance of research value, practical relevance, and implementation feasibility. The combination offers mature research foundation while providing opportunities for novel optimizations and real-world impact.

**Alternative High-Impact Option**: FN-DSA with TLS offers significant research opportunities in security hardening and implementation optimization, particularly relevant given recent vulnerability discoveries and pending FIPS 206 standardization.

**Emerging High-Value Research Area**: ML-DSA with IoT protocols represents a largely unexplored research domain with significant potential impact. While foundational research on post-quantum cryptography in embedded systems exists [24,25,26], direct integration of ML-DSA with IoT protocols (MQTT, CoAP, 6LoWPAN) remains an open research challenge. This area offers opportunities for:

- **Novel Resource Optimization**: Developing memory and computation efficient ML-DSA implementations specifically for IoT constraints
- **Protocol Innovation**: Creating certificate-less or lightweight authentication mechanisms
- **Real-World Impact**: Addressing the growing security needs of industrial and consumer IoT deployments
- **Cross-Layer Security**: Integrating post-quantum signatures with IoT protocol stacks

The research should focus on practical implementation challenges, performance optimization techniques, and security hardening measures that advance the state-of-the-art in post-quantum protocol migration, with particular attention to the resource constraints and communication patterns unique to IoT environments.

## References

[1] **cuML-DSA: Optimized Signing Procedure and Server-Oriented GPU Design for ML-DSA** (2023/1522)  
 IACR ePrint Archive: https://eprint.iacr.org/2023/1522  
 Keywords: post-quantum cryptography, digital signature, ML-DSA, sparse polynomial multiplication, GPU acceleration

[2] **Accelerating SLH-DSA by Two Orders of Magnitude with a Single Hash Unit** (2024/367)  
 IACR ePrint Archive: https://eprint.iacr.org/2024/367  
 Keywords: FIPS 205, SLH-DSA, SPHINCS+, Root-of-Trust, Side-Channel Security

[3] **Smaller Sphincs$^{+}$** (2024/018)  
 IACR ePrint Archive: https://eprint.iacr.org/2024/018  
 Keywords: Postquantum Signatures, Sphincs+, SLH-DSA, FIPS 205, Stateless Hash-based Signatures

[4] **Crowhammer: Full Key Recovery Attack on Falcon with a Single Rowhammer Bit Flip** (2025/1042)  
 IACR ePrint Archive: https://eprint.iacr.org/2025/1042  
 Keywords: Falcon, Rowhammer, Fault Attacks, Lattice-Based Signatures, Statistical Learning

[5] **Do Not Disturb a Sleeping Falcon: Floating-Point Error Sensitivity of the Falcon Sampler and Its Consequences** (2024/1709)  
 IACR ePrint Archive: https://eprint.iacr.org/2024/1709  
 Keywords: Falcon, Lattice-Based Cryptography, Floating-Point Arithmetic, Hash-and-Sign Signatures, NTRU

[6] **Thorough Power Analysis on Falcon Gaussian Samplers and Practical Countermeasure** (2025/351)  
 IACR ePrint Archive: https://eprint.iacr.org/2025/351  
 Keywords: Lattice-Based Cryptography, Side-Channel Analysis, Falcon Signature Scheme, Gaussian Sampler, NTRU

[7] **Improved Key Pair Generation for Falcon, BAT and Hawk** (2023/290)  
 IACR ePrint Archive: https://eprint.iacr.org/2023/290  
 Keywords: BAT, Falcon, Hawk, NTRU key pair generation

[8] **Shorter Hash-and-Sign Lattice-Based Signatures** (2022/785)  
 IACR ePrint Archive: https://eprint.iacr.org/2022/785  
 Keywords: Hash-and-sign, lattice-based cryptography, cryptanalysis

[9] **Mitaka: a simpler, parallelizable, maskable variant of Falcon** (2021/1486)  
 IACR ePrint Archive: https://eprint.iacr.org/2021/1486  
 Keywords: lattice-based cryptograpgy, signature schemes, Gaussian sampling, masking

[10] **An Optimized Instantiation of Post-Quantum MQTT protocol on 8-bit AVR Sensor Nodes** (2025/563)  
 IACR ePrint Archive: https://eprint.iacr.org/2025/563  
 Keywords: Post-Quantum Cryptography, Crystals-Kyber, ML-KEM, MQTT, 8-bit AVR, KEMTLS

### Additional TLS and Protocol Research References

[11] **Benchmarking Post-Quantum Cryptography in TLS** (2019/1447)  
 IACR ePrint Archive: https://eprint.iacr.org/2019/1447  
 Keywords: post-quantum key exchange, post-quantum authentication, Transport Layer Security (TLS), network performance, emulation

[12] **Prototyping post-quantum and hybrid key exchange and authentication in TLS and SSH** (2019/858)  
 IACR ePrint Archive: https://eprint.iacr.org/2019/858  
 Keywords: post-quantum cryptography, TLS, SSH

[13] **Performance Evaluation of Post-Quantum TLS 1.3 on Resource-Constrained Embedded Systems** (2021/1553)  
 IACR ePrint Archive: https://eprint.iacr.org/2021/1553  
 Keywords: implementation, embedded systems, public-key cryptography, post-quantum cryptography, digital signatures, TLS, TLS 1.3, network reliability

[14] **Towards Post-Quantum Security for Cyber-Physical Systems: Integrating PQC into Industrial M2M Communication** (2021/1563)  
 IACR ePrint Archive: https://eprint.iacr.org/2021/1563  
 Keywords: cyber-physical systems, post-quantum cryptography, formal security models, OPC UA, ProVerif

[15] **Proof-of-possession for KEM certificates using verifiable generation** (2022/703)  
 IACR ePrint Archive: https://eprint.iacr.org/2022/703  
 Keywords: public key infrastructure, certificates, key encapsulation mechanisms, proof of possession, zero knowledge proofs

### Additional Research References

[16] **A Closer Look at Falcon** (2024/1769)  
 IACR ePrint Archive: https://eprint.iacr.org/2024/1769  
 Keywords: Signatures, Falcon, GPV, Renyi

[17] **Cryptanalysis of the Peregrine Lattice-Based Signature Scheme** (2023/1628)  
 IACR ePrint Archive: https://eprint.iacr.org/2023/1628  
 Keywords: Cryptanalysis, Lattice-based signature, Statistical learning, NTRU

[18] **Antrag: Annular NTRU Trapdoor Generation** (2023/1335)  
 IACR ePrint Archive: https://eprint.iacr.org/2023/1335  
 Keywords: Post-quantum cryptography, Hash-and-sign lattice-based signatures, NTRU trapdoors, Discrete Gaussian sampling

[19] **Compact Lattice Gadget and Its Applications to Hash-and-Sign Signatures** (2023/729)  
 IACR ePrint Archive: https://eprint.iacr.org/2023/729  
 Keywords: Lattice-based cryptography, Lattice gadgets, Lattice signatures

[20] **BAT: Small and Fast KEM over NTRU Lattices** (2022/031)  
 IACR ePrint Archive: https://eprint.iacr.org/2022/031  
 Keywords: Lattice-based cryptography, NTRU, KEM, Falcon

### NIST Standards References

[21] **FIPS 204: Module-Lattice-Based Digital Signature Standard** (2024)  
 NIST Federal Information Processing Standards Publication 204  
 Based on CRYSTALS-Dilithium

[22] **FIPS 205: Stateless Hash-Based Digital Signature Standard** (2024)  
 NIST Federal Information Processing Standards Publication 205  
 Based on SPHINCS+

[23] **FIPS 206: FN-DSA Standard** (Expected 2025)  
 NIST Federal Information Processing Standards Publication 206  
 Based on FALCON (Under development)

### IoT and Embedded Systems Research References

[24] **pqm4: Benchmarking NIST Additional Post-Quantum Signature Schemes on Microcontrollers** (2024/112)  
 IACR ePrint Archive: https://eprint.iacr.org/2024/112  
 Keywords: pqm4, NISTPQC, Arm Cortex-M4, microcontrollers, benchmarking

[25] **Side-channel and Fault-injection attacks over Lattice-based Post-quantum Schemes (Kyber, Dilithium): Survey and New Results** (2022/737)  
 IACR ePrint Archive: https://eprint.iacr.org/2022/737  
 Keywords: Lattice-based Cryptography, Side-Channel Attacks, Fault-Injection Attacks, Kyber, Dilithium, Countermeasures

[26] **Domain-specific Accelerators for Ideal Lattice-based Public Key Protocols** (2018/608)  
 IACR ePrint Archive: https://eprint.iacr.org/2018/608  
 Keywords: Public Key Cryptography, Post-quantum Cryptography, Lattice-based Cryptography, Ideal Lattices, Key Exchange, Digital Signature, System on Chip, Domain Specific Acceleration, Cache Architecture

[27] **A Lightweight Identification Protocol Based on Lattices** (2023/222)  
 IACR ePrint Archive: https://eprint.iacr.org/2023/222  
 Keywords: Lattice-Based Cryptography, Identification Protocol, Post-Quantum Cryptography, LWE

[28] **Saber on ARM CCA-secure module lattice-based key encapsulation on ARM** (2018/682)  
 IACR ePrint Archive: https://eprint.iacr.org/2018/682  
 Keywords: Key encapsulation scheme, post-quantum cryptography, lattice-based cryptography, efficient software, Saber

[29] **Exploiting Determinism in Lattice-based Signatures - Practical Fault Attacks on pqm4 Implementations of NIST candidates** (2019/769)  
 IACR ePrint Archive: https://eprint.iacr.org/2019/769  
 Keywords: Deterministic Lattice Signatures, pqm4, Fault Attack, Lattice-based Cryptography, Dilithium, qTESLA

[30] **Optimized One-Dimensional SQIsign Verification on Intel and Cortex-M4** (2024/1563)  
 IACR ePrint Archive: https://eprint.iacr.org/2024/1563  
 Keywords: post-quantum cryptography, isogeny, SQIsign, verification, ARM
