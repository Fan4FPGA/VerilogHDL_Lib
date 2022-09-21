`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/19/2022 01:34:35 PM
// Design Name: 
// Module Name: rgb2yuv
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
// ycbcr0(:,:,1) = 0.2568*image_in_r + 0.5041*image_in_g + 0.0979*image_in_b + 16;
 // ycbcr0(:,:,2) = -0.1482*image_in_r - 0.2910*image_in_g + 0.4392*image_in_b + 128; 
 // ycbcr0(:,:,3) = 0.4392*image_in_r - 0.3678*image_in_g - 0.0714*image_in_b + 128;
 // ycbcr0(:,:,1) = 256*( 0.2568*image_in_r + 0.5041*image_in_g + 0.0979*image_in_b + 16 )>>8; 
 // ycbcr0(:,:,2) = 256*(-0.1482*image_in_r - 0.2910*image_in_g + 0.4392*image_in_b + 128)>>8; 
 // ycbcr0(:,:,3) = 256*( 0.4392*image_in_r - 0.3678*image_in_g - 0.0714*image_in_b + 128)>>8; 
 
// ycbcr0(:,:,1) = (66*image_in_r + 129*image_in_g + 25*image_in_b + 4096 )>>8; 
// ycbcr0(:,:,2) = (-38*image_in_r - 74*image_in_g + 112*image_in_b + 32768)>>8; 
// ycbcr0(:,:,3) = (112*image_in_r - 94*image_in_g - 18*image_in_b + 32768 )>>8;
//YU(Cb)V(Cr)

module rgb2yuv(
 input clk_i,
 input rst_n_i,
 input vs_i,
 input de_i,
 input [23:0] rgb_i,
 
 output vs_o,
 output de_o,
 output [7:0] y_ch_o,
 output [7:0] u_ch_o,
 output [7:0] v_ch_o
);

reg [15:0] r_d0,g_d0,b_d0;
reg [15:0] r_d1,g_d1,b_d1;
reg [15:0] r_d2,g_d2,b_d2;

 reg [15:0] y_ch_r;
 reg [15:0] u_ch_r;
 reg [15:0] v_ch_r;

always @(posedge clk_i or negedge rst_n_i) begin
    if(!rst_n_i) begin
        r_d0 <= 16'd0;
        g_d0<= 16'd0;
        b_d0<= 16'd0;
        r_d1<= 16'd0;
        g_d1<= 16'd0;
        b_d1<= 16'd0;
        r_d2<= 16'd0;
        g_d2<= 16'd0;
        b_d2<= 16'd0;
    end
    else begin
          r_d0 <= rgb_i[23:16]*66;
          g_d0 <= rgb_i[15:8]*129;
          b_d0 <= rgb_i[7:0]*25;
          
          r_d1 <= rgb_i[23:16]*38;
          g_d1 <= rgb_i[15:8]*74;
          b_d1 <= rgb_i[7:0]*112;
          
          r_d2 <= rgb_i[23:16]*112;
          g_d2 <= rgb_i[15:8]*94;
          b_d2 <= rgb_i[7:0]*18;
    end
end

always @(posedge clk_i or negedge rst_n_i) begin
 if(!rst_n_i) begin
    y_ch_r <= 16'd0;
    u_ch_r <= 16'd0;
    v_ch_r <= 16'd0;
 end
 else begin
    y_ch_r <= r_d0 + g_d0 + b_d0 + 4096;
    u_ch_r <= b_d1 - r_d1 - g_d1 + 32768;
    v_ch_r <= r_d2 - g_d2 - b_d2 + 32768;
 end
end

assign y_ch_o = y_ch_r[15:8];
assign u_ch_o = u_ch_r[15:8];
assign v_ch_o = v_ch_r[15:8];

// sync vs and de

reg [1:0] vs_r;
reg [1:0] de_r;

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
