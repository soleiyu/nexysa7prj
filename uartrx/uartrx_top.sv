`timescale 1ns / 1ps

module uartrx_top(
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
    
    input wire UART_TXD_IN,
//    output wire UART_RXD_OUT,
    input wire UART_RTS
//    output wire UART_CTS
);

reg [15:0] ledsel;
reg [7:0] ledval;

reg clk115k;
reg [9:0]cnt115k;

reg rxenable;
reg [1:0] rxdata;
reg [1:0] rxstate;
reg [2:0] rxcnt;
reg [7:0] rxval[0:3];

assign AN[0] = ledsel[15:13] == 3'd0 ? 0 : 1;
assign AN[1] = ledsel[15:13] == 3'd1 ? 0 : 1;
assign AN[2] = ledsel[15:13] == 3'd2 ? 0 : 1;
assign AN[3] = ledsel[15:13] == 3'd3 ? 0 : 1;
assign AN[4] = ledsel[15:13] == 3'd4 ? 0 : 1;
assign AN[5] = ledsel[15:13] == 3'd5 ? 0 : 1;
assign AN[6] = ledsel[15:13] == 3'd6 ? 0 : 1;
assign AN[7] = ledsel[15:13] == 3'd7 ? 0 : 1;

assign CA = ledval[7];
assign CB = ledval[6];
assign CC = ledval[5];
assign CD = ledval[4];
assign CE = ledval[3];
assign CF = ledval[2];
assign CG = ledval[1];
assign DP = ledval[0];

assign UART_RTS = SW[15];

initial begin
	ledsel <= 16'b0;
	clk115k <= 1'b0;
	cnt115k <= 10'b0;

	rxenable <= 1'b0; 
	rxstate <= 2'b0;
	rxcnt <= 3'b0;
end

//# CLK 100M
always @(posedge clk) begin
//# UART_RX
	rxdata[0] <= UART_TXD_IN;
	rxdata[1] <= rxdata[0];
	if (~rxenable && rxdata == 2'b10) begin
		rxenable <= 1'b1;
		rxval[3] <= rxval[2];
		rxval[2] <= rxval[1];
		rxval[1] <= rxval[0];
	end else if (rxenable && rxdata == 2'b11) begin
	   if (rxstate == 2'd0) begin
	       rxenable <= 1'b0;
	   end
	end
	
	if (~rxenable) begin
		cnt115k <= 10'b0;
		clk115k <= 1'b0; 
	end else if (cnt115k == 10'd433) begin
		cnt115k <= 10'b0;
		clk115k <= clk115k + 1'b1;
	end else begin
		cnt115k <= cnt115k + {9'b0, rxenable};
	end

//## LED
	ledsel <= ledsel + 16'b1;
	if (ledsel == 16'hFFFF) begin
		ledval <= ledenc(rxval[0][3:0]);
	end else if (ledsel  == 16'h1FFF) begin
		ledval <= ledenc(rxval[0][7:4]);
	end else if (ledsel  == 16'h3FFF) begin
		ledval <= ledenc(rxval[1][3:0]);
	end else if (ledsel  == 16'h5FFF) begin
		ledval <= ledenc(rxval[1][7:4]);
	end else if (ledsel  == 16'h7FFF) begin
		ledval <= ledenc(rxval[2][3:0]);
	end else if (ledsel  == 16'h9FFF) begin
		ledval <= ledenc(rxval[2][7:4]);
	end else if (ledsel  == 16'hBFFF) begin
		ledval <= ledenc(rxval[3][3:0]);
	end else if (ledsel  == 16'hDFFF) begin
		ledval <= ledenc(rxval[3][7:4]);
	end
end

//# CLK 115200
always @(posedge clk115k) begin
	//STARTBIT
	if (rxstate == 2'b0) begin
		rxstate <= 2'b1;
		rxcnt <= 3'b0;
	//VAL
	end else if (rxstate == 2'b1) begin
		rxval[0][rxcnt] <= rxdata[0];
		if (rxcnt == 3'd7) begin
			rxstate <= 2'd2;
			rxcnt <= 3'b0;
		end else begin
			rxcnt <= rxcnt + 3'b1;
		end
	//STOPBIT
	end else if (rxstate == 2'd2) begin
		rxstate <= 2'd0;
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
