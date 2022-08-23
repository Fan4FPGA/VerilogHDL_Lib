# 常用的一些电路Verilog代码或模板

## 一、异步复位同步释放（Synchronized Asynchronous Reset）

**RTL code：Async_reset_sync_assert.v**

**电路图：**

![p1](https://github.com/Fan4FPGA/VerilogHDL_Lib/blob/master/pic/Synchronized%20Asynchronous%20Reset.png)

## 二、串并转换

**RTL code：s2p.v**

**Testbench: s2p_tb.v**

**brief info: 串并转换**

![功能仿真图1：](https://github.com/Fan4FPGA/VerilogHDL_Lib/blob/master/pic/s2p_1_fsm.png)

![功能仿真图2：](https://github.com/Fan4FPGA/VerilogHDL_Lib/blob/master/pic/s2p_2_always.png)

## 三、HDMI发送及测试模块

文件夹：HDMI_Test_Demo.srcs

HDMI编码发送模块：HDMI_Test_Demo.srcs\sources_1\imports\src\rtl\hdmi_tx.v

​								     HDMI_Test_Demo.srcs\sources_1\imports\src\rtl\SerializerN_1.v

​								     HDMI_Test_Demo.srcs\sources_1\imports\src\rtl\TMDS_Encoder.v(TMDS编码算法从网下载的)

测试模块：				  HDMI_Test_Demo.srcs\sources_1\new\hdmi_display_demo.v

​					                 HDMI_Test_Demo.srcs\sources_1\new\vga_timing_gen.v

时钟IP：                      HDMI_Test_Demo.srcs\sources_1\ip\clk_wiz_0



模块Testbench：HDMI_Test_Demo.srcs\sim_1\new\hdmi_displau_demo_tb.v

​							  HDMI_Test_Demo.srcs\sim_1\new\vga_timing_gen_tb.v

​							  HDMI_Test_Demo.srcs\sources_1\imports\src\tb\SerializerN_1_tb.v

约束文件：HDMI_Test_Demo.srcs\constrs_1\new\fpga_pin.xdc

测试板卡：米联客 MZ7030FA ； 芯片：xc7z030ffg676-2 



测试架构图：

