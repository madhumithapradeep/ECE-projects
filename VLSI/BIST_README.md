# Power-Efficient Built-In Self-Test (BIST)

A hardware implementation of a **Power-Efficient Built-In Self-Test (BIST)** architecture using a **Bit-Swapped Linear Feedback Shift Register (BS-LFSR)** as the Test Pattern Generator (TPG) and a **Modified Multiple Input Signature Register (MISR)** as the Output Response Analyzer (ORA).

This project focuses on reducing switching activity during test pattern generation while maintaining effective fault detection for combinational circuits.

---

## Overview

Built-In Self-Test (BIST) is a Design-for-Testability (DFT) technique that enables digital circuits to test themselves without requiring expensive external testing hardware.

This implementation improves conventional BIST by:

- Using a **Bit-Swapped LFSR** to reduce switching activity.
- Using a **Modified MISR** for simpler and more scalable signature analysis.
- Detecting **single stuck-at faults** in combinational circuits.
- Reducing dynamic power consumption during testing.

---

## Features

- Low-power Test Pattern Generator (BS-LFSR)
- Modified MISR-based Output Response Analyzer
- Automatic PASS/FAIL indication
- Single stuck-at fault detection
- Approximately **25% reduction in switching activity**
- FPGA synthesizable design
- Suitable for Design-for-Testability (DFT) learning and research

---

## Architecture

```
             +------------------+
             |   BS-LFSR (TPG)  |
             +--------+---------+
                      |
                      |
                      v
             +------------------+
             | Circuit Under    |
             | Test (CUT)       |
             +--------+---------+
                      |
                      |
                      v
             +------------------+
             | Modified MISR    |
             | (ORA)            |
             +--------+---------+
                      |
                      v
             Comparator
                 |
          PASS / FAIL
```

---

## Working Principle

### 1. Test Pattern Generator (BS-LFSR)

- Generates pseudo-random test vectors.
- Performs conditional bit swapping to reduce transitions.
- Lower switching activity results in reduced dynamic power.

### 2. Circuit Under Test (CUT)

The generated test vectors are applied to the combinational logic.

### 3. Modified MISR

- Compresses CUT outputs into a signature.
- Aggregates multiple outputs using XOR.
- Generates the final signature for comparison.

### 4. Comparator

The generated signature is compared against the Golden Signature.

- Match → PASS
- Mismatch → FAIL

---

## Fault Model

This implementation detects:

- Single Stuck-at-0 faults
- Single Stuck-at-1 faults

---

## Results

| Parameter | Result |
|-----------|--------|
| Power Reduction | ~25% |
| Fault Detection | Single Stuck-at Faults |
| Test Pattern Generator | Bit-Swapped LFSR |
| Output Analyzer | Modified MISR |
| Design Style | FPGA Synthesizable |

---

## Tools Used

- Verilog / VHDL
- Xilinx Vivado
- Xilinx ISE Simulator
- FPGA Development Board

---

## Repository Structure

```
├── src/
│   ├── bs_lfsr.v
│   ├── modified_misr.v
│   ├── comparator.v
│   ├── cut.v
│   └── bist_top.v
│
├── testbench/
│   └── bist_tb.v
│
├── simulation/
│
├── constraints/
│
├── images/
│
└── README.md
```

*(Modify the folder names according to your project.)*

---

## Simulation

The design has been verified through simulation by testing:

- Fault-free circuit
- Stuck-at-0 faults
- Stuck-at-1 faults

The generated signature is compared with the Golden Signature to determine the test result.

---

## Future Improvements

- Multiple stuck-at fault detection
- Scan-based BIST support
- Built-In Self-Repair (BISR)
- Improved low-power test pattern generation
- Benchmark validation on larger ISCAS circuits

---

## Applications

- FPGA Testing
- ASIC Testing
- Digital IC Validation
- Design-for-Testability (DFT)
- Low-Power VLSI Systems

---

## References

This project is based on the concepts presented in:

**Design and Implementation of a Power Efficient BIST**  
Proceedings of the Fifth International Conference on Computing Methodologies and Communication (ICCMC 2021).

---

## Author

** Madhumitha P**
**Divyashree Chakravarthi**


Electronics and Communication Engineering  
PES University

---

## License

This project is intended for educational and research purposes.