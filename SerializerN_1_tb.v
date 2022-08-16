`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/16/2022 02:41:05 PM
// Design Name: 
// Module Name: SerializerN_1_tb
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


module SerializerN_1_tb;

reg clk_i;
reg serial_clk_i; // CLKDIV_I x N / 2
reg a_rst_n_i;
reg [9:0] p_data_i;
wire s_data_p_o;
wire s_data_n_o;
    
    SerializerN_1 inst0(
    .clk_i(clk_i),
    .serial_clk_i(serial_clk_i), // CLKDIV_I x N / 2
    .a_rst_n_i(a_rst_n_i),
    .p_data_i(p_data_i),
    .s_data_p_o(s_data_p_o),
    .s_data_n_o(s_data_n_o)
    );
  initial begin
        clk_i = 0;
        serial_clk_i = 0;
        a_rst_n_i = 0;
         p_data_i = 10'h000;
        #450 
        a_rst_n_i = 1;
        #150 
        p_data_i = 10'h201;
        #100
        p_data_i = 10'h303;
        #100
        p_data_i = 10'h00;
        #2000
        $stop;
    end
    
    always #50 clk_i =~clk_i;
    always #10 serial_clk_i =~serial_clk_i;





endmodule
