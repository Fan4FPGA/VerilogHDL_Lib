`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/10/2022 11:38:48 AM
// Design Name: 
// Module Name: sensor_data_sim_gen
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

module  sensor_data_sim_gen (
    input  clk,
    input  rst_n_i,
    output [23:0]rgb,
    output de,
    output vsync,
    output hsync,
//    output reg [23:0]rgb,
//    output reg de,
//    output reg vsync,
//    output reg hsync,
    output pclk
    );

/*
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

assign pclk = clk;

always@(posedge clk) begin
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
	
always@(posedge clk)begin
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
	
	assign video_data_valid = ( (hor_cnt < HOR_SYNC+HOR_BACK+HOR_ACTIVE-H_BORDER) && (hor_cnt >= HOR_SYNC+HOR_BACK+H_BORDER ) ) & 
	                          ( (ver_cnt < VER_SYNC+VER_BACK+VER_ACTIVE-V_BORDER) && (ver_cnt >= VER_SYNC+VER_BACK+V_BORDER ) );

//色条测试程序，随意写的	                          
    always@(posedge clk)begin
        if(video_data_valid) begin
            if(hor_cnt ==(HOR_SYNC + HOR_BACK + 0) )
               VGA_RGB_r <= {8'hff,8'h02,8'h01};
            else if(hor_cnt == (HOR_SYNC + HOR_BACK + LINE0) )
               VGA_RGB_r <= {8'h06,8'hff,8'h04};
            else if(hor_cnt == (HOR_SYNC + HOR_BACK + LINE1) )
               VGA_RGB_r <= {8'hff,8'hff,8'h07};
            else if(hor_cnt == (HOR_SYNC + HOR_BACK + LINE2) )
               VGA_RGB_r <= {8'h0c,8'hff,8'h0a};
            else if(hor_cnt == (HOR_SYNC + HOR_BACK + LINE3) )
               VGA_RGB_r <= {8'hff,8'hff,8'hff};
           // else  VGA_RGB_r <= {8'h00,8'h00,8'h00};
        end
        else VGA_RGB_r <= {8'h00,8'h00,8'h00};
    end
//--------------------------------------------------------------------------------------	
	
	always @(posedge clk ) begin
        vsync <=  vga_vs;    
        hsync <=  vga_hs;
        de <=  video_data_valid;  
        rgb <= VGA_RGB_r;
	end                    
*/

   reg  [23:0] colour=24'd0;
   reg  [11:0] hcounter=12'd0;
   reg  [11:0] vcounter=12'd0;
   
   assign pclk = clk;
    
// Colours converted using The RGB -> YCbCr converter app found on Google Gadgets 
                                //   Y    Cb   Cr
   `define C_BLACK 24'h000000;  //  16   128  128
   `define C_RED   24'hFF0000;  //  81   90   240
   `define C_GREEN 24'h00FF00;  //  172  42   27
   `define C_BLUE  24'h0000FF;  //  32   240  118
   `define C_WHITE 24'hFFFFFF;  //  234  128  128
	
	
//	-- Set the video mode to 1920x1080x60Hz (150MHz pixel clock needed)
   /*parameter hVisible  = 1920;
   parameter hStartSync = 1920+88;
   parameter hEndSync   = 1920+88+44;
   parameter hMax       = 1920+88+44+148; //2200
   
   parameter vVisible    = 1080;
   parameter vStartSync  = 1080+4;
   parameter vEndSync    = 1080+4+5;
   parameter vMax        = 1080+4+5+36; //1125
	 */
	
//	-- Set the video mode to 1440x900x60Hz (106.47MHz pixel clock needed)
/*   parameter hVisible   = 1440;
   parameter hStartSync = 1440+80;
   parameter hEndSync   = 1440+80+152;
   parameter hMax       = 1440+80+152+232; //1904
   
   parameter vVisible    = 900;
   parameter vStartSync  = 900+1;
   parameter vEndSync    = 900+1+3;
   parameter vMax        = 900+1+3+28; //932
   */

    
