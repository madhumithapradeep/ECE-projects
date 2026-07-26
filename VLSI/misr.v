`timescale 1ns/ 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.04.2026 09:07:48
// Design Name: 
// Module Name: misr
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


module misr(
    input clk,
    input rst,
    input [3:0] data_in,
    output reg [3:0] signature
    );
       wire feedback;

    assign feedback = signature[3] ^ data_in[0];

    always @(posedge clk or posedge rst) begin
        if (rst)
            signature <= 4'b0000;
        else begin
            signature[3] <= feedback;
            signature[2] <= signature[3] ^ data_in[1];
            signature[1] <= signature[2] ^ data_in[2];
            signature[0] <= signature[1] ^ data_in[3];
        end
    end

endmodule
