# Anti-Fault Attack CoDesign

> [paper pdf file](./paper/Fault-Resistant%20Partitioning%20of%20Secure%20CPUs%20for%20System%20Co-Verification%20against%20Faults.pdf)
>
> Tollec S, Hadži V, Nasahl P, et al. Fault-resistant partitioning of secure cpus for system co-verification against faults[J]. IACR Transactions on Cryptographic Hardware and Embedded Systems, 2024, 2024(4): 179-204.

## Abstract

However, current formal methodologies combining hardware and software face scalability issues due to the monolithic approach used.

To address this challenge, this work formalizes the _k-fault-resistant partitioning_ notion to solve the fault propagation problem when assessing _redundancy-based hardware countermeasures_ in a first step.
Proven security guarantees can then reduce the remaining hardware attack surface when introducing the software in a second step.

Then, we apply our methodology to the OpenTitan secure element and _formally prove_ the security of its CPU’s hardware countermeasure to single _bit-flip injections_.

## Introduction

An adversary exploiting this faulty behavior can attack cryptographic primitives [BDL97, BS97, TMA11, DEK+18], bypass secure boot [VTM+ 17, dHOGT21], or gain full malicious code execution on a device [NT19].

Countermeasures like _Concurrent Error Detection (CED)_ schemes are deployed at the hardware level, while software countermeasures implement protections like _control-flow integrity_ [BEMP20, NSL+ 23] or _instruction duplication_ [BBK+ 10].
Since the fault security of a chip is based on these countermeasures, the correctness and effectiveness of the combination must be ensured.

**Evaluation of System Security**. Common security evaluation approaches include penetration testing, which requires a physical chip sample, is _costly, time-consuming, and whose results highly depend on the fault injection setup_. _Simulation or formal verification tools_ are used to evaluate pre-silicon security and improve fault coverage.

On the one hand, pre-silicon frameworks at the circuit level, such as FIVER [RSS+21] and SYNFI [NOV+22], analyze the resilience of a design’s gate-level netlist against fault attacks.
On the other hand, software-oriented fault injection frameworks [PMPD14, HSP21, DBP23, **KR23**] focus on efficiently evaluating the robustness of software countermeasures.

**Contribution.** We also propose an algorithm to find and prove such _k-fault partitions_. The outputs of this hardware analysis step are areas of the studied processor with its countermeasures where the invariant does not hold. These verification results allow to restrict the fault injections we consider when the software is introduced to analyze whether remaining hardware fault locations can lead to software vulnerabilities.
