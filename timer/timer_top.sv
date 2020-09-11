module top
(
	input wire clk,
	input wire  [15:0] SW,
	output wire CA, CB, CC, CD, CE, CF, CG, DP,
	output wire [7:0] AN
);

	assign CA = rseg[7];
	assign CB = rseg[6];
	assign CC = rseg[5];
	assign CD = rseg[4];
	assign CE = rseg[3];
	assign CF = rseg[2];
	assign CG = rseg[1];
	assign DP = rseg[0];

	assign AN = ~lpos;

	reg [7:0] lpos;

	reg [10:0] hcnt;
	reg [31:0] cnt;
	reg [7:0] rseg;

	initial begin
		lpos <= 10'b1;
		hcnt <= 32'b0;
		cnt <= 32'b0;
	end

	always @(posedge clk) begin
		hcnt <= hcnt + 8'b1;

		if (hcnt == 11'h7FF) begin
			lpos <= {lpos[6:0], lpos[7]};
		end

		if (SW[1]) begin
			if (lpos[7]) begin 
				cnt <= cnt + {24'b0, SW[9:2]};
			end
		end else if (SW[0]) begin
			cnt <= 32'b0;
		end

		if (lpos[0]) begin
			rseg <= enc(cnt[17:16]);
		end else if (lpos[1]) begin
			rseg <= enc(cnt[19:18]);
		end else if (lpos[2]) begin
			rseg <= enc(cnt[21:20]);
		end else if (lpos[3]) begin
			rseg <= enc(cnt[23:22]);
		end else if (lpos[4]) begin
			rseg <= enc(cnt[25:24]);
		end else if (lpos[5]) begin
			rseg <= enc(cnt[27:26]);
		end else if (lpos[6]) begin
			rseg <= enc(cnt[29:28]);
		end else if (lpos[7]) begin
			rseg <= enc(cnt[31:30]);
		end

	end

	function [7:0] enc(input [1:0] inp);
	begin
		case (inp)
			2'd0: enc = 8'b0111_1111;
			2'd1: enc = 8'b1001_1111;
			2'd2: enc = 8'b1110_1111;
			2'd3: enc = 8'b1111_0011;
			default: enc = 8'b1111_1101;
		endcase
	end
	endfunction

endmodule
