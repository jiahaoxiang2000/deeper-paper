# Shaping the Glitch: Optimizing Voltage Fault Injection Attacks

> The original paper on [here](./paper/Shaping%20the%20Glitch_%20Optimizing%20Voltage%20Fault%20Injection%20Attacks.pdf)

## Abstract

The attack typically aims at skipping security checks or generating side-channels that gradually _leak sensitive data_, including the firmware code.

- In this paper we propose a new voltage fault injection technique that generates fully arbitrary voltage glitch waveforms using off-the-shelf and _low cost equipment_.
- Among the presented attacks, the most challenging ones exploit multiple vulnerabilities and inject over one _million glitches_, heavily leveraging on the performance and repeatability of the new proposed technique.
- We perform a thorough evaluation of arbitrary glitch waveforms by comparing the attack performance against two other major _V-FI techniques_ in the literature.

## Introduction

In the former, the number of successful faults required is from low to moderate (≤ 100 k) with a straightforward attack logic. On the contrary, the second class represents particularly challenging attacks that require several days to complete, exploit multiple vulnerabilities and inject over one million glitches.

**Related Work.**

- In [ABF+ 02], authors combined voltage fault injection and power analysis to compromise the confidentiality of cryptographic computations and suggested possible countermeasures.
- The power supply fault injection mechanism has been extensively studied and explained as the result of _setup time violations in the combinatorial logic_ [SGD08, SBGD11, ZDC+ 12, ZDCR14].
- in [Goo08] Goodspeed defeated the password protection mechanism found in older Texas Instruments MSP430 microcontrollers. The author used a timing-based side-channel attack to exploit an unbalanced code in the password check routine and, by using voltage glitching, he bypassed the security feature that allows for disabling the serial bootloader
- (BSL) completely.

**Contributions.**

- We investigate the effect of different glitch waveforms in the setting of voltage fault injection attacks and, in particular, we propose a new method for the generation of _arbitrary glitch waveforms_ using a low-cost and software-managed setup;
- we report on unpublished vulnerabilities and weaknesses in six microcontrollers from three major manufacturers: STMicroelectronics, Texas Instruments and Renesas Electronics. We combine these vulnerabilities and describe the attacks for extracting the firmware from the internal read-protected flash memory.
- we evaluate the attack performance of our method by comparing the speed, efficiency and reliability of our solution against two popular V-FI techniques.
