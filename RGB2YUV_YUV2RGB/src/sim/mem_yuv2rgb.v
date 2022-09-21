`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/20/2022 04:55:38 PM
// Design Name: 
// Module Name: mem_yuv2rgb
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



module mem_yuv2rgb(
    clk, 
    rst_n,
    mem_addr, 
    y_data,
    u_data,
    v_data, 
    rgb, 
    mem_write, 
    mem_read
);
    
    input clk,rst_n;
    input [31:0] mem_addr;
    output reg [7:0] y_data;
    output reg [7:0] u_data;
    output reg [7:0] v_data;
    input [23:0] rgb;
    input mem_write, mem_read;
    integer wr_cnt = 1;
    reg [7:0] memory_y [22'h3F_FFFF:0];
    reg [7:0] memory_u [22'h3F_FFFF:0]; 
    reg [7:0] memory_v [22'h3F_FFFF:0];
     
    integer DATAFILE_R,DATAFILE_G,DATAFILE_B;
    initial  DATAFILE_R = $fopen("post_process_dat_r.txt");
    initial  DATAFILE_G = $fopen("post_process_dat_g.txt");
    initial  DATAFILE_B = $fopen("post_process_dat_b.txt");
   
    initial $readmemh("post_process_dat_y.txt",memory_y);
    initial $readmemh("post_process_dat_u.txt",memory_u);
    initial $readmemh("post_process_dat_v.txt",memory_v);
    
    always @(*) 
    begin
        if(mem_read)
            y_data <= {memory_y[mem_addr]};
            u_data <= {memory_u[mem_addr]}; 
            v_data <= {memory_v[mem_addr]};      
    end
    
    always @(posedge clk) begin
        if(mem_write) begin
            $fdisplay(DATAFILE_R,"%0h",rgb[23:16]);
            $fdisplay(DATAFILE_G,"%0h",rgb[15:8]);
            $fdisplay(DATAFILE_B,"%0h",rgb[7:0]);
            wr_cnt = wr_cnt+1;
        end
    
    end
     
endmodule
