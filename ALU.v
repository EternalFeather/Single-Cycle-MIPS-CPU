// ALU

module ALU ( ALUOp,
	     src1,
	     src2,
	     shamt,
	     ALU_result,
	     Zero );
	
	parameter bit_size = 32;
	
	input [3:0] ALUOp;
	input [bit_size-1:0] src1;
	input [bit_size-1:0] src2;
	input [4:0] shamt;
	
	output [bit_size-1:0] ALU_result;
	output Zero;
	
	// write your code in here
	reg [bit_size-1:0] ALU_result;
	reg Zero;
	
	wire [bit_size-1:0] sub_re;
	assign sub_re = src1 - src2;	// format bit count
	
	parameter // opcode
			  //op_nop = 0,
			  op_add = 1,
			  op_sub = 2,
			  op_and = 3,
			  op_or = 4,
			  op_xor = 5,
			  op_nor = 6,
			  op_slt = 7,
			  op_sll = 8,
			  op_srl = 9,
			  op_beq = 10,
			  op_bne = 11;
			
	always@ (*) begin
		ALU_result = 0;
		Zero = 0;
		case (ALUOp)
			op_add : 
				begin
					ALU_result = src1 + src2;
					Zero = (ALU_result == 0) ? 1 : 0;
				end
			op_sub : 
				begin
					ALU_result = sub_re;
					Zero = (ALU_result == 0) ? 1 : 0;
				end
			op_and :
				begin
					ALU_result = src1 & src2;
					Zero = (ALU_result == 0) ? 1 : 0;
				end
			op_or  : 
				begin
					ALU_result = src1 | src2;
					Zero = (ALU_result == 0) ? 1 : 0;
				end
			op_xor : 
				begin
					ALU_result = src1 ^ src2;
					Zero = (ALU_result == 0) ? 1 : 0;
				end
			op_nor : 
				begin
					ALU_result = ~(src1 | src2);
					Zero = (ALU_result == 0) ? 1 : 0;
				end
			op_slt : 
				begin
					ALU_result = (src1 < src2) ? 1 : 0;
					Zero = (ALU_result == 0) ? 1 : 0;
				end
			op_sll : 
				begin
					ALU_result = src2 << shamt;
					Zero = (ALU_result == 0) ? 1 : 0;
				end
			op_srl : 
				begin
					ALU_result = src2 >> shamt;
					Zero = (ALU_result == 0) ? 1 : 0;
				end
			op_beq : Zero = (sub_re == 0) ? 1 : 0;
			op_bne : Zero = (sub_re == 0) ? 0 : 1;
		endcase
	end

endmodule





