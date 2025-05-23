# AES Encryption Algorithm Implementation Using FPGA Board for Secure Data Communication

## 🔐 Introduction

This project implements the **Advanced Encryption Standard (AES-128)** encryption algorithm on an **FPGA development board** to enable **real-time secure data communication**. AES is a symmetric block cipher standardized by NIST and widely used for securing digital information.

By leveraging the parallelism of FPGA architectures, the project achieves high-speed encryption suitable for applications in embedded systems, secure IoT devices, and real-time data transmission. The entire design is described in Verilog HDL and simulated using **Icarus Verilog**, with waveform outputs verified using **GTKWave**.

---

## 🔄 Workflow

1. **Design Specification**
   - AES-128 standard selected
   - Block-based encryption (128-bit input and key)

2. **Module Development in Verilog**
   - Key Expansion
   - Initial AddRoundKey
   - SubBytes
   - ShiftRows
   - MixColumns
   - Final AddRoundKey

3. **Simulation and Verification**
   - Simulate with multiple plaintext-key pairs
   - Observe intermediate and final states using GTKWave

4. **Synthesis and FPGA Deployment**
   - Synthesized with tools like Vivado/Quartus
   - Loaded bitstream onto FPGA (e.g., Basys3 or ZCU104)

5. **On-Board Testing**
   - Serial/UART interface for plaintext input
   - Encrypted output monitored via UART/LED

---

## ⚙️ Methodology

The AES encryption process follows these key steps:

1. **Key Expansion**: Derive 11 round keys from the original 128-bit key using Rijndael's key schedule.
2. **Initial Round**:
   - AddRoundKey
3. **Main Rounds (Rounds 1–9)**:
   - SubBytes (S-Box substitution)
   - ShiftRows (row-wise permutation)
   - MixColumns (column mixing using matrix multiplication)
   - AddRoundKey
4. **Final Round (Round 10)**:
   - SubBytes
   - ShiftRows
   - AddRoundKey (No MixColumns)

