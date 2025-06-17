# Shaping the Glitch: Optimizing Voltage Fault Injection Attacks

> The original paper on [here](./paper/Shaping%20the%20Glitch_%20Optimizing%20Voltage%20Fault%20Injection%20Attacks.pdf)
> Bozzato C, Focardi R, Palmarini F. Shaping the glitch: optimizing voltage fault injection attacks[J]. IACR transactions on cryptographic hardware and embedded systems, 2019, 2019(2): 199-224.

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

## Preliminaries

**Voltage Fault Injection (V-FI).** The disturbances that are induced in the power supply line are called _voltage glitches or simply glitches_.
A glitch is a transient voltage drop with a _duration typically in the ns to μs range_, that occurs at a specific instant of time.
Glitch timing (also glitch trigger or trigger) is usually calculated as _a delay from a specific triggering event_ such as I/O activity or power-up.

MCUs integrate processor, flash memory and other peripherals in a single package.
However, some microcontrollers also integrate a voltage regulator for providing a fixed and stable power supply to the internal processor and memory, independently from the actual input voltage.

To reduce external interferences and minimize the power trace length, we directly soldered each MCU on a dedicated breakout board without decoupling capacitors; this PCB was then attached to the main glitch board through the pin header connector.

> details of the setup are in the paper Figure 1c.
> utils now, we find the major innovations use the DAC-based to replace MOS-FET-based glitch generator, which mean have one ability to generate arbitrary glitch waveforms.

## Arbitrary Waveform Voltage Glitch

Up to minor variations due to trace capacitance and impedance, the generated waveform is also repeatable and predictable and it is not influenced by the characteristics of the particular **MOS-FET transistor** in use, e.g., on-state _resistance, capacitance, rise and fall times_.

### Parameter Search and Optimization

The **search phase** is mandatory for designing and mounting an attack while the **optimization step** is subject to the specific requirements and complexity of the attack.
In the following, we describe a _semi-automated supervised search_ (cf. Section 3.1.1) and a fully _automated unsupervised search_ based on genetic algorithms (cf., Section 3.1.2).

#### Semi-Automated Supervised Search

First, we randomly generate and interpolate the set of $(x, y)$ points describing the candidate arbitrary glitch waveform.
Then, we iteratively select a random sample from each parameter interval and test the obtained combination.
This process is repeated and the results are manually evaluated, reducing the parameter space accordingly until one solution is found.

#### Fully Automated Unsupervised Search

It is designed over a classic genetic algorithm (GA) structure, where an initial population of candidate solutions (the attack parameters) is randomly sampled and an iterative process is responsible for finding a solution that maximizes a _fitness value_ $F$.

Specifically, the presented attacks exploit a single vulnerability, require a limited amount of glitches (≤ 100 k) and can be completed in a short time frame: from minutes to a few hours.

## Scattered-glitch Attack

**Attacker model.** We assume the attacker knows the MCU model under attack and has physical access to the target device.
She has the ability to inspect the bootloader code in order to identify a suitable instruction to fault.

### Case Study 1: STMicroelectronics

#### STM32 F103xx

**Attack.** We easily _bypass_ this protection mechanism by attacking the **Read Memory command**.
After the user requests a read operation, the CPU checks the RDP value and returns the positive (ACK) or negative (NACK) response.
By injecting a fault during the RDP checking phase, the bootloader can be deceived into returning an ACK despite the active read protection mechanism.
Thus, it is enough to issue a Read Memory command over a memory block followed by a voltage glitch, and repeat this until an ACK is received and the content of the selected memory block is returned.
The attack is then iterated over the subsequent memory blocks.

### Experimental Results and Considerations

| Device       | Extraction time | Total glitches | Successes | Parameter search | Repeatability |
| ------------ | --------------- | -------------- | --------- | ---------------- | ------------- |
| STM32F103    | 1 m (128 kB)    | 9k             | 5%        | 20 m             | High          |
| STM32F373\*  | N/A             | ~25            | ~4%       | 2h               | Moderate      |
| MSP430F5172  | 16 m (32 kB)    | 34k            | 98%       | 1h               | High          |
| MSP430FR5725 | 50 m (8 kB)     | 100k           | 8%        | 3h               | Moderate      |
