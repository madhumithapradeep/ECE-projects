`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.04.2026 18:57:28
// Design Name: 
// Module Name: tb_bist_mux_top
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


module tb_bist_mux_top;
 reg clk;
    reg rst;

    wire [3:0] test_pattern;
    wire cut_out;
    wire [3:0] signature;
    wire pass_fail;

    // Instantiate DUT
    bist_mux_top uut (
        .clk(clk),
        .rst(rst),
        .test_pattern(test_pattern),
        .cut_out(cut_out),
        .signature(signature),
        .pass_fail(pass_fail)
    );

    // Clock generation (10 ns period)
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;

        // Apply reset
        #20;
        rst = 0;

        // Run simulation long enough
        #1000;

        $finish;
    end

    initial begin
        $monitor("Time=%0t | rst=%b | Pattern=%b | CUT=%b | Signature=%b | PASS=%b",
                 $time, rst, test_pattern, cut_out, signature, pass_fail);
    end

endmodule
