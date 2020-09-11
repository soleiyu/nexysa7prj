module player
(
	input	wire  			oclk,   
	input	wire				rst,
	input wire	[15:0]	data,
	output wire [7:0]  	outv,
	output wire [9:0]		cnt
);

	reg [15:0] notes [255:0];
	
	reg [2:0] ocount;
	reg [9:0] count;
	reg [7:0] lcount;
	reg playf;
	
	reg [7:0] outcache;
	reg [7:0] outlength;
	
	always@(posedge oclk) 
	begin
		if (rst)
		begin
			count <= 0;
			playf <= 1;
			lcount <= 1;
		end
		
		else if (playf)
		begin
			ocount <= ocount + 1;
			
			if (ocount == 0)
			begin		
				// STAY NOTES
				if (lcount[7:0] < outlength)
				begin
					lcount <= lcount + 1;
				end
				// SHIFT NOTES
				else
				begin
					count <= count + 1;
					lcount <= 1;
					outcache <= data[7:0];
					outlength <= data[15:8];
				end
			
				if (count == 1023)
				begin
					playf <= 0;
				end
			end
			
			else if (ocount == 7)
			begin
				if (!(lcount[7:0] < outlength))
				begin
					outcache <= 0;
				end
			end
			
		end
	end

	assign outv = outcache;
	assign cnt = count;

	initial
	begin
		playf <= 0;
		count <= 0;
		lcount <= 1;
	end
	
endmodule
