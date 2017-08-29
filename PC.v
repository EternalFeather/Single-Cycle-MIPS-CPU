// Program Counter

module PC ( clk, 
			rst,
			PCin, 
			PCout);
	
	parameter bit_size = 18;
	
	input  clk, rst;
	input  [bit_size-1:0] PCin;
	output [bit_size-1:0] PCout;

	// write your code in here	
	reg [bit_size-1:0] PCout;	
	
	always@ (posedge clk or posedge rst) begin
		if (rst) 
			PCout <= 0;
		else 
			PCout <= PCin;
	end
		   
endmodule

