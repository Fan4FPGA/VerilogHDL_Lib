`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/08/2022 06:52:57 PM
// Design Name: 
// Module Name: vga_timing_gen
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


module vga_timing_gen(
input       clk_i,        //720p 时钟为输入时钟为74.25MHz
input       rst_n_i,

output reg VGA_VS,
output reg VGA_HS,
output reg VGA_DE
//output reg [23:0] VGA_RGB
);

//-------------------------------//
// 垂直扫描参数的设定1280*720	60HZ  	 输入时钟为74.25MHz
//-------------------------------//
`define P720P
//`define BEHAVIORAL_SIM


`ifdef P720P
parameter HOR_TOTAL		=	1650; //2200
parameter HOR_SYNC		    =	40; //44
parameter HOR_BACK		    =	220;//148
parameter HOR_ACTIVE	    =	1280;   //1920
parameter HOR_FRONT		=	110; //88

parameter VER_TOTAL		=	750;  //1125
parameter VER_SYNC		    =	5;   //5
parameter VER_BACK		    =	20; //37
parameter VER_ACTIVE	    =	720;  //1080
parameter VER_FRONT		=	5; //3

//TEST
parameter LINE0		=	320;
parameter LINE1		=	640;
parameter LINE2		=	960;
parameter LINE3		=	1280;

`elsif BEHAVIORAL_SIM
parameter HOR_TOTAL		=	165; //2200
parameter HOR_SYNC		    =	4;   //44
parameter HOR_BACK		    =	22;  //22
parameter HOR_ACTIVE	    =	128;   //128
parameter HOR_FRONT		=	11;   //88

parameter VER_TOTAL		=	102;  //102
parameter VER_SYNC		    =	5;    //5
parameter VER_BACK		    =	20;   //20
parameter VER_ACTIVE	    =	72;   //72
parameter VER_FRONT		=	5;    //5

//TEST
parameter LINE0		=	32;
parameter LINE1		=	64;
parameter LINE2		=	96;
parameter LINE3		=	128;
`endif


parameter H_BORDER    = 0;
parameter V_BORDER    = 0;

reg [23:0] VGA_RGB_r;
reg [10:0] hor_cnt;
reg [9:0]	ver_cnt;
reg hor_cnt_flag;
wire hor_data_valid;
wire ver_data_valid;
wire video_data_valid;

always@(posedge clk_i) begin
    if(!rst_n_i) begin
        hor_cnt <= 11'd0;
        hor_cnt_flag <= 1'b0;
    end
    else begin
        if(hor_cnt < HOR_TOTAL - 1) begin
            hor_cnt <= hor_cnt + 1'b1;
            hor_cnt_flag <= 1'b0;
        end
        else begin
            hor_cnt <= 11'd0;
            hor_cnt_flag <= 1'b1;
        end
    end
end
	
always@(posedge clk_i)begin
if(!rst_n_i) ver_cnt <= 10'd0;
else 
    if(hor_cnt_flag) begin
        if(ver_cnt < VER_TOTAL - 1)
            ver_cnt <= ver_cnt + 1'b1;
        else
            ver_cnt <= 10'd0;
    end
    else ver_cnt <= ver_cnt;			
end
	
	assign vga_hs = (hor_cnt < HOR_SYNC);
	assign vga_vs = (ver_cnt < VER_SYNC);
	
	assign hor_data_valid = ( (hor_cnt < HOR_SYNC+HOR_BACK+HOR_ACTIVE) && (hor_cnt >= HOR_SYNC+HOR_BACK ) );
	assign ver_data_valid = ( (ver_cnt < VER_SYNC+VER_BACK+VER_ACTIVE) && (ver_cnt >= VER_SYNC+VER_BACK ) );
	assign vga_blank = hor_data_valid && ver_data_valid;
	
//	assign video_data_valid = ( (hor_cnt < HOR_SYNC+HOR_BACK+HOR_ACTIVE-H_BORDER) && (hor_cnt >= HOR_SYNC+HOR_BACK+H_BORDER ) ) & 
//	                          ( (ver_cnt < VER_SYNC+VER_BACK+VER_ACTIVE-V_BORDER) && (ver_cnt >= VER_SYNC+VER_BACK+V_BORDER ) );

//色条测试程序，随意写的	                          
//    always@(posedge clk_i)begin
//        if(video_data_valid) begin
//            if(hor_cnt ==(HOR_SYNC + HOR_BACK + 0) )
//               VGA_RGB_r <= {8'h22,8'h33,8'h55};
//            else if(hor_cnt == (HOR_SYNC + HOR_BACK + LINE0) )
//               VGA_RGB_r <= {8'h00,8'h00,8'h00};
//            else if(hor_cnt == (HOR_SYNC + HOR_BACK + LINE1) )
//               VGA_RGB_r <= {8'h33,8'h55,8'h22};
//            else if(hor_cnt == (HOR_SYNC + HOR_BACK + LINE2) )
//               VGA_RGB_r <= {8'h00,8'h00,8'h00};
//            else if(hor_cnt == (HOR_SYNC + HOR_BACK + LINE3) )
//               VGA_RGB_r <= {8'h00,8'h00,8'h00};
//           // else  VGA_RGB_r <= {8'h00,8'h00,8'h00};
//        end
//        else VGA_RGB_r <= {8'h00,8'h00,8'h00};
//    end
//--------------------------------------------------------------------------------------	
	
	always @(posedge clk_i ) begin
        VGA_VS <=  vga_vs;    
        VGA_HS <=  vga_hs;
        VGA_DE <=  vga_blank;  
        //VGA_RGB <= VGA_RGB_r;
	end                    

endmodule
