`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/08/2022 02:19:24 PM
// Design Name: 
// Module Name: system_top
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


module system_top(
    DDR_addr,
    DDR_ba,
    DDR_cas_n,
    DDR_ck_n,
    DDR_ck_p,
    DDR_cke,
    DDR_cs_n,
    DDR_dm,
    DDR_dq,
    DDR_dqs_n,
    DDR_dqs_p,
    DDR_odt,
    DDR_ras_n,
    DDR_reset_n,
    DDR_we_n,
    FIXED_IO_ddr_vrn,
    FIXED_IO_ddr_vrp,
    FIXED_IO_mio,
    FIXED_IO_ps_clk,
    FIXED_IO_ps_porb,
    FIXED_IO_ps_srstb,
    IIC_scl_io,
    IIC_sda_io,
    //hdmi_tx
    HDMI_CLK_P,
    HDMI_CLK_N,
    HDMI_D2_P,
    HDMI_D2_N,
    HDMI_D1_P,
    HDMI_D1_N,
    HDMI_D0_P,
    HDMI_D0_N,
    cmos_pclk_i,
    cmos_vsync_i,
    cmos_href_i,
    cmos_data_i,
    cmos_xclk_o
    
    );
 
    //ov5640 sensor
    input          cmos_pclk_i;
    input          cmos_vsync_i;
    input          cmos_href_i;
    input [7:0]    cmos_data_i;
    output         cmos_xclk_o;
        
    //fixed port in PS
     inout [14:0]DDR_addr;
     inout [2:0]DDR_ba;
     inout DDR_cas_n;
     inout DDR_ck_n;
     inout DDR_ck_p;
     inout DDR_cke;
     inout DDR_cs_n;
     inout [3:0]DDR_dm;
     inout [31:0]DDR_dq;
     inout [3:0]DDR_dqs_n;
     inout [3:0]DDR_dqs_p;
     inout DDR_odt;
     inout DDR_ras_n;
     inout DDR_reset_n;
     inout DDR_we_n;
     inout FIXED_IO_ddr_vrn;
     inout FIXED_IO_ddr_vrp;
     inout [53:0]FIXED_IO_mio;
     inout FIXED_IO_ps_clk;
     inout FIXED_IO_ps_porb;
     inout FIXED_IO_ps_srstb;  
     //user port  
     inout IIC_scl_io;
     inout IIC_sda_io;
     //hdmi port
     output HDMI_CLK_P;
     output HDMI_CLK_N;
     output HDMI_D2_P;
     output HDMI_D2_N;
     output HDMI_D1_P;
     output HDMI_D1_N;
     output HDMI_D0_P;
     output HDMI_D0_N;
     
     
      //user port
      //clock_100Mhz and  reset(active low) from system clocking wizard
      wire        fdma_reset_n_w;
      wire        ui_clk_w;
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
     
     wire clk_25Mhz;
     
     wire VGA_VS_w;
     wire VGA_HS_w;
     wire VGA_DE_w;
     wire [23:0] VGA_RGB_w;
     
     wire p_clk;
     wire p_fs_w;  
     wire p_wr_en_w;
     wire [23:0] p_data_w;
     
//---------------------- async reset sync assert -----------------------------------------     
//     wire async_rst_n_w;
//     wire sys_rst_n;
//     reg sys_rst_n_r0,sys_rst_n_r1;
//    assign async_rst_n_w = fdma_reset_n_w & lockd;
//    assign sys_rst_n = sys_rst_n_r1;
//    always @(posedge ui_clk_w) begin
//        if(!async_rst_n_w)begin
//            sys_rst_n_r0 <= 1'b0;
//            sys_rst_n_r1 <= 1'b0;
//        end
//        else begin
//            sys_rst_n_r0 <= 1'b1;
//            sys_rst_n_r1 <= sys_rst_n_r0;
//        end
//    end
//-------------------------------------- instance ZYNQ -----------------------------------------------------     
     system_wrapper inst_systrm_wrp(
         .DDR_addr(DDR_addr),
         .DDR_ba(DDR_ba),
         .DDR_cas_n(DDR_cas_n),
         .DDR_ck_n(DDR_ck_n),
         .DDR_ck_p(DDR_ck_p),
         .DDR_cke(DDR_cke),
         .DDR_cs_n(DDR_cs_n),
         .DDR_dm(DDR_dm),
         .DDR_dq(DDR_dq),
         .DDR_dqs_n(DDR_dqs_n),
         .DDR_dqs_p(DDR_dqs_p),
         .DDR_odt(DDR_odt),
         .DDR_ras_n(DDR_ras_n),
         .DDR_reset_n(DDR_reset_n),
         .DDR_we_n(DDR_we_n),
         .FIXED_IO_ddr_vrn(FIXED_IO_ddr_vrn),
         .FIXED_IO_ddr_vrp(FIXED_IO_ddr_vrp),
         .FIXED_IO_mio(FIXED_IO_mio),
         .FIXED_IO_ps_clk(FIXED_IO_ps_clk),
         .FIXED_IO_ps_porb(FIXED_IO_ps_porb),
         .FIXED_IO_ps_srstb(FIXED_IO_ps_srstb),
         .IIC_scl_io(IIC_scl_io),
         .IIC_sda_io(IIC_sda_io),
         //
         .cmos_25mhz(clk_25Mhz),
         //
         .pkg_rd_addr(pkg_rd_addr_w),
         .pkg_rd_areq(pkg_rd_areq_w),
         .pkg_rd_data(pkg_rd_data_w),
         .pkg_rd_en(pkg_rd_en_w),
         .pkg_rd_last(pkg_rd_last_w),
         .pkg_rd_size(pkg_rd_size_w),
         .pkg_wr_addr(pkg_wr_addr_w),
         .pkg_wr_areq(pkg_wr_areq_w),
         .pkg_wr_data(pkg_wr_data_w),
         .pkg_wr_en(pkg_wr_en_w),
         .pkg_wr_last(pkg_wr_last_w),
         .pkg_wr_size(pkg_wr_size_w),
         //
         .fdma_reset_n(fdma_reset_n_w),
         .ui_clk(ui_clk_w)
         );
 //------------------------------ OV5640 cap ----------------------------------------------        
//sensor_data_sim_gen  inst_sensor_data_sim_gen(
//             .clk(clk_74_25Mhz),
//             .rst_n_i(fdma_reset_n_w),
//             .rgb(p_data_w),
//             .de(p_wr_en_w),
//             .vsync(p_fs_w),
//             .hsync(),
//             .pclk(p_clk)
//             );  
             
ov5640_2_rgb inst_ov5640_2_rgb(
    .cmos_clk_i(clk_25Mhz),//25Mhz
   // .rst_n_i(),
    .cmos_pclk_i(cmos_pclk_i),
    .cmos_vsync_i(cmos_vsync_i),
    .cmos_href_i(cmos_href_i),
    .cmos_data_i(cmos_data_i),
    .cmos_xclk_o(cmos_xclk_o),
    //
    .vs_o(p_fs_w),
    .hs_o(),
    .de_o(p_wr_en_w),
    .rgb(p_data_w)              
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
             .p_clk(cmos_pclk_i), //pclk 96Mhz/192Mhz
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
//-------------------- hdmi tx -------------------------------------------------------------
    hdmi_tx inst_hdmi_tx(
         .pixel_clk(clk_74_25Mhz),      //74.25Mhz if video is 720p(1280*720)
         .pixel_5x_clk(clk_371_25Mhz),   //371.25 if video is 720p(1280*720)
         .rst_n(lockd),
         //----vga timing---
         .VGA_HS(VGA_HS_w),         //timing in 720p
         .VGA_VS(VGA_VS_w),         //timing in 720p
         .VGA_DE(VGA_DE_w),          //timing in 720p
         .VGA_RGB(VGA_RGB_w),        //RGB[23:16] Red; RGB[15:8] Green; RGB[7:0] Blue;
         //----hdmi timing---
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
