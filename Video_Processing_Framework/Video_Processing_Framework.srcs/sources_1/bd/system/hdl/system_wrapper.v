//Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
//Date        : Sat Sep 17 13:17:31 2022
//Host        : RTI01 running 64-bit major release  (build 9200)
//Command     : generate_target system_wrapper.bd
//Design      : system_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module system_wrapper
   (DDR_addr,
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
    cmos_25mhz,
    fdma_reset_n,
    pkg_rd_addr,
    pkg_rd_areq,
    pkg_rd_data,
    pkg_rd_en,
    pkg_rd_last,
    pkg_rd_size,
    pkg_wr_addr,
    pkg_wr_areq,
    pkg_wr_data,
    pkg_wr_en,
    pkg_wr_last,
    pkg_wr_size,
    ui_clk);
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
  inout IIC_scl_io;
  inout IIC_sda_io;
  output cmos_25mhz;
  output fdma_reset_n;
  input [31:0]pkg_rd_addr;
  input pkg_rd_areq;
  output [127:0]pkg_rd_data;
  output pkg_rd_en;
  output pkg_rd_last;
  input [31:0]pkg_rd_size;
  input [31:0]pkg_wr_addr;
  input pkg_wr_areq;
  input [127:0]pkg_wr_data;
  output pkg_wr_en;
  output pkg_wr_last;
  input [31:0]pkg_wr_size;
  output ui_clk;

  wire [14:0]DDR_addr;
  wire [2:0]DDR_ba;
  wire DDR_cas_n;
  wire DDR_ck_n;
  wire DDR_ck_p;
  wire DDR_cke;
  wire DDR_cs_n;
  wire [3:0]DDR_dm;
  wire [31:0]DDR_dq;
  wire [3:0]DDR_dqs_n;
  wire [3:0]DDR_dqs_p;
  wire DDR_odt;
  wire DDR_ras_n;
  wire DDR_reset_n;
  wire DDR_we_n;
  wire FIXED_IO_ddr_vrn;
  wire FIXED_IO_ddr_vrp;
  wire [53:0]FIXED_IO_mio;
  wire FIXED_IO_ps_clk;
  wire FIXED_IO_ps_porb;
  wire FIXED_IO_ps_srstb;
  wire IIC_scl_i;
  wire IIC_scl_io;
  wire IIC_scl_o;
  wire IIC_scl_t;
  wire IIC_sda_i;
  wire IIC_sda_io;
  wire IIC_sda_o;
  wire IIC_sda_t;
  wire cmos_25mhz;
  wire fdma_reset_n;
  wire [31:0]pkg_rd_addr;
  wire pkg_rd_areq;
  wire [127:0]pkg_rd_data;
  wire pkg_rd_en;
  wire pkg_rd_last;
  wire [31:0]pkg_rd_size;
  wire [31:0]pkg_wr_addr;
  wire pkg_wr_areq;
  wire [127:0]pkg_wr_data;
  wire pkg_wr_en;
  wire pkg_wr_last;
  wire [31:0]pkg_wr_size;
  wire ui_clk;

  IOBUF IIC_scl_iobuf
       (.I(IIC_scl_o),
        .IO(IIC_scl_io),
        .O(IIC_scl_i),
        .T(IIC_scl_t));
  IOBUF IIC_sda_iobuf
       (.I(IIC_sda_o),
        .IO(IIC_sda_io),
        .O(IIC_sda_i),
        .T(IIC_sda_t));
  system system_i
       (.DDR_addr(DDR_addr),
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
        .IIC_scl_i(IIC_scl_i),
        .IIC_scl_o(IIC_scl_o),
        .IIC_scl_t(IIC_scl_t),
        .IIC_sda_i(IIC_sda_i),
        .IIC_sda_o(IIC_sda_o),
        .IIC_sda_t(IIC_sda_t),
        .cmos_25mhz(cmos_25mhz),
        .fdma_reset_n(fdma_reset_n),
        .pkg_rd_addr(pkg_rd_addr),
        .pkg_rd_areq(pkg_rd_areq),
        .pkg_rd_data(pkg_rd_data),
        .pkg_rd_en(pkg_rd_en),
        .pkg_rd_last(pkg_rd_last),
        .pkg_rd_size(pkg_rd_size),
        .pkg_wr_addr(pkg_wr_addr),
        .pkg_wr_areq(pkg_wr_areq),
        .pkg_wr_data(pkg_wr_data),
        .pkg_wr_en(pkg_wr_en),
        .pkg_wr_last(pkg_wr_last),
        .pkg_wr_size(pkg_wr_size),
        .ui_clk(ui_clk));
endmodule
