`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/11/2022 08:45:59 AM
// Design Name: 
// Module Name: s2p_tb
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


module s2p_tb;

reg clk;
reg rst_n;
reg si;
reg dat_en;
wire [4 - 1 : 0] po;
wire dat_valid;

s2p #(4)inst (
.clk(clk),
.rst_n(rst_n),
.si(si),
.dat_en(dat_en),
.dat_valid(dat_valid),
.po(po)
);

initial begin
    clk = 1;
    rst_n = 0;
    dat_en  = 0;
    si = 0;
    #200.1
    rst_n = 1;
    #20
    
    si = 1;
    dat_en = 1;
    #20
    si = 0;
    #20
    si = 1;
    #20
    si = 0;
    #20
    
    
    si = 0;
    #20
    si = 1;
    #20
    si = 0;
    #20
    si = 1;
    #20
    
    
    si = 0;
    #20
    si = 0;
    #20
    si = 1;
    #20
    si = 1;
    #20
    
    si = 1;
    #20
    si = 1;
    #20
    si = 0;
    #20
    si = 0;
    #20
    
    si = 1;
    dat_en = 0;
    #20
    si = 1;
    #20
    si = 1;
    #20
    si = 0;
    #20
    si = 0;
    #20
    si = 1;
    #20
    si = 0;
    #20
    si = 0;
    #20
    si = 1;
    #20
    si = 0;
    #20
    si = 0;
    #20
    si = 1;

    #200
    $stop;

end

always #10 clk = ~clk; //50MHz






endmodule
