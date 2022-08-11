`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/11/2022 08:25:22 AM
// Design Name: 
// Module Name: s2p
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


module s2p(
input clk,
input rst_n,
input si,
input dat_en,
output reg [8 - 1 : 0] po
    );
 parameter PORT_WIDTH    =    8;
 reg [9:0] cnt; //最大位宽支持512
 reg [PORT_WIDTH - 1 : 0] po_r;
 always@(posedge clk or negedge rst_n) begin
   if(!rst_n)begin
     cnt <= 'd0;
     po <= 'd0;
     po_r <= 'd0;
   end
   else
     if(dat_en) begin
       if(cnt == PORT_WIDTH) begin
         po <= po_r;
         cnt <= 0;
       end
       else begin
         cnt <= cnt + 1'b1;
         po_r[cnt] <= si;
         po <= 'd0;
       end
     end
     else begin
       cnt <= 'd0;
       po <= 'd0;
       po_r <= 'd0;
     end
 end   
    
endmodule
