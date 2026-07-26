`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.04.2026 15:27:06
// Design Name: 
// Module Name: tb_bs_lfsr
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




module tb_bs_lfsr;
   reg clk;
    reg rst;
    wire [3:0] led;

    // Instantiate DUT
    bs_lfsr_top uut (
        .clk(clk),
        .rst(rst),
        .led(led)
    );

    // Clock generation (10ns period)
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;

        // Apply reset
        #20;
        rst = 0;

        // Run simulation
        #5000;

        $finish;
    end

    initial begin
        $monitor("Time=%0t | LFSR Output=%b", $time, led);
    end

endmodule


