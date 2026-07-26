`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.04.2026 14:40:36
// Design Name: 
// Module Name: tb_mux8to1_cut
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


module tb_mux8to1_cut;
reg i0, i1, i2, i3, i4, i5, i6, i7;
    reg s0, s1, s2;
    wire y;

    // Instantiate DUT
    mux8to1_cut uut (
        .i0(i0), .i1(i1), .i2(i2), .i3(i3),
        .i4(i4), .i5(i5), .i6(i6), .i7(i7),
        .s0(s0), .s1(s1), .s2(s2),
        .y(y)
    );

    initial begin
        $monitor("Time=%0t | s2s1s0=%b%b%b | y=%b",
                 $time, s2, s1, s0, y);

        // Input values
        i0=0; i1=1; i2=0; i3=1;
        i4=1; i5=0; i6=1; i7=0;

        // Apply all select combinations
        s2=0; s1=0; s0=0; #10; // i0
        s2=0; s1=0; s0=1; #10; // i1
        s2=0; s1=1; s0=0; #10; // i2
        s2=0; s1=1; s0=1; #10; // i3
        s2=1; s1=0; s0=0; #10; // i4
        s2=1; s1=0; s0=1; #10; // i5
        s2=1; s1=1; s0=0; #10; // i6
        s2=1; s1=1; s0=1; #10; // i7

        $finish;
    end


endmodule
