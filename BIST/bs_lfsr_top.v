`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.04.2026 15:24:52
// Design Name: 
// Module Name: bs_lfsr_top
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


module bs_lfsr_top (
    input clk,
    input rst,
    output [3:0] led
);

    reg [25:0] counter = 0;
    wire slow_clk;

    // ✅ Proper counter with reset
    always @(posedge clk or posedge rst) begin
        if (rst)
            counter <= 0;
        else
            counter <= counter + 1;
    end

    // ✅ Use this for simulation (fast toggle)
    // 👉 Change back to [25] for FPGA
    assign slow_clk = counter[3];

    reg [3:0] lfsr = 4'b1000;

    wire feedback;
    wire [3:0] next_lfsr;
    wire [3:0] swapped;

    // ✅ Correct feedback (XOR taps)
    assign feedback = lfsr[3] ^ lfsr[0];

    // ✅ Standard right-shift LFSR
    assign next_lfsr = {feedback, lfsr[3:1]};

    // ✅ Bit-swapping logic (only when MSB = 0)
    assign swapped[0] = (lfsr[3] == 0) ? next_lfsr[1] : next_lfsr[0];
    assign swapped[1] = (lfsr[3] == 0) ? next_lfsr[0] : next_lfsr[1];
    assign swapped[3:2] = next_lfsr[3:2];

    // ✅ LFSR update
    always @(posedge slow_clk or posedge rst) begin
        if (rst)
            lfsr <= 4'b1000;
        else
            lfsr <= swapped;
    end

    // ✅ Output
    assign led = lfsr;

endmodule