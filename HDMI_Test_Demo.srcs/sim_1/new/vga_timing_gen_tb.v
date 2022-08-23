`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/17/2022 05:09:30 PM
// Design Name: 
// Module Name: vga_timing_gen_tb
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


module vga_timing_gen_tb;
reg         clk_i;
reg         rst_n_i;
wire        VGA_VS;
wire        VGA_HS;
wire        VGA_DE;
wire [23:0] VGA_RGB;

 vga_timing_gen inst(
    .clk_i(clk_i),
    .rst_n_i(rst_n_i),
    .VGA_VS(VGA_VS),
    .VGA_HS(VGA_HS),
    .VGA_DE(VGA_DE),
    .VGA_RGB(VGA_RGB)
);

initial begin 
    clk_i = 0;
    rst_n_i = 0;
    #200.1
    rst_n_i = 1;
    #200000000
    $stop;
end

always #10 clk_i = ~clk_i;




endmodule
