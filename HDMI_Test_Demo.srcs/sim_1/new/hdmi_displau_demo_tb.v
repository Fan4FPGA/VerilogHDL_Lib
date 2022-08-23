`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/18/2022 10:05:15 AM
// Design Name: 
// Module Name: hdmi_displau_demo_tb
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


module hdmi_displau_demo_tb;
reg clk_i;     
wire HDMI_CLK_P;
wire HDMI_CLK_N;
wire HDMI_D2_P;
wire HDMI_D2_N; 
wire HDMI_D1_P; 
wire HDMI_D1_N; 
wire HDMI_D0_P; 
wire HDMI_D0_N; 

hdmi_display_demo inst_hdmi_display_demo(
.clk_i(clk_i),
.HDMI_CLK_P(HDMI_CLK_P),
.HDMI_CLK_N(HDMI_CLK_N),
.HDMI_D2_P(HDMI_D2_P),
.HDMI_D2_N(HDMI_D2_N),
.HDMI_D1_P(HDMI_D1_P),
.HDMI_D1_N(HDMI_D1_N),
.HDMI_D0_P(HDMI_D0_P),
.HDMI_D0_N(HDMI_D0_N)
);

initial begin 
    clk_i = 0;
    #200000000
    $stop;
end

always #5 clk_i = ~clk_i;


endmodule
