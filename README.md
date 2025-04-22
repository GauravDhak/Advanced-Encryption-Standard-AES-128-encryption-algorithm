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

![aes-image](https://github.com/user-attachments/assets/0aa90b01-72ec-4775-a430-11750b8f5e4c)

# 🧱 Output Waveform 

![Screenshot 2025-04-20 101631](https://github.com/user-attachments/assets/0eb134f1-83d0-4be4-94af-292432dd4143)


![Screenshot 2025-04-20 103644](https://github.com/user-attachments/assets/9888871a-bc86-4490-9c6e-2aa807190aef)

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

