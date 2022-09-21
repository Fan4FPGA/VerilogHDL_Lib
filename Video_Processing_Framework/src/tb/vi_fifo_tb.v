`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/13/2022 01:31:12 PM
// Design Name: 
// Module Name: vi_fifo_tb
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


module vi_fifo_tb;
    reg p_clk,ui_clk;
    reg ui_rst_n;
    reg [23:0]p_data;
    reg pkg_wr_en;
    reg p_wr_en;
    wire [127:0] pkg_wr_data;
    wire [9:0] rd_data_count;
    
   integer i;
  initial begin
  ui_rst_n = 1;
  p_clk = 0;
  ui_clk = 0;
  pkg_wr_en = 0;
  p_wr_en = 0;
  #143 
  ui_rst_n = 0;
  #10000
  for(i= 0; i<512; i=i+1)begin
    p_data =i;
    p_wr_en = 1;
    #20;
  end
  p_wr_en = 0;
  pkg_wr_en = 1;
  
  #20000 
  $stop;
  
  
  end
  always #10  p_clk = !p_clk;
  always #5 ui_clk = !ui_clk;
  
    

    vi_fifo inst_vi_fifo (
      .rst(ui_rst_n),                   // input wire rst
      
      .wr_clk(p_clk),                  // input wire wr_clk
      .din({8'd0,p_data}),             // input wire [31 : 1'b0] din
      .wr_en(p_wr_en),                 // input wire wr_en
      
      .rd_clk(ui_clk),                  // input wire rd_clk 
      .rd_en(pkg_wr_en),              // input wire rd_en
      .dout(pkg_wr_data),               // output wire [127 : 1'b0] dout
      .rd_data_count(rd_data_count)                  // output wire [11 : 1'b0] rd_data_count
    );


endmodule
