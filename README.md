
# RV32I Processor with Branching and ALU

## Overview
This project implements a basic **RV32I processor** with support for **branching** and **ALU operations**. The processor architecture follows the RISC-V instruction set and includes a custom pipeline for **Instruction Fetch** (IF), **Instruction Decode** (ID), **Execution** (EX), **Memory Access** (MEM), and **Writeback** (WB) stages. The design is modular, with separate units for instruction fetching, decoding, ALU operations, and branching logic.

The processor includes the following components:
- **Instruction Fetch Unit (IFU)**
- **Control Unit**
- **ALU**
- **Register File**
- **Instruction Memory**
- **Branching Logic**

### Key Features
- **Instruction Fetching**: Fetches instructions from memory and handles program counter (PC) increments and branch decisions.
- **Branching Support**: Implements basic branch conditions (`beq`, `bneq`, `blt`, `bltu`, `bge`, `bgeu`), with the ability to change the PC based on these conditions.
- **ALU Operations**: Supports a wide range of ALU operations, including arithmetic and logic operations.
- **Immediate Values**: Uses 12-bit immediate values for certain instructions, such as branches and memory accesses.
  
### Modules
1. **Top Module**: The top-level module connects all components and handles overall processor control. It integrates the Instruction Fetch Unit (IFU), Control Unit, ALU, Register File, and Instruction Memory.
2. **Instruction Fetch Unit (IFU)**: Handles instruction fetching, PC increment, and branching logic.
3. **Instruction Memory**: Contains a simple memory for storing instructions.
4. **Control Unit**: Decodes instruction opcodes, funct3, and funct7 to generate appropriate control signals.
5. **ALU**: Executes arithmetic and logical operations based on the decoded instruction and immediate values.
6. **Register File**: Stores and retrieves register values. Supports both read and write operations.
7. **Branching Logic**: Determines whether a branch should occur based on comparison results (e.g., equality, inequality, less than, etc.).

### Design Flow
1. **Instruction Fetching**: The program counter (`pc`) is incremented on each clock cycle unless a branch condition is met.
2. **Branching**: The branching unit evaluates whether any branch condition (`beq`, `bneq`, etc.) is met, and if so, the `pc` is updated with the branch address.
3. **Instruction Decode**: The fetched instruction is decoded to extract relevant fields (e.g., `opcode`, `rs1`, `rs2`, `rd`, `imm`).
4. **ALU Operation**: The ALU performs the appropriate operation based on the decoded instruction and passes the result to the next stage.
5. **Writeback**: The result of the ALU or memory operation is written back to the register file or memory.

### Project Structure
```plaintext
├── README.md           # This file
├── top.v               # Top-level processor module
├── instruction_fetch_unit.v  # Instruction fetch unit
├── control_unit.v      # Control unit for decoding instructions
├── alu.v               # ALU for executing arithmetic and logical operations
├── register_file.v     # Register file for reading/writing registers
├── instruction_memory.v # Instruction memory
└── testbench.v         # Testbench for simulation
```

### Testbench
A testbench is provided to simulate the processor's operation. It sets up the processor, initializes memory, and applies a series of test instructions to verify that the processor operates correctly. The testbench checks various aspects, including:
- Instruction fetching
- Branching functionality
- ALU operations
- Register file operations

### Running the Simulation
1. **Simulation Tool**: Use your preferred simulation tool (e.g. GTKWAVE) to run the testbench.
2. **Compile**: Compile all the Verilog files (including `top.v`, `instruction_fetch_unit.v`, etc.) and the testbench. using the command:
 'iverilog -o top top_tb.v top.v instruction_fetch_unit.v instruction_memory.v control_unit.v alu.v register_file.v'
3. **Run**: Simulate the design and monitor the output to ensure correct operation.

### Known Limitations
- Currently, the processor supports only basic integer operations and simple branching instructions.
- No support for advanced features such as floating-point operations or complex system calls.
- Memory is modeled as a simple instruction memory without data memory support for now.

### Future Enhancements
- Implement a **Data Memory** module to handle load/store instructions.
- Add support for more complex instructions (e.g., `JALR`, `ECALL`).
- Introduce a pipeline architecture for performance improvements.
- Implement **exception handling** and **interrupts**.

### License
This project is open-source and distributed under the MIT License. See `LICENSE` for more information.

### Acknowledgments
- The RISC-V architecture specification, which forms the foundation of this project.
- Contributors and open-source community for resources and inspiration.

### Document for proper understanding of the material:
- Original: https://riscv.org/wp-content/uploads/2017/05/riscv-spec-v2.2.pdf
- Simplified: https://docs.google.com/document/d/1U1Zp0nigoKpJPG7btRdDsvlIT8jD9YzA6aiCQ0WjkXw/edit?tab=t.0