//	-- Set the video mode to 1280x720x60Hz (75MHz pixel clock needed)
   parameter hVisible   = 1280;
   parameter hStartSync = 1280+72;
   parameter hEndSync   = 1280+72+80;
   parameter hMax       = 1280+72+80+216; //1647
   
   parameter vVisible    = 720;
   parameter vStartSync  = 720+3;
   parameter vEndSync    = 720+3+5;
   parameter vMax        = 720+3+5+22; //749
	
//	-- Set the video mode to 800x600x60Hz (40MHz pixel clock needed)
/*   parameter hVisible   = 800;
   parameter hStartSync = 840; //800+40
   parameter hEndSync   = 968; //800+40+128
   parameter hMax       = 1056; //800+40+128+88
   
   parameter vVisible    = 600;
   parameter vStartSync  = 601; //600+1
   parameter vEndSync    = 605; //600+1+4
   parameter vMax        = 628; //600+1+4+23      



//	-- Set the video mode to 640x480x60Hz (25MHz pixel clock needed)
 
   parameter hVisible   = 640;
   parameter hStartSync = 656; //640+16
   parameter hEndSync   = 752; //640+16+96
   parameter hMax       = 800; //640+16+96+48
   
   parameter vVisible    = 480;
   parameter vStartSync  = 490; //480+10
   parameter vEndSync    = 492; //480+10+2
   parameter vMax        = 525; //480+10+2+33
*/
//------------------------------------------
//v_sync counter & generator 
 
