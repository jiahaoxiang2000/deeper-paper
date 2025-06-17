# Fault Injection Attacks

Fault injection attacks are a type of security vulnerability that exploit the behavior of a system when it is subjected to unexpected or erroneous conditions. These attacks can be used to manipulate the execution of a program extract sensitive information.

## Find the Fault Injection Points

First, we identify the potential injection points. As shown in Figure 1, we capture the $A$ channel from the DC power supply, which represents the chip's operating power. The $B$ channel corresponds to the AES encryption trigger signal. From the figure, we observe that the approximate running time for the rising edge of the trigger—corresponding to around the 9th round—is close to 4.405ms.

![Fault Injection Attack](./fig/FaultPoint.png)
_Figure 1: Captured waveforms for fault injection point analysis._

## Fault Injection Attack on Voltage Glitch

To perform the fault injection, we use a _voltage glitch attack_. Figure 2 shows the setup for this attack. We attempted more than 50 voltage glitches during the AES encryption process, targeting the period close to the 9th round. In the figure, the blue line drops sharply, indicating the voltage levels during the glitches. Despite these attempts, we did not observe any erroneous ciphertext output, meaning the fault injection was _not successful_.

![Figure 2](./fig/AttackInject.png)
_Figure 2: Fault injection attack on AES encryption._

## Fault Injection Devices

The **fault injection setup** consists of three main components, as shown in Figure 3. On the left side of the figure, the black board is our _target device_, which is the STM32F303 chip. On the right side, the top black box is the _voltage glitch device_, used to inject voltage glitches into the target device. The bottom blue box on the right is the _oscilloscope_, which captures the waveforms during the fault injection process.

![Figure 3](./fig/fault_device.jpg)
_Figure 3: Fault injection devices._

## Attack Process

The following diagram illustrates the fault injection attack process workflow:

```mermaid
flowchart TB
    A[Target Device STM32F303] -->|Trigger Signal| B[Voltage Glitch Device]
    B -->|Voltage Glitches| A
    A -->|Waveforms| C[Oscilloscope]
    A -->|CipherText| D[HOST]
    D -->|Compare with Expected CipherText| E[Determine Injection Success]
    E -->|If Different| F[Fault Injection Worked]
    E -->|If Same| G[Fault Injection Failed]
```

> In this case, the fault injection trigger signal is provided by the target device itself to simplify the attack process. If the device were a true black box, we would need to generate the trigger signal ourselves.
