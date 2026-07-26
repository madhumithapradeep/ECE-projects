`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.04.2026 18:55:44
// Design Name: 
// Module Name: bist_mux_top
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


module bist_mux_top(
    input clk,
    input rst,
    output [3:0] test_pattern,
    output cut_out,
    output [3:0] signature,
    output pass_fail
    );
    wire [3:0] led;

bs_lfsr_top prpg (
    .clk(clk),
    .rst(rst),
    .led(led)
);

assign test_pattern = led;

/////////////////////////////////////////////////////////////
// CUT : 4:1 Multiplexer
/////////////////////////////////////////////////////////////

wire mux_y;

mux8to1_cut cut (
    .i0(led[0]),
    .i1(led[1]),
    .i2(led[2]),
    .i3(led[3]),
    .i4(led[0]),
    .i5(led[1]),
    .i6(led[2]),
    .i7(led[3]),
    .s0(led[0]),
    .s1(led[1]),
    .s2(led[2]),
    .y(mux_y)
);

assign cut_out = mux_y;

/////////////////////////////////////////////////////////////
// Modified MISR
/////////////////////////////////////////////////////////////

wire [3:0] misr_in;

assign misr_in = {3'b000, mux_y};   // Only 1-bit CUT output expanded to 4-bit

misr resp (
    .clk(clk),
    .rst(rst),
    .data_in(misr_in),
    .signature(signature)
);

/////////////////////////////////////////////////////////////
// Comparator
// Golden signature assumed = 0100
/////////////////////////////////////////////////////////////

assign pass_fail = (signature == 4'b0100) ? 1'b1 : 1'b0;

endmodule