---
## 🧱 Methodology 
![aes-image](https://github.com/user-attachments/assets/2ec71ccf-d007-4c98-8e29-4b3f17c46d9b)


# 🧱 Block Diagram
![AES-block-encryption-in-CBC-mode](https://github.com/user-attachments/assets/2f712a8a-d592-4d3f-b384-46722f693ff8)
# 🧱 Output Waveform 

![Screenshot 2025-05-19 005056](https://github.com/user-attachments/assets/41f88e2d-6c00-4814-b352-8c268738d262)

## 🚀 Performance Matrix: AES-128 FPGA vs. Software Implementation

| **Parameter**           | **Software-based Encryption**        | **FPGA-based AES-128 Implementation**             | **Advantage**                                |
|------------------------|--------------------------------------|---------------------------------------------------|----------------------------------------------|
| **Execution Speed**     | 5–20 Mbps (depends on CPU speed)     | 100–400 Mbps or more (parallel processing)        | 5x–20x faster                                |
| **Latency**             | High (due to instruction cycles/OS)  | Very low (1–2 clock cycles/round with pipelining) | Real-time encryption possible                 |
| **Power Consumption**   | Higher (due to general-purpose CPU)  | Lower (dedicated logic consumes less power)       | Suitable for IoT/mobile devices              |
| **Throughput**          | Limited by CPU core                  | High (1 block per clock after pipeline fill)      | High-speed data streaming supported          |
| **Resource Utilization**| Depends on RAM/CPU                   | Uses LUTs, BRAMs, Flip-flops (FPGA resources)      | Predictable and optimized usage              |
| **Security (Side-channel)** | Vulnerable to timing attacks       | More secure (DPA-resistant logic can be added)    | Better physical-level protection             |
| **Scalability**         | Limited by CPU threads               | Easily scalable by duplicating AES cores          | Multiple streams in parallel                 |
| **Flexibility**         | High (code changes are easy)         | Moderate (requires re-synthesis/configuration)    | Tradeoff for higher performance              |



## 🔧 FPGA-Based AES-128 Implementation: Key Advantages

### ✅ Pipelining Benefits
*What is Pipelining in AES on FPGA?*
*Pipelining divides the encryption process into stages, where each stage works on a different part of the input at each clock cycle—just like an assembly line*

- ⚙️ **Reduced Latency:** Each AES round operates in a pipeline stage, minimizing overall delay.
- 📈 **Improved Throughput:** After the pipeline is filled, one encrypted block is output every clock cycle.
- ⏱️ **Deterministic Timing:** Consistent performance for real-time applications.

---

### 🧩 Parallel Processing Benefits

   *What is Parallelism in AES on FPGA?*
   *Parallelism means multiple operations are performed at the same time using separate hardware blocks.*
   
- 🔀 **Multiple AES Cores:** FPGAs can host multiple encryption engines in parallel.
- 🚀 **Increased Data Rate:** Suitable for high-speed communication systems.
- 📡 **Supports Multi-stream Encryption:** Perfect for secure video/audio streaming and network encryption.

---

### 📊 FPGA vs. Software: Advantage Matrix

| **Metric**             | **FPGA-Based AES**                           | **Advantage**                                     |
|------------------------|----------------------------------------------|--------------------------------------------------|
| **Power Consumption**  | Low (due to hardware-specific implementation)| Ideal for battery-operated and embedded devices  |
| **Performance**        | High (parallelism + pipelining)              | Up to 20x faster than software                   |
| **Latency**            | Minimal (1–2 cycles per round)               | Real-time AES encryption                         |
| **Throughput**         | Very High (1 block per clock after pipeline) | Handles high-bandwidth applications              |
| **Scalability**        | Easy (duplicate AES cores)                   | Encrypt multiple data streams in parallel        |
| **Determinism**        | Predictable and reliable                     | Great for mission-critical systems               |
| **Resource Efficiency**| Uses LUTs, FFs, and BRAM efficiently         | Optimized hardware utilization                   |

---

### 🛡️ Security Advantages

- 🔐 Can be hardened against **Side-Channel Attacks** like DPA and Timing Attacks.
- 🧱 Implementation-specific **obfuscation** and custom logic adds another layer of protection.



---

## 🧩 Netlist Diagram

A synthesized netlist representation of the AES design showing the interconnection of all submodules.


![Screenshot 2025-05-20 002416](https://github.com/user-attachments/assets/7b85e467-14d4-486e-ab08-608219eaae07)

---

## 💻 FPGA Implementation View

Post-synthesis placement and routing view from Vivado (Zynq ZCU104 board).

![Screenshot 2025-05-19 172331](https://github.com/user-attachments/assets/188b24cf-bb20-4f8b-86aa-9c6f57516d8c)

---

## 🔌 Final Hardware Setup

AES encryption system deployed and running on the ZCU104 board.

![dais-fpga-board-1024x768](https://github.com/user-attachments/assets/b53716d5-c9b0-4fa7-b74c-6c2ad826c0ec)

---

## 🧪 Functional Test Summary

| Test Case | Input Data (Hex)             | Encrypted Output               | IV Used | Latency (cycles) | Status |
|-----------|-------------------------------|--------------------------------|---------|------------------|--------|
| TC01      | `0x00112233445566778899AABBCCDDEEFF` | `0x69C4E0D86A7B0430D8CDB78070B4C55A` | Yes     | 12               | ✅ Pass |
| TC02      | `0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF` | `0xA1B2C3D4E5F67890123456789ABCDEF0` | Yes     | 12               | ✅ Pass |
| TC03      | `0x00000000000000000000000000000000` | `0x66E94BD4EF8A2C3B884CFA59CA342B2E` | Yes     | 12               | ✅ Pass |
| ...       | ...                           | ...                            | ...     | ...              | ...    |

> ⏱️ *Average Encryption Latency:* ~12 clock cycles  
> 🔐 *Each encryption cycle uses a randomized IV for enhanced security.*

---

## 📊 Final Performance Matrix

| **Metric**             | **Value** | **Remarks**                                               |
|------------------------|-----------|-----------------------------------------------------------|
| LUTs                  | 5,686     | Used for implementing combinational logic                |
| Flip-Flops (FFs)      | 3,267     | Used for sequential logic and control/data pipelining    |
| I/O Ports             | 644       | High due to 128-bit wide data and control interface      |
| Net Connections       | 1,658     | Indicates interconnect complexity within the design      |
| Clock Period          | ~10.5 ns  | Achievable frequency ≈ **94.8 MHz**                      |
| Cell Count            | 767       | Total number of logic cells utilized                     |

---

## 🤝 Acknowledgments

This project was driven by self-initiative and independent learning.  
Explored interdisciplinary domains including **Post-Quantum Cryptography (PQC)**, **Classical Cryptography**, and **Hardware Security**,
which contributed significantly to the development and understanding of secure AES encryption on FPGA.
---

## 🧠 Author

**GAURAV DHAK**  
B.Tech in Electronics System Engineering, Specialization in VLSI  
NIELIT Aurangabad  
Academic Year: 2024–2025
## 📧 Contact

Feel free to reach out for discussions or collaborations in the domain of **VLSI**, **FPGA**, or **Cryptographic Hardware** Design.

📩 gauravdhak1301@gmail.com

---
