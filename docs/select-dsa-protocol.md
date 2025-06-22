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

   - **Rowhammer Attack [4]**: Single bit flip can recover full key with few hundred million signatures
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

### Option 3: ML-DSA + MQTT (IoT-Focused Research)

**Best for IoT and resource-constrained environments**

#### Rationale:

- Growing importance of IoT security
- Limited existing research in this area
- Practical relevance for industrial applications
- Novel optimization opportunities

#### Research Opportunities:

- Resource optimization techniques
- Certificate-less authentication approaches
- Hybrid classical-quantum strategies for IoT
- Protocol-specific optimizations

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

The research should focus on practical implementation challenges, performance optimization techniques, and security hardening measures that advance the state-of-the-art in post-quantum protocol migration.

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
