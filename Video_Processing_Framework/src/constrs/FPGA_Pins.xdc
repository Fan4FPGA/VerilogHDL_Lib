set_property IOSTANDARD LVDS [get_ports HDMI_CLK_P]
set_property PACKAGE_PIN J14 [get_ports HDMI_CLK_P]
set_property IOSTANDARD LVDS [get_ports HDMI_D0_P]
set_property PACKAGE_PIN K13 [get_ports HDMI_D0_P]
set_property IOSTANDARD LVDS [get_ports HDMI_D1_P]
set_property PACKAGE_PIN G14 [get_ports HDMI_D1_P]
set_property IOSTANDARD LVDS [get_ports HDMI_D2_P]
set_property PACKAGE_PIN K15 [get_ports HDMI_D2_P]

#set_property PACKAGE_PIN AB17 [get_ports IIC_sda_io]
#set_property PACKAGE_PIN W16  [get_ports IIC_scl_io]
#set_property IOSTANDARD LVCMOS33 [get_ports IIC_sda_io]
#set_property IOSTANDARD LVCMOS33 [get_ports IIC_scl_io]
#set_property PULLUP true [get_ports IIC_sda_io]

#---------------------------------------------------------------------------------------
#                       CMOS1 PINS
#---------------------------------------------------------------------------------------
set_property PACKAGE_PIN W16  [get_ports {IIC_scl_io}]
set_property IOSTANDARD LVCMOS33 [get_ports {IIC_scl_io}]
set_property PACKAGE_PIN AB17 [get_ports {IIC_sda_io}]
set_property IOSTANDARD LVCMOS33 [get_ports {IIC_sda_io}]
set_property PULLUP true [get_ports {IIC_sda_io}]
set_property PULLUP true [get_ports {IIC_scl_io}]
#---------------------------------------------------------
set_property -dict {PACKAGE_PIN AC17 IOSTANDARD LVCMOS33} [get_ports cmos_xclk_o]
set_property -dict {PACKAGE_PIN Y17  IOSTANDARD LVCMOS33} [get_ports cmos_pclk_i]
#------------------------------------------------------------------------------------------------
set_property -dict {PACKAGE_PIN W15  IOSTANDARD LVCMOS33} [get_ports cmos_vsync_i]
set_property -dict {PACKAGE_PIN AB16 IOSTANDARD LVCMOS33} [get_ports cmos_href_i]
#------------------------------------------------------------------------------------------------
set_property -dict {PACKAGE_PIN AB12  IOSTANDARD LVCMOS33} [get_ports {cmos_data_i[0]}]
set_property -dict {PACKAGE_PIN AA15  IOSTANDARD LVCMOS33} [get_ports {cmos_data_i[1]}]
set_property -dict {PACKAGE_PIN AD15  IOSTANDARD LVCMOS33} [get_ports {cmos_data_i[2]}]
set_property -dict {PACKAGE_PIN Y15   IOSTANDARD LVCMOS33} [get_ports {cmos_data_i[3]}]
set_property -dict {PACKAGE_PIN AD16  IOSTANDARD LVCMOS33} [get_ports {cmos_data_i[4]}]
set_property -dict {PACKAGE_PIN Y16   IOSTANDARD LVCMOS33} [get_ports {cmos_data_i[5]}]
set_property -dict {PACKAGE_PIN AC16  IOSTANDARD LVCMOS33} [get_ports {cmos_data_i[6]}]
set_property -dict {PACKAGE_PIN AA17  IOSTANDARD LVCMOS33} [get_ports {cmos_data_i[7]}]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets cmos_pclk_i_IBUF]
