module top
(
	input wire clk,
	input wire  [1:0] SW,
	output wire AUD_PWM,
	output wire AUD_SD
);

	reg[31:0] cnt;
	reg wav;

	assign AUD_SD = SW[0];
	assign AUD_PWM = wav;

	initial begin
		cnt <= 32'b0;
		wav <= 1'b0;
	end

	always @(posedge clk) begin
		if (cnt == 100000000/884) begin
			wav <= wav + 1'b1;
			cnt <= 32'b0;
		end else begin	
			cnt <= cnt + 32'b1;
		end
	end

endmodule
