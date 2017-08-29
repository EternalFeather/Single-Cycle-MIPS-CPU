// Multiplexer 2 to 1(32-bit)

module Mul3 ( Input1,	
			  Input2,
			  S,
			  Cout);
	
	input [31:0] Input1;
	input [31:0] Input2;
	input S;
	
	output [31:0] Cout;
	
	assign Cout = (S == 0) ? Input1 : Input2;
	
endmodule