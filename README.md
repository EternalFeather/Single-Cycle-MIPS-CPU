Single Cycle MIPS CPU
===
# Overview
The goal of this experience is to understand how a single-cycle MIPS work and how to use Verilog hardware description language (Verilog HDL) to model electronic systems. We need to implement a single cycle MIPS CPU that can execute all the instructions shown in the MIPS ISA section. We need to follow the instruction table and satisfy all the requirements .In addition, we need to verify our CPU by using Modelsim. Testing steps will provide test fixtures that will run a MIPS program for the CPU.

# Environment
- `Verilog`
- `ModelSim`

# Description

- The single-cycle CPU use one cycle to execute instruction. There are five main components in CPU: controller, regfile, arithmetic logic unit (ALU), program counter(PC), and jump controller.
- The controller control most of the multiplexers, DM write enable, ALU, Jump Controller, and regfile. The file Controller.v implements the controller.
- The regfile is used to store data between memory and the functional units. The file Regfile.v implements the regfile.
- The arithmetic logic unit do arithmetic and bitwise operations. The file ALU.v implements the arithmetic logic unit.
- The program counter is stored in the PC module. The file PC.v implements the program counter. It is triggered by positive clock edges.
- The jump controller select a memory address and send to PC. The file Jump_Ctrl.v implements the jump controller.
- The instruction memory is used to store instructions and it is implemented in IM.v files. The data memory is used to store data and it is implemented in DM.v file.
- The MIPS ISA is shown in the following. Figure 2 shows the R-type instructions in the MIPS ISA. Figure 3 shows the I-type instructions in the MIPS ISA. Figure 4 shows the J-type instructions in the MIPS ISA.

![](https://i.imgur.com/jJ6ajUH.png)
![](https://i.imgur.com/d89KFdi.png)
![](https://i.imgur.com/MeLucnx.png)

- Figure 5 shows the datapath of the single-cycle CPU. This single-cycle CPU is similar to the single-cycle in the textbook. However, to simply the CPU design, only smaller instruction and data memory are used and only 18-bit addresses are needed to obtain data in the memory.


