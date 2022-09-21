`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/13/2022 10:46:07 AM
// Design Name: 
// Module Name: function_test_tb
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


module function_test_tb;


      reg        fdma_reset_n_w;
      reg        ui_clk_w;
      //fdma_controll_ports
      wire [31:0] pkg_rd_addr_w;
      wire        pkg_rd_areq_w;
      wire [127:0]pkg_rd_data_w;
      wire        pkg_rd_en_w;
      wire        pkg_rd_last_w;
      wire [31:0] pkg_rd_size_w;
      wire [31:0] pkg_wr_addr_w;
      wire        pkg_wr_areq_w;
      wire [127:0]pkg_wr_data_w;
      wire        pkg_wr_en_w;
      wire        pkg_wr_last_w;
      wire [31:0] pkg_wr_size_w;
     
     wire clk_74_25Mhz;       //720p 时钟为输入时钟为74.25MHz
     wire clk_371_25Mhz;
     wire lockd;
     
     wire VGA_VS_w;
     wire VGA_HS_w;
     wire VGA_DE_w;
     wire [23:0] VGA_RGB_w;
     
     wire p_clk;
     wire p_fs_w;  
     wire p_wr_en_w;
     wire [23:0] p_data_w;
     
     
     initial begin
         ui_clk_w = 0;
         fdma_reset_n_w = 0;
         #200
         fdma_reset_n_w = 1;
     end
     
     always #5 ui_clk_w = ~ui_clk_w;
     

 //----------------------------------------------------------------------------        
sensor_data_sim_gen  inst_sensor_data_sim_gen(
             .clk(clk_74_25Mhz),
             .rgb(p_data_w),
             .de(p_wr_en_w),
             .vsync(p_fs_w),
             .hsync(),
             .pclk(p_clk)
             );         
         
 
//--------------------------------- cache data by using FMDA access PS DDR3 --------------------------------------------------------------         
parameter DDR_BASE = (10*1024*1024);       
         
cache_data_controller#(
.ADDR_OFFSET(DDR_BASE),
.BUF_SIZE(3),
.H_CNT(1280), 
.V_CNT(720)    
)inst_cache_data_controller (
             .ui_clk(ui_clk_w), //100Mhz
             .ui_rst_n(fdma_reset_n_w),
             //
             .p_clk(p_clk), //pclk 96Mhz/192Mhz
             .p_fs(p_fs_w),
             .p_wr_en(p_wr_en_w),
             .p_data(p_data_w),
             //
             .vga_clk(clk_74_25Mhz),//74.25Mhz
             .vga_fs(VGA_VS_w),
             .vga_rd_en(VGA_DE_w),
             .vga_data(VGA_RGB_w),
             //
             .pkg_rd_addr(pkg_rd_addr_w),
             .pkg_rd_areq(pkg_rd_areq_w),
             .pkg_rd_data(pkg_rd_data_w),
             .pkg_rd_en(pkg_rd_en_w),
             .pkg_rd_last(pkg_rd_last_w),
             .pkg_rd_size(pkg_rd_size_w),
             //
             .pkg_wr_addr(pkg_wr_addr_w),
             .pkg_wr_areq(pkg_wr_areq_w),
             .pkg_wr_data(pkg_wr_data_w),
             .pkg_wr_en(pkg_wr_en_w),
             .pkg_wr_last(pkg_wr_last_w),
             .pkg_wr_size(pkg_wr_size_w)
             );
             
//-------------------- gen hdmi 720p colock --------------------------------------------   
     clk_wiz_0 inst_hdmi_clock(
            .clk_out1(clk_74_25Mhz),
            .clk_out2(clk_371_25Mhz),
            .locked(lockd),
            .clk_in1(ui_clk_w),
            .resetn(fdma_reset_n_w)
       );
    
//-------------------- gen vga timing ---------------------------------------------------             
    vga_timing_gen inst_vga_timing_gen(
             .clk_i(clk_74_25Mhz),        //720p 时钟为输入时钟为74.25MHz
             .rst_n_i(lockd),
            
             .VGA_VS(VGA_VS_w),
             .VGA_HS(VGA_HS_w),
             .VGA_DE(VGA_DE_w)
             //output reg [23:0] VGA_RGB
             );

endmodule
