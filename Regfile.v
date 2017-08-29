// Regfile

module Regfile ( clk, 
				 rst,
				 Read_addr_1,
				 Read_addr_2,
				 Read_data_1,
                 Read_data_2,
				 RegWrite,
				 Write_addr,
				 Write_data);
	
	parameter bit_size = 32;
	
	input  clk, rst;
	input  [4:0] Read_addr_1;
	input  [4:0] Read_addr_2;
	
	output [bit_size-1:0] Read_data_1;
	output [bit_size-1:0] Read_data_2;
	
	input  RegWrite;
	input  [4:0] Write_addr;
	input  [bit_size-1:0] Write_data;
	
	// write your code in here
	reg [bit_size-1:0] Reg_out [0:31];	// e.g. lw|(sw) $t0(rs/rt), 16($s0)
										// from $zero to $ra [31:0]
	
	assign Read_data_1 = Reg_out[Read_addr_1];
	assign Read_data_2 = Reg_out[Read_addr_2];
	
	integer i;
	
	always @ (posedge clk or posedge rst) begin
		if (rst) 
			for (i=0;i<32;i=i+1)
				Reg_out[i] <= 0;
		else if (RegWrite && Write_addr!=0)
			Reg_out[Write_addr] <= Write_data;
	end
	
endmodule






