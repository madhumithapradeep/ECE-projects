`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.11.2025 16:05:17
// Design Name: 
// Module Name: aes_fpga
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

`timescale 1ns / 1ps
// -----------------------------------------------------------------------------
// AES-128 Basys3 Demo Wrapper
// Connects aes128_encrypt core to simple inputs/outputs for FPGA implementation.
// -----------------------------------------------------------------------------
module aes_top_basys3(
    input  wire CLK100MHZ,      // 100 MHz on-board clock
    input  wire btnC,           // center button -> start encryption
    input  wire btnR,           // right button  -> reset
    output wire [15:0] LED      // show lower 16 bits of ciphertext
);

    wire clk   = CLK100MHZ;
    wire rst_n = ~btnR;   // active-low reset
    wire start = btnC;    // start pulse
    wire valid;
    wire ready;
    wire [127:0] ciphertext;

    // Fixed plaintext & key (ASCII)
    localparam [127:0] KEY  = 128'h5468617473206d79206b756e67204675; // "Thats my Kung Fu"
    localparam [127:0] PTXT = 128'h54776f204f6e65204e696e652054776f; // "Two One Nine Two"

    // AES core instance
    aes128_encrypt aes_core (
        .clk(clk),
        .rst_n(rst_n),
        .start(start),
        .key(KEY),
        .plaintext(PTXT),
        .ready(ready),
        .valid(valid),
        .ciphertext(ciphertext)
    );

    // Drive LEDs with part of the ciphertext
    // Ciphertext of the fixed vector = 0x29C3505F571420F6402299B31A02D73A
    // Display lower 16 bits when valid is asserted.
    reg [15:0] led_r = 0;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            led_r <= 16'h0000;
        else if (valid)
            led_r <= ciphertext[15:0];
    end

    assign LED = led_r;

endmodule
