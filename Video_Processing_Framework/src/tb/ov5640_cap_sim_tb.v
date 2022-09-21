`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/09/15 22:47:35
// Design Name: 
// Module Name: ov5640_cap_sim_tb
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


module ov5640_cap_sim_tb;
reg           cmos_clk_i;
reg           rst_n_i;

wire           cmos_pclk_i;
wire           cmos_vsync_i;
wire           cmos_href_i;
wire [7:0]     cmos_data_i;
wire           cmos_xclk_o;

wire          vs_o;
wire          hs_o;
wire          de_o;
wire  [23:0]  rgb;

initial begin
    cmos_clk_i = 0;
    rst_n_i = 0;
    #200;
    rst_n_i = 1;
    

end

always #5 cmos_clk_i = !cmos_clk_i;




ov5640_2_rgb inst_ov5640_2_rgb(
.cmos_clk_i(cmos_clk_i),
.rst_n_i(rst_n_i),
.cmos_pclk_i(cmos_pclk_i),
.cmos_vsync_i(cmos_vsync_i),
.cmos_href_i(cmos_href_i),
.cmos_data_i(cmos_data_i),
.cmos_xclk_o(cmos_xclk_o),

.vs_o(vs_o),
.hs_o(hs_o),
.de_o(de_o),
.rgb(rgb)
);

OV5640_Model inst_OV5640_Model(
.cmos_xclk_i(cmos_xclk_o),
.cmos_pclk_o(cmos_pclk_i),
.cmos_vsync_o(cmos_vsync_i),
.cmos_href_o(cmos_href_i),
.cmos_data_o(cmos_data_i)
);


endmodule
