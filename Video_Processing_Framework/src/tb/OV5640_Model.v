`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/09/15 21:44:06
// Design Name: 
// Module Name: OV5640_Model
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


module OV5640_Model(
input cmos_xclk_i,
output  cmos_pclk_o,
output reg cmos_vsync_o,
output reg cmos_href_o,
output reg [7:0] cmos_data_o
);
//	-- Set the video mode to 1280x720x60Hz (75MHz pixel clock needed)
parameter hVisible   = 1280*2;
parameter hStartSync = (1280+72)*2;
parameter hEndSync   = (1280+72+80)*2;
parameter hMax       = (1280+72+80+216)*2; //1648*2 =3296

parameter vVisible    = 720;
parameter vStartSync  = 720+3;
parameter vEndSync    = 720+3+5;
parameter vMax        = 720+3+5+22; //750
integer hcnt = 0,
         vcnt = 0;
initial begin
    cmos_data_o = 8'h55;
end
assign cmos_pclk_o = cmos_xclk_i;

always @(posedge cmos_pclk_o)begin
    if(hcnt == hMax-1) begin
        hcnt =0;
        if(vcnt == (vMax -1)) begin
            vcnt = 0;
        end
        else vcnt=vcnt+1;
    end
    else hcnt = hcnt + 1;
end

always @(posedge cmos_pclk_o)begin
    if(vcnt <= 3) cmos_vsync_o = 1;
    else cmos_vsync_o = 0;
end

always @(posedge cmos_pclk_o) begin
   if(vcnt >8 && vcnt <=728)begin
        if(hcnt <=(hVisible-1)) cmos_href_o = 1;
        else cmos_href_o = 0;
   end
   else cmos_href_o = 0;
end

always @(posedge cmos_pclk_o) begin
    if(cmos_href_o)
        cmos_data_o = ~cmos_data_o;
end

endmodule
