// top

module top ( clk,
             rst,
	     // Instruction Memory
	     IM_Address,
             Instruction,
			 // Data Memory
			 DM_Address,
			 DM_enable,
			 DM_Write_Data,
			 DM_Read_Data);

	parameter data_size = 32;
	parameter mem_size = 16;	

	input  clk, rst;
	
	// Instruction Memory
	output [mem_size-1:0] IM_Address;	
	input  [data_size-1:0] Instruction;

	// Data Memory
	output [mem_size-1:0] DM_Address;
	output DM_enable;
	output [data_size-1:0] DM_Write_Data;	
    	input  [data_size-1:0] DM_Read_Data;
	
	// write your code here
	
	// wire definition
	/*--------------------------------------------------*/
	// PC Wire
	parameter pc_size = 18;
	wire [pc_size-1:0] PCout;
	wire [pc_size-1:0] PC_add1;
	wire [pc_size-1:0] PC_add2;
	
	// Controller
	wire [5:0] opcode;
	wire [5:0] funct;
	wire Reg_imm;
	wire Jump;
	wire Branch;
	wire Jal;
	wire Jr;
	wire Jalr;
	wire Sh;
	wire Lh;
	wire Mem2Reg;		// lw
	wire [3:0] ALUOp;
	wire RegWrite;
	wire MemWrite;		// sw
	
	// Registers
	wire [4:0] Rd;
	wire [4:0] Rs;
	wire [4:0] Rt;
	wire [4:0] mux1_out;
	wire [4:0] mux2_out;
	wire [data_size-1:0] WD_out;
	wire [data_size-1:0] Rs_out;
	wire [data_size-1:0] Rt_out;
	
	// Sign_extend	
	wire [15:0] imm;
	wire [data_size-1:0] Sign_out;
	
	// ALU
	wire [data_size-1:0] mrt_out;
	wire [4:0] shamt;	
	wire [data_size-1:0] ALU_result;
	wire Zero;
	
	// Jump Part
	wire [pc_size-1:0] BranchAddr;
	wire [pc_size-1:0] JumpAddr;
	wire [1:0] Jump_S;
	wire [pc_size-1:0] Jump_PC;
	
	// DM_back
	wire [data_size-1:0] DMback;
	wire [data_size-1:0] DM_out;
	
	/*--------------------------------------------------*/
	// Assign relationships
	// PC-IM
	assign IM_Address = PCout[pc_size-1:2];
	// Controller
	assign opcode = Instruction[31:26];
	assign funct = Instruction[5:0];
	// Regfile
	assign Rd = Instruction[15:11];
	assign Rs = Instruction[25:21];
	assign Rt = Instruction[20:16];
	// Sign_extend
	assign imm = Instruction[15:0];
	// ALU
	assign shamt = Instruction[10:6];
	assign JumpAddr	= {Instruction[15:0],2'b0};
	// DM
	assign DM_Address = ALU_result[17:2];
	assign DM_enable = MemWrite;
	//assign DM_Write_Data = Rt_out;
	
	/*------------------------------------------------*/
	// CPU Construction
	// PC
	PC PC1 ( 
		.clk(clk), 
		.rst(rst),
		.PCin(Jump_PC), 
		.PCout(PCout)
	);
					   
	ADD ADD1 ( 
		.Input1(PCout),
		.Input2(18'd4),
		.Cout(PC_add1)
	);
	
	ADD ADD2 (	
		.Input1(PC_add1),	
		.Input2(18'd4),	
		.Cout(PC_add2)
	);	
	
	// Controller
	Controller Controller1 ( 
		.opcode(opcode),
		.funct(funct),
		.Reg_imm(Reg_imm),
		.Jump(Jump),
		.Branch(Branch),
		.Jal(Jal),
		.Jr(Jr),
		.Jalr(Jalr),
		.Sh(Sh),
		.Lh(Lh),
		.Mem2Reg(Mem2Reg),
		.ALUOp(ALUOp),
		.RegWrite(RegWrite),
		.MemWrite(MemWrite)
	);
	
	// Regfile
	Mul1 Rd_Rt ( 
		.Input1(Rd),
		.Input2(Rt),
		.S(Reg_imm),
		.Cout(mux1_out)
	);
	Mul1 WR ( 
		.Input1(mux1_out),
		.Input2(5'd31),
		.S(Jalr),
		.Cout(mux2_out)
	);
	Mul3 WD (
		.Input1(DMback),
		.Input2({14'b0 ,PC_add2}),	// 14-bit : 0 + 18-bit : PC_ADD2 = 32-bit
		.S(Jal),
		.Cout(WD_out)
	);	
	Regfile Registers1 ( 
		.clk(clk), 
		.rst(rst),
		.Read_addr_1(Rs),
		.Read_addr_2(Rt),
		.Read_data_1(Rs_out),
		.Read_data_2(Rt_out),
		.RegWrite(RegWrite),
		.Write_addr(mux2_out),
		.Write_data(WD_out)
	);
	
	// Sign_extend	
	Sign_extend Sign_extend1 ( 
		.in(imm),
		.out(Sign_out)
	);
	
	// ALU
	Mul3 Rt_imm (
		.Input1(Rt_out),
		.Input2(Sign_out),
		.S(Reg_imm),
		.Cout(mrt_out)
	);	
	ALU ALU1 ( 
		.ALUOp(ALUOp),
		.src1(Rs_out),
		.src2(mrt_out),
		.shamt(shamt),
		.ALU_result(ALU_result),
		.Zero(Zero)
	);
	
	// Jump-ctrl
	ADD ADD_Branch ( 
		.Input1(PC_add1),
		.Input2({Sign_out[15:0],2'b0}),	// 16-bit : Sign_out + 2-bit : 0 = 18-bit input2
		.Cout(BranchAddr)
	);
	Mul2 PC_Mux (
		.Input1(PC_add1),
		.Input2(BranchAddr),
		.Input3(Rs_out[pc_size-1:0]),
		.Input4(JumpAddr),
		.S(Jump_S),
		.Cout(Jump_PC)
	);
	Jump_Ctrl Jump_Ctrl1 (
		.Branch(Branch),
		.Zero(Zero),
		.Jr(Jr),
		//.Jalr(Jalr),
		.Jump(Jump),
		.JumpOP(Jump_S)
	);

	// DM_back
	Mul3 DM_Win (
		.Input1(Rt_out),
		.Input2({{16{Rt_out[15]}}, Rt_out[15:0]}),
		.S(Sh),
		.Cout(DM_Write_Data)
	);
	Mul3 DM_Rout (
		.Input1(DM_Read_Data),
		.Input2({{16{DM_Read_Data[15]}}, DM_Read_Data[15:0]}),
		.S(Lh),
		.Cout(DM_out)
	);
	Mul3 DM_Mux1 (
		.Input1(ALU_result),
		.Input2(DM_out),
		.S(Mem2Reg),
		.Cout(DMback)
    );
	
endmodule


























