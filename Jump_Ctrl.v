// Jump_Ctrl

module Jump_Ctrl( Zero,
                  JumpOP,
				  // write your code in here
				  Branch,  // I-type beq, bne
				  Jr,	// R-type
				  //Jalr,
				  Jump	// J-type
				  );

    input Zero;
	
	input Branch;
	input Jr;
	input Jump;
	
	output [1:0] JumpOP;
	// write your code in here
	reg [1:0] JumpOP;
	
	always@ (*) begin
		if (Branch && Zero)
			JumpOP = 2'b01;
		else if (Jr)
			JumpOP = 2'b10;
		else if (Jump)
			JumpOP = 2'b11;
		else
			JumpOP = 2'b00;	
	end
	
endmodule





