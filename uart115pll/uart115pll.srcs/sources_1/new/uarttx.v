`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/09/19 23:02:51
// Design Name: 
// Module Name: uarttx
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module uarttx(
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


   wire clk11m;

    clk_wiz_0 pll11m //11.52MHz
    (
        .clk_in1(clk),
        .clk_out1(clk11m)
     );
        

endmodule
