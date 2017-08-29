// Multiplexer 2 to 1

module Mul1 ( Input1,	
			  Input2,
			  S,
			  Cout);

	input [4:0] Input1;
	input [4:0] Input2;
	input S;
	
	output [4:0] Cout;
	
	assign Cout = (S == 0) ? Input1 : Input2;
	
endmodule