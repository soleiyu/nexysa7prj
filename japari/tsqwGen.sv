// Square Wave Generater FOR 50MHz

module tsqwGen
(
	input  wire  			clk,
	input	 wire	[31:0]	f,
	input  wire 			rst,	
	output wire 			outwave,
	output wire [7:0]		st
);

	reg [31:0] count;
	reg [7:0]	status;
	reg wf;
	
	always@(posedge clk) 
	begin
		if (rst)
		begin
			count <= 0;
			status <= 8'b00000001;
		end
		else if ((2500000000 / f) < count)
		begin
			count <= 0;
			wf <= wf + 1;
			status <= 8'b00000010;
		end
		else
		begin	
			count <= count + 1;
			status <= 8'b00000100;
		end
	end

	assign outwave = wf;
	assign st = status;

endmodule
