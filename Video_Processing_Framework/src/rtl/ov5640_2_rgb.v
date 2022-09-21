`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/09/15 22:21:34
// Design Name: 
// Module Name: ov5640_2_rgb
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


module ov5640_2_rgb(
input cmos_clk_i,
//input rst_n_i,
input cmos_pclk_i,
input cmos_vsync_i,
input cmos_href_i,
input [7:0] cmos_data_i,
output cmos_xclk_o,

output vs_o,
output hs_o,
output de_o,
output  [23:0] rgb
);

reg [15:0]temp;

assign cmos_xclk_o = cmos_clk_i;
assign vs_o = cmos_vsync_i;
//----------- gen 24 bit 888 rgb sginal ------
assign rgb = {{3'b000,temp[15:11]},{2'b00,temp[10:5]},{3'b000,temp[4:0]}};
always@(posedge cmos_pclk_i) begin
    temp <= {temp[7:0],cmos_data_i};
end

//----------- gen right de sginal ------------
reg cnt = 0;
//always@(posedge cmos_pclk_i) begin
//    if(!rst_n_i) cnt = 0;
//    else if(cmos_href_i | cmos_href_r) cnt = cnt + 1'b1;
//    else cnt = 0;
//end

always@(posedge cmos_pclk_i) begin
    if(cmos_href_i | cmos_href_r) cnt = cnt + 1'b1;
    else cnt = 0;
end


reg cmos_href_r,cmos_href_r0;
always@(posedge cmos_pclk_i) begin
    cmos_href_r0 <= cmos_href_i;
    cmos_href_r <= cmos_href_r0;
end
assign    de_o = !cnt&cmos_href_r;



endmodule
