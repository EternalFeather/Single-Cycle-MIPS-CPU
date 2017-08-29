// Controller
// all of the instruction are signed
/* Include R-type add, and, jr, nor, or, slt, sll, srl, sub, xor, jalr
/		   I-type addi, andi, beq, bne, lw, sw, slti, lh, sh
		   J-type j, jal
*/	  

module Controller ( opcode,
					funct,
					// write your code in here
					Reg_imm,
					Jump,
					Branch,
					Jal,
					Jr,
					Jalr,
					Sh,
					Lh,
					Mem2Reg,
					ALUOp,
					RegWrite,
					MemWrite  
					);

	input  [5:0] opcode;
    input  [5:0] funct;
	
	// write your code in here
	// Output & Register
	output Reg_imm;
	output Jump;
	output Branch;
	output Jal;
	output Jr;
	output Jalr;
	output Sh;
	output Lh;
	output Mem2Reg;
	output [3:0] ALUOp;	// 11-kinds
	output RegWrite;
	output MemWrite;
	
	reg Reg_imm;
	reg Jump;
	reg Branch;
	reg Jal;
	reg Jr;
	reg Jalr;
	reg Sh;
	reg Lh;
	reg Mem2Reg;
	reg [3:0] ALUOp;
	reg RegWrite;
	reg MemWrite;
	
	// ALU
	parameter // Math
			  //op_nop = 0,
	          op_add = 1,
	          op_sub = 2,
	          op_and = 3,
	          op_or  = 4,
	          op_xor = 5,
	          op_nor = 6,
	          op_slt = 7,
	          op_sll = 8,
	          op_srl = 9,
	          op_beq = 10,
	          op_bne = 11;
			  
	// controller
	always@ (*) begin
		Reg_imm	= 0;
		Jump = 0;
		Branch = 0;
		Jal = 0;
		Jr = 0;
		Jalr = 0;
		Sh = 0;
		Lh = 0;
		Mem2Reg = 0;
		ALUOp = 0;
		RegWrite = 0;
		MemWrite = 0;		
		case (opcode)
		6'b00_0000 : begin // R-type
			case (funct)
			6'b10_0000 : begin // add(32)
				ALUOp = op_add;
				RegWrite = 1;
			end
			6'b10_0010 : begin // sub(34)
				ALUOp = op_sub;
				RegWrite = 1;
			end
			6'b10_0100 : begin // and(36)
				ALUOp = op_and;
				RegWrite = 1;
			end
			6'b10_0101 : begin // or(37)
				ALUOp = op_or;
				RegWrite = 1;
			end
			6'b10_0110 : begin // xor(38)
				ALUOp = op_xor;
				RegWrite = 1;
			end
			6'b10_0111 : begin // nor(39)
				ALUOp = op_nor;
				RegWrite = 1;
			end
			6'b10_1010 : begin // slt(42)
				ALUOp = op_slt;
				RegWrite = 1;
			end
			6'b00_0000 : begin // sll(0)
				ALUOp = op_sll;
				RegWrite = 1;
			end
			6'b00_0010 : begin // srl(2)
				ALUOp = op_srl;
				RegWrite = 1;
			end
			6'b00_1000 : begin // jr(8)
				Jr = 1;
			end		
			6'b00_1001 : begin // jalr(9)
				Jr = 1;
				Jalr = 1;
				Jal = 1;
				RegWrite = 1;
			end
			endcase 
		end
		// I-type
		6'b00_1000 : begin // addi
			Reg_imm	 = 1;
			ALUOp = op_add;
			RegWrite = 1;
		end
		6'b00_1100 : begin // andi
			Reg_imm	 = 1;
		  	ALUOp = op_and;
		  	RegWrite = 1;
		end
		6'b00_1010 : begin // slti
			Reg_imm	 = 1;
		  	ALUOp = op_slt;
		  	RegWrite = 1;
		end
		6'b00_0100 : begin // beq
			Branch = 1;
			ALUOp = op_beq;
		end
		6'b00_0101 : begin // bne
			Branch = 1;
      		ALUOp = op_bne;
		end
		6'b10_0011 : begin // lw
			Reg_imm	 = 1;
			Mem2Reg = 1;
			ALUOp = op_add;	// add $RegWrite, $s0, 0
		  	RegWrite = 1;
		end
		6'b10_0001 : begin //lh
			Reg_imm = 1;
			Lh = 1;
			Mem2Reg = 1;
			ALUOp = op_add;
			RegWrite = 1;
		end
		6'b10_1011 : begin // sw
			Reg_imm	 = 1;
		  	ALUOp = op_add;	// add $s0, $RegWrite, 0
			MemWrite = 1;
		end
		6'b10_1001 : begin // sh
			Reg_imm = 1;
			Sh = 1;
			ALUOp = op_add;
			MemWrite = 1;
		end
		// J-Type
		6'b00_0010 : begin	// j
          	Jump = 1; 
	    end	
		6'b00_0011 : begin	// jal
			Jump = 1; 
			Jalr = 1;
			Jal = 1;
			RegWrite = 1;		
		end
		endcase
	end
	
endmodule




