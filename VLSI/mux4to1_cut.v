`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.04.2026 18:45:01
// Design Name: 
// Module Name: mux4to1_cut
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


module mux4to1_cut(
    input i0,
    input i1,
    input i2,
    input i3,
    input s0,
    input s1,
    output  y
    );
     wire s0_bar, s1_bar;
    wire w0, w1, w2, w3;

    // Inverters
    not (s0_bar, s0);
    not (s1_bar, s1);

    // AND gates
    and (w0, i0, s1_bar, s0_bar); // 00
    and (w1, i1, s1_bar, s0);     // 01
    and (w2, i2, s1, s0_bar);     // 10
    and (w3, i3, s1, s0);         // 11

    // OR gate
    or (y, w0, w1, w2, w3);

endmodule
