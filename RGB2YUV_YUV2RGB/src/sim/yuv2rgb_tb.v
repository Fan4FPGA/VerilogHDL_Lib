`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/20/2022 04:55:03 PM
// Design Name: 
// Module Name: yuv2rgb_tb
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


module yuv2rgb_tb;

reg clk_i;
reg rst_n_i;

wire       vs_i;
wire       de_i;
wire [7:0] y_ch_i;
wire [7:0] u_ch_i;
wire [7:0] v_ch_i;

wire      vs_o;
wire      de_o;
wire [23:0] rgb;


initial begin
    clk_i = 0;
    rst_n_i = 0;
    #200
    rst_n_i = 1;

end

always #10 clk_i <= !clk_i;
integer mem_read_addr = 0;

always @(posedge clk_i) begin
    if(de_i)begin
         mem_read_addr <= mem_read_addr + 1;   
    end
end



vga_timing_gen TIMIN_GEN(
.clk_i(clk_i),        //720p 时钟为输入时钟为74.25MHz
.rst_n_i(rst_n_i),

.VGA_VS(vs_i),
.VGA_HS(),
.VGA_DE(de_i)
//output reg [23:0] VGA_RGB
);

yuv2rgb inst_yuv2rgb(
    .clk_i(clk_i),
    .rst_n_i(rst_n_i),
    .vs_i(vs_i),
    .de_i(de_i),
    .y_ch_i(y_ch_i),
    .u_ch_i(u_ch_i),
    .v_ch_i(v_ch_i),
    
    .vs_o(vs_o),
    .de_o(de_o),
    .rgb(rgb)
);


mem_yuv2rgb MEM_YUV2RGB(
    .clk(clk_i), 
    .rst_n(rst_n_i),
    
    .mem_addr(mem_read_addr), 
    .mem_read(de_i),
    .y_data(y_ch_i),
    .u_data(u_ch_i),
    .v_data(v_ch_i), 
    
    .rgb(rgb), 
    .mem_write(de_o)
);






endmodule
