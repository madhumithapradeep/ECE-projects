`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.04.2026 18:20:47
// Design Name: 
// Module Name: tb_misr
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



module tb_misr;

    reg clk;
    reg rst;
    reg [3:0] data_in;
    wire [3:0] signature;

    // Instantiate DUT
    misr uut (
        .clk(clk),
        .rst(rst),
        .data_in(data_in),
        .signature(signature)
    );

    // Clock generation (10 ns period)
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        data_in = 4'b0000;

        // Apply reset
        #20;
        rst = 0;

        // Apply test inputs
        #10 data_in = 4'b1010;
        #10 data_in = 4'b1100;
        #10 data_in = 4'b0111;
        #10 data_in = 4'b1111;
        #10 data_in = 4'b0011;
        #10 data_in = 4'b1001;

        #50;
        $finish;
    end

    initial begin
        $monitor("Time=%0t | rst=%b | data_in=%b | signature=%b",
                  $time, rst, data_in, signature);
    end
    endmodule
