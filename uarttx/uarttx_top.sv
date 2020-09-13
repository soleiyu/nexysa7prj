`timescale 1ns / 1ps

module uarttx_top(
    input wire [15:0] SW,
    input wire clk,
    output wire [7:0] AN,
    output wire CA,
    output wire CB,
    output wire CC,
    output wire CD,
    output wire CE,
    output wire CF,
    output wire CG,
    output wire DP,
    
//    input wire UART_TXD_IN,
    output wire UART_RXD_OUT,
//    input wire UART_RTS,
    output wire UART_CTS
);

reg [15:0] ledsel;
reg [7:0] ledval;

reg clk115k;
reg [9:0]cnt115k;

reg txdata;
reg [1:0] txstate;
reg [3:0] txcnt;

reg [7:0] hoge [0:3];
reg [7:0] charval;
reg [1:0] hogecnt;

assign AN[0] = ~ledsel[15];
assign AN[1] = ledsel[15];

assign CA = ledval[7];
assign CB = ledval[6];
assign CC = ledval[5];
assign CD = ledval[4];
assign CE = ledval[3];
assign CF = ledval[2];
assign CG = ledval[1];
assign DP = ledval[0];

assign UART_RXD_OUT = txdata;
assign UART_CTS = SW[14];

initial begin
	ledsel <= 16'b0;
	clk115k <= 1'b0;
	cnt115k <= 10'b0;

	txdata <= 1'b1;
	txstate <= 2'b0;
	txcnt <= 4'b0;

	hoge[0] <= 8'h48;
	hoge[1] <= 8'h4F;
	hoge[2] <= 8'h47;
	hoge[3] <= 8'h45;
	hogecnt <= 2'b0;
end

//# CLK 100M
always @(posedge clk) begin
//## UART_TX
	if (cnt115k == 10'd433) begin
		cnt115k <= 10'b0;
		clk115k <= clk115k + 1'b1;
	end else begin
		cnt115k <= cnt115k + 10'b1;
	end

//## LED
	ledsel <= ledsel + 16'b1;
	if (ledsel == 16'h7FFF) begin
		ledval <= ledenc(SW[3:0]);
	end
	if (ledsel  == 16'hFFFF) begin
		ledval <= ledenc(SW[7:4]);
	end
end

//# CLK 115200
always @(posedge clk115k) begin
	if (SW[15]) begin
		if (txstate == 2'b0) begin
			txstate <= 2'b1;
			txdata <= 1'b0;
			txcnt <= 4'b0;
			charval <= hoge[hogecnt];
		end else if (txstate == 2'b1) begin
			txdata <= charval[txcnt];
			if (txcnt == 4'd7) begin
			 txstate <= 2'd2;
			 txcnt <= 4'b0;
			end else begin
			 txcnt <= txcnt + 4'b1;
			end
		end else if (txstate == 2'd2) begin
			txdata <= 1'b1;
			hogecnt <= hogecnt + 2'b1;
			if (hogecnt == 2'd3) begin
				txstate <= 2'd3;
			end else begin
				txstate <= 2'd0;
			end
		end
	end else begin
	   txcnt <= 4'b0;
	   txstate <= 2'b0;
	   txdata <= 1'b1;
	end 
end

function [7:0] ledenc(input [3:0] inp);
begin
    case (inp)
        4'd0: ledenc = 8'b0000_0011;
        4'd1: ledenc = 8'b1001_1111;
        4'd2: ledenc = 8'b0010_0101;
        4'd3: ledenc = 8'b0000_1101;
        4'd4: ledenc = 8'b1001_1001;
        4'd5: ledenc = 8'b0100_1001;
        4'd6: ledenc = 8'b0100_0001;
        4'd7: ledenc = 8'b0001_1011;
        4'd8: ledenc = 8'b0000_0001;
        4'd9: ledenc = 8'b0000_1001;
        4'd10:ledenc = 8'b0001_0001;
        4'd11:ledenc = 8'b1100_0001;
        4'd12:ledenc = 8'b1110_0101;
        4'd13:ledenc = 8'b1000_0101;
        4'd14:ledenc = 8'b0110_0001;
        default: ledenc = 8'b0111_0001;
     endcase
end
endfunction

endmodule
