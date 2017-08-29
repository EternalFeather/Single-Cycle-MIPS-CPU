// ADD

module ADD ( Input1,
			 Input2,
			 Cout);

	parameter input_size = 18;

	input  [input_size-1:0] Input1;
	input  [input_size-1:0] Input2;

	output [input_size-1:0] Cout;

	assign Cout = Input1 + Input2;

endmodule





