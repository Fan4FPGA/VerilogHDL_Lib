`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/19/2022 02:21:16 PM
// Design Name: 
// Module Name: rgb2yuv_tb
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


module rgb2yuv_tb;

reg clk_i;
reg rst_n_i;

wire vs_i,de_i;
wire [23:0] rgb_i;

wire vs_o;
wire de_o;
wire [7:0] y_ch_o;
wire [7:0] u_ch_o;
wire [7:0] v_ch_o;
integer mem_read_addr = 0;

reg vs_r;
always @(posedge clk_i) begin
    vs_r <= vs_o;
end
initial begin
    clk_i = 0;
    rst_n_i = 0;
    #200
    rst_n_i = 1;
    #20000;

end

always #10 clk_i = !clk_i;


vga_timing_gen TIMIN_GEN(
.clk_i(clk_i),        //720p 时钟为输入时钟为74.25MHz
.rst_n_i(rst_n_i),

.VGA_VS(vs_i),
.VGA_HS(),
.VGA_DE(de_i)
//output reg [23:0] VGA_RGB
);

rgb2yuv inst_rgb2yuv(
 .clk_i(clk_i),
 .rst_n_i(rst_n_i),
 .vs_i(vs_i),
 .de_i(de_i),
 .rgb_i(rgb_i),
 
 .vs_o(vs_o),
 .de_o(de_o),
 .y_ch_o(y_ch_o),
 .u_ch_o(u_ch_o),
 .v_ch_o(v_ch_o)
 );
 
 

 mem MEM(
     .clk(clk_i), 
     .rst_n(rst_n_i), 
 
     .mem_write(de_o), 
     .y_data(y_ch_o), 
     .u_data(u_ch_o), 
     .v_data(v_ch_o), 
     
     .mem_q(rgb_i), 
     .mem_addr(mem_read_addr),
     .mem_read(de_i)
    );
    

always @(posedge clk_i) begin
    if(de_i)begin
            if(mem_read_addr%1280 == 0 && mem_read_addr != 0) mem_read_addr <= mem_read_addr + 2560+ 1; 
            else  mem_read_addr <= mem_read_addr + 1;   
         end
end


endmodule
