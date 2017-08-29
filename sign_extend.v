// Sign-extend
// extend bit from 16-bit to 32-bit

module Sign_extend ( in,
					 out );
					 
	input  [15:0] in;
	output [31:0] out;

	assign out = {{16{in[15]}},in};	// signed module
 
endmodule	
	
	
	
	
	
	
