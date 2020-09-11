`timescale 1ns / 1ps

module hex7seg_top(
    input wire [7:0] SW,
    input wire clk,
    output wire [7:0] AN,
    output wire CA,
    output wire CB,
    output wire CC,
    output wire CD,
    output wire CE,
    output wire CF,
    output wire CG,
    output wire DP
);

reg [15:0] ledsel;
reg [7:0] ledval;

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

initial begin
    ledsel <= 16'b0;
end

always @(posedge clk) begin
    ledsel <= ledsel + 16'b1;
    
    if (ledsel == 16'h7FFF) begin
        ledval <= ledenc(SW[3:0]);
    end
    if (ledsel  == 16'hFFFF) begin
        ledval <= ledenc(SW[7:4]);
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
