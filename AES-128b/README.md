# AES-128 FPGA Implementation using Verilog

A synthesizable implementation of the **Advanced Encryption Standard (AES-128)** in **Verilog HDL** targeted for FPGA platforms. This project demonstrates hardware-based encryption using the AES-128 algorithm and includes a testbench for functional verification.

---

## Project Overview

AES (Advanced Encryption Standard) is a symmetric-key block cipher standardized by **NIST (FIPS-197)**. It encrypts **128-bit plaintext** using a **128-bit secret key** through **10 rounds** of cryptographic transformations.

This project implements the complete AES-128 encryption flow in Verilog and is suitable for FPGA implementation, digital design learning, and hardware security applications.

---

## Repository Structure

```
AES-128-FPGA
│
├── AES_FPGA.v        # Top-level FPGA module
├── AES.v             # AES-128 encryption core
├── AES_FPGA_tb.v     # Testbench for simulation
└── README.md
```

---

## Project Modules

### AES_FPGA.v

The top-level module that interfaces the AES encryption core with the FPGA. It accepts the plaintext, encryption key, clock, and reset signals, and produces the encrypted ciphertext.

### AES.v

Implements the complete AES-128 encryption algorithm, including:

- Key Expansion
- SubBytes
- ShiftRows
- MixColumns
- AddRoundKey

### AES_FPGA_tb.v

A simulation testbench used to verify the functionality of the AES implementation by applying sample plaintext and encryption keys.

---

## AES Encryption Flow

```
                 Plaintext (128-bit)
                        │
                        ▼
                 Initial AddRoundKey
                        │
                        ▼
              ┌──────────────────────┐
              │    9 Main Rounds     │
              │----------------------│
              │ • SubBytes           │
              │ • ShiftRows          │
              │ • MixColumns         │
              │ • AddRoundKey        │
              └──────────────────────┘
                        │
                        ▼
                 Final Round
              • SubBytes
              • ShiftRows
              • AddRoundKey
                        │
                        ▼
               Ciphertext (128-bit)
```

---

## Inputs

| Signal | Width | Description |
|---------|------:|-------------|
| clk | 1 | System Clock |
| rst | 1 | Active-high Reset |
| plaintext | 128 | Plaintext input |
| key | 128 | Secret encryption key |

---

## Outputs

| Signal | Width | Description |
|---------|------:|-------------|
| ciphertext | 128 | Encrypted output |

---

## Simulation

The project includes a dedicated Verilog testbench (`AES_FPGA_tb.v`) to validate the encryption process.

Simulation procedure:

1. Apply reset.
2. Load the 128-bit plaintext.
3. Load the 128-bit encryption key.
4. Start encryption.
5. Observe the generated ciphertext.

---

## Tools Used

- Verilog HDL
- Xilinx Vivado
- Vivado Simulator / ModelSim

---

## Applications

- FPGA-Based Cryptography
- Secure Embedded Systems
- Hardware Security
- Digital System Design
- Cryptographic Accelerators
- ASIC Prototyping

---

## Future Enhancements

- AES-128 Decryption
- AES-192 and AES-256 Support
- Pipelined AES Architecture
- UART-Based Encryption Interface
- AXI4 Peripheral Integration
- Hardware Optimization for Throughput and Area

---

## References

- National Institute of Standards and Technology (NIST), **FIPS PUB 197 – Advanced Encryption Standard (AES)**.
- Joan Daemen and Vincent Rijmen, **The Design of Rijndael**.

---

## Author

**Divyashree Chakravarthi**

B.Tech in Electronics and Communication Engineering  
PES University

---

## License

This project is intended for educational, research, and learning purposes.