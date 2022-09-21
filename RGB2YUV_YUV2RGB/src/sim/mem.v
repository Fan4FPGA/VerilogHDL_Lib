`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/10/2022 11:16:22 AM
// Design Name: 
// Module Name: mem
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


module mem(clk, rst_n, mem_addr, y_data,u_data,v_data, mem_q, mem_write, mem_read
    );
    
    input clk,rst_n;
    input [31:0] mem_addr;
    input [7:0] y_data;
    input [7:0] u_data;
    input [7:0] v_data;
    output reg [23:0] mem_q;
    input mem_write, mem_read;
    integer wr_cnt = 1;
    reg [7:0] memory [22'h3F_FFFF:0];
    integer DATAFILE_Y,DATAFILE_U,DATAFILE_V;
    initial DATAFILE_Y = $fopen("post_process_dat_y.txt");
    initial DATAFILE_U = $fopen("post_process_dat_u.txt");
    initial DATAFILE_V = $fopen("post_process_dat_v.txt");
    initial $readmemh("1.txt",memory);
    
    always @(*) 
    begin
        if(mem_read)
            mem_q <= {memory[mem_addr],memory[mem_addr+1280],memory[mem_addr+2560]};
    end
    
    always @(posedge clk) begin
        if(mem_write) begin
            $fdisplay(DATAFILE_Y,"%0h",y_data[7:0]);
            $fdisplay(DATAFILE_U,"%0h",u_data[7:0]);
            $fdisplay(DATAFILE_V,"%0h",v_data[7:0]);
            wr_cnt = wr_cnt+1;
        end
    
    end
     
endmodule
