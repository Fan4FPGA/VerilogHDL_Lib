//////////////////////////////////////////////////////////////////////////////////////
//Version:v1.0.0
//Date:2018-7-12 19:58:47
//Author:Forrest
//Email:lynnioi@163.com/lynnioi0405@gmail.com
//QQ:121392215
//Location:Beijing
//http://www.4fpga.cn  
//http://www.4forrest.com/

//Description: Async reset Sync assert
//1) _i PIN input  
//2) _o PIN output
//3) _n PIN active low
//4) _dg debug signal 
//5) _r  reg delay
//6) _s state machine
//////////////////////////////////////////////////////////////////////////////////////
wire rst_n;
wire sys_clk_100m;
wire locked;
wire sys_rst_n;
wire async_RESET_n;
reg sys_rst_n_r0,sys_rst_n_r;

assign 	   sys_rst_n = sys_rst_n_r		;
assign async_RESET_n = rst_n | locked	;

always @(posedge sys_clk_100m or negedge async_RESET_n)
begin
	if(!async_RESET_n)
		begin
			sys_rst_n_r0 <= 1'b0;
			sys_rst_n_r <= 1'b0;
		end
	else
		begin
			sys_rst_n_r0 <= 1'b1;
			sys_rst_n_r <= sys_rst_n_r0;
		end
end
