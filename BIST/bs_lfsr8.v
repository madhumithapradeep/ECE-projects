`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.04.2026 14:52:48
// Design Name: 
// Module Name: bs_lfsr8
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


module bs_lfsr8(
    input clk,
    input rst,
    output [7:0] led
    );
    reg [7:0] lfsr;
wire feedback;
wire [7:0] next_lfsr;
wire [7:0] swapped;

assign feedback  = lfsr[7] ^ lfsr[5];
assign next_lfsr = {feedback, lfsr[7:1]};

// swap lower 2 bits when MSB = 0
assign swapped[0] = (lfsr[7]==0) ? next_lfsr[1] : next_lfsr[0];
assign swapped[1] = (lfsr[7]==0) ? next_lfsr[0] : next_lfsr[1];
assign swapped[7:2] = next_lfsr[7:2];

always @(posedge clk or posedge rst)
begin
    if(rst)
        lfsr <= 8'b10000000;
    else
        lfsr <= swapped;
end

assign led = lfsr;

endmodule


/////////////////////////////////////////////////////////////
// 8:1 MUX using basic gates
/////////////////////////////////////////////////////////////
module mux8to1_cut_new(
    input i0,input i1,input i2,input i3,
    input i4,input i5,input i6,input i7,
    input s0,input s1,input s2,
    output y
);

wire s0b,s1b,s2b;
wire w0,w1,w2,w3,w4,w5,w6,w7;

not(s0b,s0);
not(s1b,s1);
not(s2b,s2);

and(w0,i0,s2b,s1b,s0b);
and(w1,i1,s2b,s1b,s0 );
and(w2,i2,s2b,s1 ,s0b);
and(w3,i3,s2b,s1 ,s0 );
and(w4,i4,s2 ,s1b,s0b);
and(w5,i5,s2 ,s1b,s0 );
and(w6,i6,s2 ,s1 ,s0b);
and(w7,i7,s2 ,s1 ,s0 );

or(y,w0,w1,w2,w3,w4,w5,w6,w7);

endmodule


/////////////////////////////////////////////////////////////
// 8-bit MISR
/////////////////////////////////////////////////////////////
module misr8(
    input clk,
    input rst,
    input [7:0] data_in,
    output reg [7:0] signature
);

wire feedback;

assign feedback = signature[7] ^ data_in[0];

always @(posedge clk or posedge rst)
begin
    if(rst)
        signature <= 8'b00000000;
    else begin
        signature[7] <= feedback;
        signature[6] <= signature[7] ^ data_in[1];
        signature[5] <= signature[6] ^ data_in[2];
        signature[4] <= signature[5] ^ data_in[3];
        signature[3] <= signature[4] ^ data_in[4];
        signature[2] <= signature[3] ^ data_in[5];
        signature[1] <= signature[2] ^ data_in[6];
        signature[0] <= signature[1] ^ data_in[7];
    end
end

endmodule


/////////////////////////////////////////////////////////////
// TOP MODULE : BIST for 8:1 MUX
/////////////////////////////////////////////////////////////
module bist_mux8_top(
    input clk,
    input rst,
    output [7:0] test_pattern,
    output cut_out,
    output [7:0] signature,
    output pass_fail
);

wire [7:0] led;
wire mux_y;
wire [7:0] misr_in;

/////////////////////////////////////////////////////////////
// PRPG
/////////////////////////////////////////////////////////////
bs_lfsr8 prpg(
    .clk(clk),
    .rst(rst),
    .led(led)
);

assign test_pattern = led;

/////////////////////////////////////////////////////////////
// CUT
/////////////////////////////////////////////////////////////
mux8to1_cut cut(
    .i0(led[0]),
    .i1(led[1]),
    .i2(led[2]),
    .i3(led[3]),
    .i4(led[4]),
    .i5(led[5]),
    .i6(led[6]),
    .i7(led[7]),
    .s0(led[0]),
    .s1(led[1]),
    .s2(led[2]),
    .y(mux_y)
);

assign cut_out = mux_y;

/////////////////////////////////////////////////////////////
// MISR
/////////////////////////////////////////////////////////////
assign misr_in = {7'b0000000,mux_y};

misr8 resp(
    .clk(clk),
    .rst(rst),
    .data_in(misr_in),
    .signature(signature)
);

/////////////////////////////////////////////////////////////
// Comparator
/////////////////////////////////////////////////////////////
assign pass_fail = (signature == 8'b00000100) ? 1'b1 : 1'b0;
endmodule