always@(posedge clk) begin
if(hcounter < hMax - 12'd1)        //line over
	hcounter <= hcounter + 12'd1;
else
	hcounter <= 12'd0; 
end
 
always@(posedge clk) begin
if(hcounter == hMax - 12'd1) begin
	if(vcounter < vMax - 12'd1)  //frame over
		vcounter <= vcounter + 12'd1;
	else
		vcounter <= 12'd0;
	end
end


        
 always@(posedge clk) begin
    if (hcounter <= hVisible/5) begin colour <= `C_RED; end
    else if(hcounter <= 2*hVisible/5) begin colour <= `C_GREEN; end
    else if(hcounter <= 3*hVisible/5) begin colour <= `C_BLUE; end
    else if(hcounter <= 4*hVisible/5) begin colour <= `C_WHITE; end
    else  begin colour <= `C_BLACK; end
 end
/*	 
  assign r = colour[23:16];
  assign g = colour[15:8];
  assign b = colour[7:0];
  */

reg [7:0]VGA_R_reg;
reg [7:0]VGA_G_reg;
reg [7:0]VGA_B_reg;
reg [10:0] dis_mode;
always @(posedge clk) begin
    if((vcounter == vMax - 12'd1)&&(hcounter == hMax - 12'd1))
        dis_mode <= dis_mode +1'b1;

end

reg[7:0]	grid_data_1;
reg[7:0]	grid_data_2;
always @(posedge clk)			//格子图像
begin
	if((hcounter[4]==1'b1)^(vcounter[4]==1'b1))
	grid_data_1	<=	8'h00;
	else
	grid_data_1	<=	8'hff;
	
	if((hcounter[6]==1'b1)^(vcounter[6]==1'b1))
	grid_data_2	<=	8'h00;
	else
	grid_data_2	<=	8'hff;
end

reg[23:0]	color_bar;
always @(posedge clk)
begin
	if(hcounter==260)
	color_bar	<=	24'hff0000;
	else if(hcounter==420)
	color_bar	<=	24'h00ff00;
	else if(hcounter==580)
	color_bar	<=	24'h0000ff;
	else if(hcounter==740)
	color_bar	<=	24'hff00ff;
	else if(hcounter==900)
	color_bar	<=	24'hffff00;
	else if(hcounter==1060)
	color_bar	<=	24'h00ffff;
	else if(hcounter==1220)
	color_bar	<=	24'hffffff;
	else if(hcounter==1380)
	color_bar	<=	24'h000000;
	else
	color_bar	<=	color_bar;
end

always @(posedge clk)
begin  
	if(1'b0) 
		begin 
	   VGA_R_reg<=0; 
	   VGA_G_reg<=0;
	   VGA_B_reg<=0;		 
		end
   else
     case(dis_mode[10:7])
         4'd0:begin
			     VGA_R_reg<=0;            //LCD显示彩色条
                 VGA_G_reg<=0;
                 VGA_B_reg<=0;
			end
			4'd1:begin
			     VGA_R_reg<=8'b11111111;                 //LCD显示全白
                 VGA_G_reg<=8'b11111111;
                 VGA_B_reg<=8'b11111111;
			end
			4'd2:begin
			     VGA_R_reg<=8'b11111111;                //LCD显示全红
                 VGA_G_reg<=0;
                 VGA_B_reg<=0;  
             end			  
	       4'd3:begin
			     VGA_R_reg<=0;                          //LCD显示全绿
                 VGA_G_reg<=8'b11111111;
                 VGA_B_reg<=0; 
            end					  
             4'd4:begin     
			     VGA_R_reg<=0;                         //LCD显示全蓝
                 VGA_G_reg<=0;
                 VGA_B_reg<=8'b11111111;
			end
             4'd5:begin     
			     VGA_R_reg<=grid_data_1;               // LCD显示方格1
                 VGA_G_reg<=grid_data_1;
                 VGA_B_reg<=grid_data_1;
            end					  
            4'd6:begin     
			     VGA_R_reg<=grid_data_2;               // LCD显示方格2
                 VGA_G_reg<=grid_data_2;
                 VGA_B_reg<=grid_data_2;
			end
		    4'd7:begin     
			     VGA_R_reg<=hcounter[7:0];                //LCD显示水平渐变色
                 VGA_G_reg<=hcounter[7:0];
                 VGA_B_reg<=hcounter[7:0];
			 end
		     4'd8:begin     
			     VGA_R_reg<=vcounter[8:1];                 //LCD显示垂直渐变色
                 VGA_G_reg<=hcounter[8:1];
                 VGA_B_reg<=hcounter[8:1];
			end
		     4'd9:begin     
			     VGA_R_reg<=hcounter[7:0];                 //LCD显示红水平渐变色
                 VGA_G_reg<=0;
                 VGA_B_reg<=0;
			end
		     4'd10:begin     
			     VGA_R_reg<=0;                          //LCD显示绿水平渐变色
                 VGA_G_reg<=hcounter[7:0];
                 VGA_B_reg<=0;
			end
		     4'd11:begin     
			     VGA_R_reg<=0;                          //LCD显示蓝水平渐变色
                 VGA_G_reg<=0;
                 VGA_B_reg<=hcounter[7:0];			
			end
		     4'd12:begin     
			     VGA_R_reg<=color_bar[23:16];            //LCD显示彩色条
                 VGA_G_reg<=color_bar[15:8];
                 VGA_B_reg<=color_bar[7:0];			
			end
		   default:begin
			     VGA_R_reg<=8'b11111111;                //LCD显示全白
                 VGA_G_reg<=8'b11111111;
                 VGA_B_reg<=8'b11111111;
			end					  
         endcase
end

assign hsync = ((hcounter >= (hStartSync - 2'd2))&&(hcounter < (hEndSync - 2'd2)))? 1'b0:1'b1;  //Generate the hSync Pulses
assign vsync = ((vcounter >= (vStartSync - 1'b1))&&(vcounter < (vEndSync - 1'b1)))? 1'b0:1'b1; //Generate the vSync Pulses
assign de =    (vcounter >= vVisible || hcounter >= hVisible) ? 1'b0 : 1'b1;
assign rgb = {VGA_R_reg,VGA_G_reg,VGA_B_reg};  
  
 endmodule
 
