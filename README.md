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
## 三、并串转换
**RTL code： SerializerN_1.v**
**Teshbench: SerializerN_1_tb.v**
**brief info: 使用OSERDESE2 和 obufds**
