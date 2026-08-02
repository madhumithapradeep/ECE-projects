`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.04.2026 18:48:08
// Design Name: 
// Module Name: tb_mux4to1_cut
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


module tb_mux4to1_cut;
reg i0, i1, i2, i3;
    reg s0, s1;
    wire y;

    // Instantiate DUT
    mux4to1_cut uut (
        .i0(i0),
        .i1(i1),
        .i2(i2),
        .i3(i3),
        .s0(s0),
        .s1(s1),
        .y(y)
    );

    initial begin
        $monitor("Time=%0t | s1=%b s0=%b | i0=%b i1=%b i2=%b i3=%b | y=%b",
                  $time, s1, s0, i0, i1, i2, i3, y);

        // Test case 1
        i0=1; i1=0; i2=0; i3=0;
        s1=0; s0=0;   #10;

        // Test case 2
        i0=0; i1=1; i2=0; i3=0;
        s1=0; s0=1;   #10;

        // Test case 3
        i0=0; i1=0; i2=1; i3=0;
        s1=1; s0=0;   #10;

        // Test case 4
        i0=0; i1=0; i2=0; i3=1;
        s1=1; s0=1;   #10;

        // Mixed inputs
        i0=1; i1=1; i2=0; i3=1;
        s1=0; s0=1;   #10;

        i0=1; i1=0; i2=1; i3=1;
        s1=1; s0=0;   #10;

        #10;
        $finish;
    end
endmodule
