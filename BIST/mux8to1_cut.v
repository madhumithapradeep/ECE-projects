`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.04.2026 14:37:37
// Design Name: 
// Module Name: mux8to1_cut
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


module mux8to1_cut(
    input i0,
    input i1,
    input i2,
    input i3,
    input i4,
    input i5,
    input i6,
    input i7,
    input s0,
    input s1,
    input s2,
    output y
    );
    wire s0_bar, s1_bar, s2_bar;
wire w0, w1, w2, w3, w4, w5, w6, w7;

// Inverters
not (s0_bar, s0);
not (s1_bar, s1);
not (s2_bar, s2);

// AND gates for each input path
and (w0, i0, s2_bar, s1_bar, s0_bar); // 000
and (w1, i1, s2_bar, s1_bar, s0);     // 001
and (w2, i2, s2_bar, s1,     s0_bar); // 010
and (w3, i3, s2_bar, s1,     s0);     // 011
and (w4, i4, s2,     s1_bar, s0_bar); // 100
and (w5, i5, s2,     s1_bar, s0);     // 101
and (w6, i6, s2,     s1,     s0_bar); // 110
and (w7, i7, s2,     s1,     s0);     // 111

// OR gate
or (y, w0, w1, w2, w3, w4, w5, w6, w7);
endmodule
