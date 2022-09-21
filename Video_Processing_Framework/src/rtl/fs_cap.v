`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/08/2022 04:00:18 PM
// Design Name: 
// Module Name: fs_cap
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


module fs_cap(
    input       clk_i,
    input       rst_n_i,
    input       fs_i,
    input       rdy_s_i,
    output reg fs_o
);

    reg [3:0] fs_temp;
    reg [4:0] fs_p_cnt,fs_n_cnt;
    reg fs,fs_r;

    
    always @(posedge clk_i) begin
        if(!rst_n_i)fs_temp <= 4'b1111;
        else begin 
           // fs_temp <= {fs_temp[3:0],fs_i};
            fs_temp[0] <= fs_i;
            fs_temp[1] <= fs_temp[0];
            fs_temp[2] <= fs_temp[1];
            fs_temp[3] <= fs_temp[2];
        end
    end
    
    always@(posedge clk_i) begin
        if(!rst_n_i)begin
            fs_n_cnt = 5'd0;
            fs_p_cnt = 5'd0;
        end
        else if(fs_temp[3]) begin
            fs_p_cnt <= (fs_p_cnt<5'd30) ? fs_p_cnt + 1'b1 : 5'd30;
            fs_n_cnt <= 5'd0;
        end
        else if(!fs_temp[3]) begin
            fs_n_cnt = (fs_n_cnt<5'd30) ? fs_n_cnt + 1'b1 : 5'd30;
            fs_p_cnt = 5'd0;
        end
    end
    
    always @(posedge clk_i) begin
       if(!rst_n_i) fs <= 1'b1;
       else if(fs_p_cnt > 5'd20) fs <= 1'b1;
       else if(fs_n_cnt > 5'd20) fs <= 1'b0;
       else fs <= fs;
    end
    
    always@(posedge clk_i) begin
        if(!rst_n_i) fs_r <= 1'b1;
        else fs_r <= fs;
    end
    
    always @(posedge clk_i) begin
        if(!rst_n_i) fs_o <= 1'b0;
        else if(rdy_s_i==1'b1 && {fs_r,fs}==2'b01 && fs_o == 1'b0)
            fs_o <= 1'b1;
        else fs_o <= 1'b0;
    end
    
   
endmodule
