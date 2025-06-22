# Post-Quantum Cryptography Migration Protocol

## Summary of NCCoE SP 1800-38C Migration Protocol

This document summarizes the key findings and protocols for migrating to post-quantum cryptography (PQC) based on NIST Special Publication 1800-38C "Migration to Post-Quantum Cryptography: Quantum Readiness Testing Draft Standards" Volume C.

### Protocol Testing Overview

The NCCoE project conducted extensive interoperability and performance testing of pre-standardized PQC algorithms across multiple protocols and use cases to support organizational migration efforts.

**Tested Protocols:**

- Transport Layer Security (TLS) 1.3
- Secure Shell (SSH)
- QUIC
- X.509 Certificates
- Hardware Security Modules (HSMs)

**PQC Algorithms Tested:**

- **Key Encapsulation Mechanism (KEM):** CRYSTALS-Kyber (512, 768, 1024)
- **Digital Signatures:** CRYSTALS-Dilithium (2, 3, 5), Falcon (512, 1024), SPHINCS+ variants
- **Hash-based Signatures:** LMS/HSS, XMSS/XMSSMT (for HSMs)

## Protocol-Specific Findings

### TLS 1.3 Migration

**Interoperability Results:**

- **High Success Rate:** All tested implementations (OQS-OpenSSL, wolfSSL, AWS s2n-tls, Samsung SDS PQC-TLS) achieved successful interoperability
- **Hybrid Key Exchange:** P256+Kyber-512, P384+Kyber-768, P521+Kyber-1024 combinations worked across all vendors
- **Pure PQC:** Kyber-only implementations showed excellent compatibility

**Performance Characteristics:**

- **Kyber Efficiency:** Kyber performs competitively with classical ECDH, often outperforming P384 and P521
- **Hybrid Impact:** Combined classical+PQC approaches show modest slowdown (typically 2x for P256+Kyber-512)
- **Network Resilience:** Performance impact minimal even under 3% packet loss conditions
- **Handshake Rates:**
  - Pure Kyber-768: ~681 handshakes/second
  - P384-Kyber-768 hybrid: ~184 handshakes/second
  - Classical P384: ~223 handshakes/second

### SSH Migration

**Key Findings:**

- **Protocol Advantage:** SSH's multi-round-trip design minimizes PQC impact
- **Hybrid Methods:** P256+Kyber-512 showed universal interoperability across implementations
- **Performance:** Negligible impact due to SSH's inherent round-trip overhead
- **Implementation Status:** Limited PQC authentication support (only OQS-OpenSSH at time of testing)

### QUIC Migration

(Quick UDP Internet Connection) was designed to make the web faster and more efficient.

**Critical Challenges:**

- **Amplification Protection:** Large Dilithium certificates (18-22 KB) trigger extra round-trips
- **Congestion Control:** Initial congestion window limitations cause additional delays
- **Packet Pacing:** Default 333ms initial RTT estimate adds 65ms delay
- **Authentication Impact:** Post-quantum signatures more significantly affect QUIC than key exchange

**Mitigation Strategies:**

- Increase amplification window from 3.6 KB to 20+ KB
- Raise initial congestion window from 14 KB to 25+ KB
- Use realistic initial RTT estimates (50ms vs. 333ms default)
- Consider certificate compression or intermediate CA omission

### X.509 Certificate Formats

**Tested Certificate Types:**

1. **Pure PQC:** Traditional X.509 structure with PQC algorithms only
2. **Hybrid Concatenated:** Combined classical+PQC in single algorithm field
3. **Hybrid Bound:** Separate certificates with authenticated linking
4. **Hybrid Composite:** ASN.1 structured separation of algorithms
5. **Hybrid Catalyst:** PQC data in X.509 extensions
6. **Hybrid Chameleon:** Delta encoding between certificate variants

**Interoperability:** All formats showed good compatibility across vendor implementations through IETF PQC Hackathon testing.

### Hardware Security Module (HSM) Migration

**Vendor Participation:** Crypto4A, Entrust, Thales DIS, Thales TCT, Utimaco

**Capability Coverage:**

- **Key Generation:** High success across Kyber, Dilithium, Falcon, SPHINCS+, hash-based signatures
- **Cross-Vendor Compatibility:** Excellent interoperability for key import/export, signature verification, KEM operations
- **Identified Issues:** Minor incompatibility with Entrust SPHINCS+ SHA2 variants

**Testing Results:**

- **Key Import/Export:** >95% success rate across vendor combinations
- **Signature Verification:** Nearly universal compatibility
- **KEM Operations:** Full interoperability for all Kyber variants

## Migration Lessons Learned

### Implementation Challenges

1. **Draft Standard Evolution:**

   - Early implementations face compatibility issues as specifications evolve
   - Temporary algorithm identifiers needed during standardization
   - Backwards compatibility breaking changes require versioned approaches

2. **API Integration:**

   - Traditional cryptographic APIs assume digest-then-sign workflows
   - PQC signatures operate on full messages, requiring API updates
   - PKCS#11 incremental interfaces need careful handling for large messages

3. **Performance Considerations:**
   - Kyber key exchange shows minimal performance impact
   - PQC authentication (signatures) more significantly affects protocols
   - Large certificate chains can trigger additional network round-trips

### Best Practices

1. **Algorithm Selection:**

   - Kyber-768 offers good security/performance balance for most uses
   - Dilithium-3 suitable for general-purpose signatures
   - Consider hybrid approaches for transition period

2. **Protocol Optimization:**

   - Tune network parameters for large PQC authentication data
   - Implement certificate compression where possible
   - Plan for increased bandwidth and latency in authentication scenarios

3. **Testing Strategy:**
   - Extensive interoperability testing essential before deployment
   - Performance testing under various network conditions
   - Cross-vendor compatibility validation

## Open Issues and Future Work

### Remaining Challenges

1. **Limited Protocol Coverage:**

   - DTLS, MQTT, IKEv2/IPsec require additional testing
   - Firmware signing and IoT applications need evaluation

2. **Authentication Migration:**

   - Less industry consensus on hybrid authentication approaches
   - Performance impact more significant than key exchange

3. **Certificate Management:**
   - Multiple hybrid certificate formats create deployment complexity
   - Need for standardized approaches to certificate discovery and validation

### Research Directions

1. **Performance Optimization:**

   - Algorithm-specific optimizations for constrained environments
   - Network protocol adaptations for large PQC signatures

2. **Migration Strategies:**

   - Automated discovery and inventory tools
   - Risk assessment frameworks for transition timing

3. **Integration Testing:**
   - Real-world deployment scenarios
   - Supply chain readiness assessment

## Conclusion

The NCCoE testing demonstrates that migration to post-quantum cryptography is technically feasible with current draft standards. Key exchange migration (using Kyber) shows minimal performance impact and excellent interoperability. Authentication migration presents greater challenges due to larger signature sizes but remains manageable with proper protocol tuning and network optimization.

Organizations should begin preparation for PQC migration by:

1. Conducting cryptographic inventory
2. Testing PQC implementations in non-production environments
3. Engaging with vendors on PQC readiness roadmaps
4. Planning for hybrid approaches during transition period

The foundation established by this testing provides confidence that widespread PQC deployment is achievable once NIST standards are finalized.

---

_Document based on NIST SP 1800-38C: Migration to Post-Quantum Cryptography Quantum Readiness: Testing Draft Standards, Volume C (December 2023)_
