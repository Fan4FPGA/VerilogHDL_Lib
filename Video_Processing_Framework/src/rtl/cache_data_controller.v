`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/08/2022 02:56:14 PM
// Design Name: 
// Module Name: cache_data_controller
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
//video_in = vi
//video_out = vo

module cache_data_controller#(
    parameter  integer  ADDR_OFFSET = 0,
    parameter  integer  BUF_SIZE = 3,
    parameter  integer  H_CNT = 1280, 
    parameter  integer  V_CNT = 720	
)(
    ui_clk, //100Mhz
    ui_rst_n,
    //
    p_clk, //pclk 96Mhz/192Mhz
    p_fs,
    p_wr_en,
    p_data,
    //
    vga_clk,//74.25Mhz
    vga_fs,
    vga_rd_en,
    vga_data,
    //
    pkg_rd_addr,
    pkg_rd_areq,
    pkg_rd_data,
    pkg_rd_en,
    pkg_rd_last,
    pkg_rd_size,
    //
    pkg_wr_addr,
    pkg_wr_areq,
    pkg_wr_data,
    pkg_wr_en,
    pkg_wr_last,
    pkg_wr_size

    );
    input           ui_clk;
    input           ui_rst_n;
    //
    input           p_clk;
    input           p_fs;
    input           p_wr_en;
    input [23:0]    p_data;
    //
    input           vga_clk;
    input           vga_fs;
    input           vga_rd_en;
    output [23:0]   vga_data;
    
    
    output  reg     pkg_rd_areq;
    input           pkg_rd_en;
    input           pkg_rd_last;
    input   [127:0] pkg_rd_data;
    output  [31:0]  pkg_rd_size;
    output  [31:0]  pkg_rd_addr;
    
    
    output  reg     pkg_wr_areq;
    input           pkg_wr_en;
    input           pkg_wr_last;
    output  [127:0] pkg_wr_data;
    output  [31:0]  pkg_wr_size;
    output  [31:0]  pkg_wr_addr;
    
    reg rdy_wr_s, rdy_rd_s;
    wire p_fs_f, vga_fs_f;
    wire [9:0] rd_data_count;
    wire [9:0] wr_data_count;
    

    
    reg FDMA_WR_REQ;
    reg FDMA_RD_REQ;
    
    parameter FBUF_SIZE = BUF_SIZE - 1'b1;
    parameter BURST_SIZE = 1024*4; //4KB
    parameter BURST_TIMES = (H_CNT * V_CNT)/1024;
    parameter PKG_SIZE = 256;
    
    reg [6:0] WR_Fbuf;
    reg [22:0]WR_addr;
    reg [6:0] RD_Fbuf;
    reg [22:0]RD_addr;
    
    
    reg [1:0] W_STATE;
    localparam  W_IDLE = 2'd0,
                W_FRST = 2'd1,
                W_S0   = 2'd2,
                W_S1   = 2'd3;
     reg WR_rdy_s;
     reg [9:0]  WR_burst_cnt; 
     reg [4:0] vi_fifo_reset_cnt;
     reg vi_fifo_reset;  
     
     reg [1:0] R_STATE;
     localparam  R_IDLE = 3'd0,
                 R_FRST = 3'd1,
                 R_S0   = 3'd2,
                 R_S1   = 3'd3;
      reg RD_rdy_s;
      reg [9:0]  RD_burst_cnt; 
      reg [4:0]  vo_fifo_reset_cnt;
      reg vo_fifo_reset; 
    
    
    always@(posedge ui_clk)begin
        FDMA_WR_REQ <= (rd_data_count >= PKG_SIZE);
        FDMA_RD_REQ <= (wr_data_count <= PKG_SIZE);
    end
    


   assign pkg_wr_addr = {WR_Fbuf,WR_addr}+ ADDR_OFFSET;
   assign pkg_rd_addr = {RD_Fbuf,RD_addr}+ ADDR_OFFSET;
   assign pkg_wr_size = PKG_SIZE;
   assign pkg_rd_size = PKG_SIZE;
   
   
   ila_0 inst_ila_0(
   .clk(ui_clk),
   .probe0({vga_fs_f,vga_fs,vo_fifo_reset,pkg_rd_en,vga_rd_en,RD_Fbuf[1:0],pkg_rd_last}),
   .probe1({vga_data[7:0]}),
   .probe2({pkg_rd_data[7:0]})
   );
   
//      ila_0 inst_ila_0(
//   .clk(ui_clk),
//   .probe0({p_fs_f,p_fs,pkg_wr_areq,pkg_wr_en,p_wr_en,vi_fifo_reset,WR_rdy_s,pkg_wr_last}),
//   .probe1({p_data[7:0]}),
//   .probe2({pkg_wr_data[7:0]})
//   );
    
    
    //write FDMA FSM ----------------------------------------------------------
     
    always @(posedge ui_clk) begin
      if(!ui_rst_n) begin
        WR_burst_cnt      <= 10'd0;
        vi_fifo_reset_cnt <= 5'd0;
        vi_fifo_reset     <= 1'b1;
        WR_addr           <= 23'd0;
        WR_rdy_s          <= 1'b1;
        WR_Fbuf           <= 7'd0;
        pkg_wr_areq       <= 1'b0;
        W_STATE           <= W_IDLE;
      end
      else
        case(W_STATE)
            W_IDLE    :   begin
                            if(p_fs_f == 1'b1) W_STATE <= W_FRST;
                            else begin
                                WR_burst_cnt <= 0;
                                vi_fifo_reset_cnt <= 0;
                                WR_addr <= 0;
                                WR_rdy_s <= 1'b1;
                                W_STATE = W_IDLE;
                            end
                        end
                        
             W_FRST   :   begin
                            vi_fifo_reset_cnt <= vi_fifo_reset_cnt +1'b1;
                            if(vi_fifo_reset_cnt > 5'd30) W_STATE <= W_S0;
                            else begin
                                WR_rdy_s <= 1'b0;
                                vi_fifo_reset <= (vi_fifo_reset_cnt < 5'd10);
                                W_STATE = W_FRST;
                            end
                        end
                        
             W_S0     :   begin
                             vi_fifo_reset_cnt <= 0;
                            if(WR_burst_cnt == BURST_TIMES)begin //一帧数据传输完成后，切换帧缓存位置
                                if(WR_Fbuf == FBUF_SIZE) WR_Fbuf = 7'd0;
                                else WR_Fbuf <= WR_Fbuf +1'd1;
                                W_STATE <= W_IDLE;
                            end
                            else if(FDMA_WR_REQ == 0)begin
                                W_STATE <= W_S0; //等在FIFO中写够一次传输的数据
                            end
                            else if(FDMA_WR_REQ == 1)begin
                                W_STATE <= W_S1;
                                pkg_wr_areq <= 1'b1; //启动一次突发FDMA传输
                            end
                        end
                        
             W_S1    :    begin
                             pkg_wr_areq <= 0;
                            if(pkg_wr_last == 0)begin 
                                W_STATE <= W_S1;     //等待一次突发传输完成
                            end
                            else if(pkg_wr_last == 1) begin //接收到FDMA以一个包的最后一个数据数据
                                W_STATE <= W_S0;                    //到W_S0 启动下一个包数据传输
                                WR_burst_cnt <= WR_burst_cnt + 1; //突传输计数器加一
                                WR_addr <= WR_addr + BURST_SIZE;   //地址对应增加
                            end
                        end
                        
            default  :  W_STATE <= W_IDLE;         
        endcase
    end
    
    
    
   //read FDMA FSM ----------------------------------------------------------
 
     
     always@(posedge ui_clk) begin
       if(!ui_rst_n) begin
         RD_burst_cnt       <= 10'd0;
         vo_fifo_reset_cnt  <= 5'd0;
         vo_fifo_reset      <= 1'b1;
         RD_addr            <= 23'd0;
         RD_rdy_s           <= 1'b1;
         RD_Fbuf            <= 7'd0;
         pkg_rd_areq        <= 1'b0;
         R_STATE            <= R_IDLE;
       end
     else
       case(R_STATE)
           R_IDLE     :   begin
                            if(vga_fs_f == 1) R_STATE <= R_FRST;
                            else begin
                                RD_burst_cnt <= 0;
                                vo_fifo_reset_cnt <= 0;
                                RD_addr <= 0;
                                RD_rdy_s <= 1'b1;
                                R_STATE <= R_IDLE;
                            end
                          end
                          
           R_FRST     :    begin
                             vo_fifo_reset_cnt <= vo_fifo_reset_cnt + 1'd1;
                             if(vo_fifo_reset_cnt > 5'd30) R_STATE <= R_S0;
                             else begin
                                RD_rdy_s <= 1'b0;
                                vo_fifo_reset <= (vo_fifo_reset_cnt < 5'd10);
                                R_STATE <= R_FRST;
                             end
                           end
                           
            R_S0        :   begin
                                vo_fifo_reset_cnt <= 1'b0;
                                if(RD_burst_cnt==BURST_TIMES) begin
                                    if(WR_Fbuf == 7'd0 )  RD_Fbuf <= FBUF_SIZE;
                                    else RD_Fbuf <= WR_Fbuf - 1'd1;
                                    R_STATE <= R_IDLE;
                                end
                                else if(FDMA_RD_REQ == 1'b0) //等待VO_FIFO中的数据大于一个包的数据
                                    R_STATE <= R_S0;
                                else if(FDMA_RD_REQ == 1'b1)begin
                                    pkg_rd_areq <= 1'b1;    //VO_FIFO中的数据小于一个包的数据，启动一次FDMA突发读，并写入VO_FIFO
                                    R_STATE <= R_S1;
                                end 
                            end
                            
            R_S1       :    begin
                              pkg_rd_areq <= 1'b0;
                              if(pkg_rd_last == 1'b0)
                                R_STATE <= R_S1;             //等待一次突发读FDMA完成
                              if(pkg_rd_last == 1'b1) begin //一次突发读DMA完成
                                 R_STATE <=R_S0;            // //到R_S0 启动下一个包数据传输
                                 RD_burst_cnt <= RD_burst_cnt + 1'b1; //读突发计数器加一
                                 RD_addr <= RD_addr + BURST_SIZE;   //FDMAd地址对应增加
                              end
                            end
                            
            default  :  R_STATE = R_IDLE;
       endcase
     end               
                
                
    fs_cap inst_p_fs_cap(
         .clk_i(ui_clk),
         .rst_n_i(ui_rst_n),
         .fs_i(p_fs),
         .rdy_s_i(WR_rdy_s),
         .fs_o(p_fs_f)
     );
     
     fs_cap inst_vga_fs_cap(
         .clk_i(ui_clk),
         .rst_n_i(ui_rst_n),
         .fs_i(vga_fs),
         .rdy_s_i(RD_rdy_s),
         .fs_o(vga_fs_f)
     );
    
    vi_fifo inst_vi_fifo (
      .rst(vi_fifo_reset),                   // input wire rst
      
      .wr_clk(p_clk),                  // input wire wr_clk
      .din({8'd0,p_data}),             // input wire [31 : 1'b0] din
      .wr_en(p_wr_en),                 // input wire wr_en
      
      .rd_clk(ui_clk),                  // input wire rd_clk 
      .rd_en(pkg_wr_en),              // input wire rd_en
      .dout(pkg_wr_data),               // output wire [127 : 1'b0] dout
      .rd_data_count(rd_data_count)                  // output wire [11 : 1'b0] rd_data_count
    );
    
    vo_fifo inst_vo_fifo (
      .rst(vo_fifo_reset),               // input wire rst
      
      .wr_clk(ui_clk),              // input wire wr_clk
      .din(pkg_rd_data),            // input wire [127 : 1'b0] din
      .wr_en(pkg_rd_en),            // input wire wr_en
      
      .rd_clk(vga_clk),              // input wire rd_clk 
      .rd_en(vga_rd_en),              // input wire rd_en
      .dout(vga_data),               // output wire [31 : 1'b0] dout
      .wr_data_count(wr_data_count)              // output wire [12 : 1'b0] wr_data_count
    );
    
  
    
    
endmodule
