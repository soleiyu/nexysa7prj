module top
(
	input wire clk,
	input wire  [2:0] SW,
	output wire AUD_PWM,
	output wire AUD_SD
);
	reg iclk;
	reg [1:0] cnt3;

	assign AUD_SD = SW[2];
	assign AUD_PWM = mixer(cnt3, sd0, sd1, sd2);

	initial begin
		iclk <= 1'b0;
		cnt3 <= 2'b0;
	end

	always @(posedge clk) begin
	   iclk <= iclk + 1'b1;
	   
	   if (cnt3 == 2'd2) begin
	       cnt3 <= 2'b0;
	   end else begin
	       cnt3 <= cnt3 + 2'b1;
	   end
	   
	end
	
	wire tmp;
	wire	[9:0]		count0;
	wire	[9:0]		count1;
	wire	[9:0]		count2;
	wire	[15:0]	ds30;
	wire	[15:0]	ds31;
	wire	[15:0]	ds32;
	wire	[7:0]		sv0;
	wire	[7:0]		sv1;
	wire	[7:0]		sv2;
	wire	[31:0] 	sf0;
	wire	[31:0] 	sf1;
	wire	[31:0] 	sf2;
	wire	sd0;
	wire	sd1;
	wire	sd2;
	
	japari1 j1(count0, ds30);
	japari2 j2(count1, ds31);
	japari3 j3(count2, ds32);
	
	player p0(tmp, SW[0], ds30, sv0, count0);
	player p1(tmp, SW[0], ds31, sv1, count1);
	player p2(tmp, SW[0], ds32, sv2, count2);
	
	tscaler tr0(sv0, sf0);
	tscaler tr1(sv1, sf1);
	tscaler tr2(sv2, sf2);
	
	tsqwGen bpm(iclk, 9000, SW[1], tmp); 
	tsqwGen msw0(iclk, sf0, SW[0], sd0);	
	tsqwGen msw1(iclk, sf1, SW[0], sd1);	
	tsqwGen msw2(iclk, sf2, SW[0], sd2);
	
	function mixer(input [1:0]sel, input s0, input s1, input s2);
	begin
	   case (sel)
	       2'd0: mixer = s0;
	       2'd1: mixer = s1;
	       2'd2: mixer = s2;
	       default: mixer = 1'b0;
	   endcase
	end
	endfunction
	
endmodule
