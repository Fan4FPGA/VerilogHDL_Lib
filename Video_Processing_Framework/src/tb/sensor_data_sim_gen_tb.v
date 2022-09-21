`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/13/2022 05:03:56 PM
// Design Name: 
// Module Name: sensor_data_sim_gen_tb
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


module sensor_data_sim_gen_tb;
reg          clk    ;
wire [23:0 ] rgb    ;
wire         de     ;
wire         vsync  ;
wire         hsync  ;
wire         pclk   ;

    sensor_data_sim_gen inst_sensor_data_sim_gen(
    .clk  (clk)     ,
    .rgb  (rgb)     ,
    .de   (de)      ,
    .vsync(vsync)      ,
    .hsync(hsync)      ,
    .pclk (pclk)
    );  
    initial begin clk = 0; end
    
    always #1 clk = !clk;  


endmodule
