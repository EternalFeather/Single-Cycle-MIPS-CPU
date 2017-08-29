// Multiplexr 4 to 1

module Mul2 ( Input1,
			  Input2,
			  Input3,
			  Input4,
			  S,
			  Cout);
	
	parameter bit_size = 18;
	
	input [bit_size-1:0] Input1;
	input [bit_size-1:0] Input2;
	input [bit_size-1:0] Input3;
	input [bit_size-1:0] Input4;
	input [1:0] S; // 00, 01, 10, 11
	
	output [bit_size-1:0] Cout;
	reg [bit_size-1:0] Cout;
	
	always@ (*) begin
		case (S)
			2'b00 : begin
				Cout = Input1;
			end
			2'b01 : begin
				Cout = Input2;
			end
			2'b10 : begin
				Cout = Input3;
			end
			2'b11 : begin
				Cout = Input4;
			end	
		endcase
	end

endmodule
	
	
	


