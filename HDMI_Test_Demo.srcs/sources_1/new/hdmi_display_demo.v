`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/17/2022 02:27:40 PM
// Design Name: 
// Module Name: hdmi_display_demo
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


module hdmi_display_demo(
input clk_i,
//input rst_n_i,
output HDMI_CLK_P,
output HDMI_CLK_N,
output HDMI_D2_P,
output HDMI_D2_N,
output HDMI_D1_P,
output HDMI_D1_N,
output HDMI_D0_P,
output HDMI_D0_N
);

wire vga_vs_w,vga_hs_w,vga_de_w;
wire [23:0] vga_rgb_w;

wire pixel_clk_w;
wire pixel_5x_clk_w;
wire locked_w;

wire async_RESET_n;
reg sys_rst_n_r0,sys_rst_n_r;

assign 	   sys_rst_n = sys_rst_n_r		;
//assign async_RESET_n = rst_n_i & locked_w	;
assign async_RESET_n = locked_w	;

always @(posedge clk_i or negedge async_RESET_n)begin
	if(!async_RESET_n)begin
        sys_rst_n_r0 <= 1'b0;
        sys_rst_n_r <= 1'b0;
	end
	else begin
        sys_rst_n_r0 <= 1'b1;
        sys_rst_n_r <= sys_rst_n_r0;
	end
end


clk_wiz_0 inst_clk_wiz_0(
  .clk_out1(pixel_clk_w),   //74.25Mhz
  .clk_out2(pixel_5x_clk_w),//371.25
  .locked(locked_w),
  .clk_in1(clk_i)  //input clk 100Mhz
 );

vga_timing_gen inst_vga_timing_gen(
    .clk_i(pixel_clk_w),
    .rst_n_i(sys_rst_n),
    .VGA_VS(vga_vs_w),
    .VGA_HS(vga_hs_w),
    .VGA_DE(vga_de_w),
    .VGA_RGB(vga_rgb_w)
);

hdmi_tx inst_hdmi_tx(
    .pixel_clk(pixel_clk_w),
    .pixel_5x_clk(pixel_5x_clk_w),
    .rst_n(sys_rst_n),
    
    .VGA_HS(vga_hs_w),
    .VGA_VS(vga_vs_w),
    .VGA_DE(vga_de_w),
    .VGA_RGB(vga_rgb_w),
    
    .HDMI_CLK_P(HDMI_CLK_P),
    .HDMI_CLK_N(HDMI_CLK_N),
    .HDMI_D2_P(HDMI_D2_P),
    .HDMI_D2_N(HDMI_D2_N),
    .HDMI_D1_P(HDMI_D1_P),
    .HDMI_D1_N(HDMI_D1_N),
    .HDMI_D0_P(HDMI_D0_P),
    .HDMI_D0_N(HDMI_D0_N)
);

endmodule
