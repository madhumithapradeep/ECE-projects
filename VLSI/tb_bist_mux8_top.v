`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.04.2026 14:57:00
// Design Name: 
// Module Name: tb_bist_mux8_top
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


module tb_bist_mux8_top;
reg clk;
reg rst;

wire [7:0] test_pattern;
wire cut_out;
wire [7:0] signature;
wire pass_fail;

bist_mux8_top uut(
    .clk(clk),
    .rst(rst),
    .test_pattern(test_pattern),
    .cut_out(cut_out),
    .signature(signature),
    .pass_fail(pass_fail)
);

always #20 clk = ~clk;

initial
begin
    clk = 0;
    rst = 1;

    #20 rst = 0;

    #3000;

    $finish;
end

initial
begin
    $monitor("Time=%0t | Pattern=%b | CUT=%b | Signature=%b | PASS=%b",
              $time,test_pattern,cut_out,signature,pass_fail);
end
endmodule
