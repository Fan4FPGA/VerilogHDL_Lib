`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/20/2022 04:25:17 PM
// Design Name: 
// Module Name: yuv2rgb
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
/*
R = 1.1644*(Y- 16) + 1.5960*(Cr - 128); 
G = 1.1644*(Y - 16) - 0.3918*(Cb- 128) -0.8130*(Cr- 128); 
B = 1.1644*(Y - 16) + 2.0172*(Cb- 128);


R = (298*Y+ 409*Cr - 56992)>>8;
G = (298*Y - 100*Cb  - 208*Cr + 34816)>>8; 
B = (298*Y + 516*Cb - 70912)>>8;
*/
//YU(Cb)V(Cr)

module yuv2rgb(
input       clk_i,
input       rst_n_i,
input       vs_i,
input       de_i,
input [7:0] y_ch_i,
input [7:0] u_ch_i,
input [7:0] v_ch_i,

output      vs_o,
output      de_o,
output [23:0] rgb
);

reg [1:0] vs_r;
reg [1:0] de_r;

reg [15:0] y_dat_1_r;
reg [15:0] u_dat_1_r;
reg [15:0] v_dat_1_r;
reg [15:0] y_dat_2_r;
reg [15:0] u_dat_2_r;
reg [15:0] v_dat_2_r;
reg [15:0] y_dat_3_r;
reg [15:0] u_dat_3_r;
reg [15:0] v_dat_3_r;

reg [15:0] rgb_r_r;
reg [15:0] rgb_g_r;
reg [15:0] rgb_b_r;


always @(posedge clk_i or negedge rst_n_i) begin
  if(!rst_n_i)begin
    y_dat_1_r<=16'd0;
    u_dat_1_r<=16'd0;
    v_dat_1_r<=16'd0;
    y_dat_2_r<=16'd0;
    u_dat_2_r<=16'd0;
    v_dat_2_r<=16'd0;
    y_dat_3_r<=16'd0;
    u_dat_3_r<=16'd0;
    v_dat_3_r<=16'd0;
  end
  else begin
    y_dat_1_r <= 298*y_ch_i;
    v_dat_1_r <= 408*v_ch_i;
    
    y_dat_2_r <= 298*y_ch_i;
    u_dat_2_r <= 100*u_ch_i;
    v_dat_2_r <= 208*v_ch_i;
    
    y_dat_3_r <= 298*y_ch_i;
    u_dat_3_r <= 516*u_ch_i;
  end
end

always @(posedge clk_i or negedge rst_n_i) begin
  if(!rst_n_i) begin
    rgb_r_r <= 16'd0;
    rgb_g_r <= 16'd0;
    rgb_b_r <= 16'd0;
  end
  else begin
    rgb_r_r <= y_dat_1_r + v_dat_1_r - 57088;
    rgb_g_r <= y_dat_2_r - u_dat_2_r - v_dat_2_r + 34816;
    rgb_b_r <= y_dat_3_r + u_dat_3_r - 70912;
  end
end

assign rgb = {rgb_r_r[15:8],rgb_g_r[15:8],rgb_b_r[15:8]};

// -------------------------------------------------------------
always @(posedge clk_i or negedge rst_n_i) begin
  if(!rst_n_i) begin
    vs_r <= 2'b00;
    de_r <= 2'b00;
  end
  else begin
    vs_r <= {vs_r[0],vs_i};
    de_r <= {de_r[0],de_i};
  end
end

assign vs_o = vs_r[1];
assign de_o = de_r[1];



endmodule
