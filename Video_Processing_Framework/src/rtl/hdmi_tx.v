`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/16/2022 01:49:51 PM
// Design Name: 
// Module Name: hdmi_tx
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


module hdmi_tx(
input pixel_clk,
input pixel_5x_clk,
input rst_n,
//----vga timing---
input VGA_HS,
input VGA_VS,
input VGA_DE,
input [23:0] VGA_RGB,

//----hdmi timing---
output HDMI_CLK_P,
output HDMI_CLK_N,
output HDMI_D2_P,
output HDMI_D2_N,
output HDMI_D1_P,
output HDMI_D1_N,
output HDMI_D0_P,
output HDMI_D0_N
);
    
    wire [9:0] ch0_w,ch1_w,ch2_w;
  //---------- CH0 --------------
    TMDS_Encoder inst_encoder_ch0_blue(
        .clkin(pixel_clk),    // pixel clock input
        .rstin(!rst_n),    // async. reset input (active high)
        .din(VGA_RGB[7:0]),      // data inputs: expect registered
        .c0(VGA_HS),       // c0 input
        .c1(VGA_VS),       // c1 input
        .de(VGA_DE),       // de input
        .dout(ch0_w)      // data outputs
    );
    
    SerializerN_1 inst_ser_ch0_blue(
        .clk_i(pixel_clk),
        .serial_clk_i(pixel_5x_clk), // CLKDIV_I x N / 2
        .a_rst_n_i(rst_n),
        .p_data_i(ch0_w),
        .s_data_p_o(HDMI_D0_P),
        .s_data_n_o(HDMI_D0_N)
    );   
  //---------- CH1 --------------
    TMDS_Encoder inst_encoder_ch1_green(
        .clkin(pixel_clk),    // pixel clock input
        .rstin(!rst_n),    // async. reset input (active high)
        .din(VGA_RGB[15:8]),      // data inputs: expect registered
        .c0(1'b0),       // c0 input
        .c1(1'b0),       // c1 input
        .de(VGA_DE),       // de input
        .dout(ch1_w)      // data outputs
    );
    
    SerializerN_1 inst_ser_ch1_green(
        .clk_i(pixel_clk),
        .serial_clk_i(pixel_5x_clk), // CLKDIV_I x N / 2
        .a_rst_n_i(rst_n),
        .p_data_i(ch1_w),
        .s_data_p_o(HDMI_D1_P),
        .s_data_n_o(HDMI_D1_N)
    );
   //---------- CH2 --------------
    TMDS_Encoder inst_encoder_ch2_red(
        .clkin(pixel_clk),    // pixel clock input
        .rstin(!rst_n),    // async. reset input (active high)
        .din(VGA_RGB[23:16]),      // data inputs: expect registered
        .c0(1'b0),       // c2 input
        .c1(1'b0),       // c3 input
        .de(VGA_DE),       // de input
        .dout(ch2_w)      // data outputs
    );
    
    SerializerN_1 inst_ser_ch2_red(
        .clk_i(pixel_clk),
        .serial_clk_i(pixel_5x_clk), // CLKDIV_I x N / 2
        .a_rst_n_i(rst_n),
        .p_data_i(ch2_w),
        .s_data_p_o(HDMI_D2_P),
        .s_data_n_o(HDMI_D2_N)
    );
    //---------- HDMI_CLK_P & HDMI_CLK_M --------------
    SerializerN_1 inst_ser_exclk(
        .clk_i(pixel_clk),
        .serial_clk_i(pixel_5x_clk), // CLKDIV_I x N / 2
        .a_rst_n_i(rst_n),
        .p_data_i(10'b11111_00000),
        .s_data_p_o(HDMI_CLK_P),
        .s_data_n_o(HDMI_CLK_N)
    );
    
    
    
endmodule
