module SerializerN_1(
    input clk_i,
    //input clk_2x_i,
    input serial_clk_i, // CLKDIV_I x N / 2
    input a_rst_n_i,
    input [9:0] p_data_i,
    output s_data_p_o,
    output s_data_n_o
);
wire SHIFTIN1,SHIFTIN2;
wire s_data_w;


   // OBUFDS: Differential Output Buffer
   //         Artix-7
   // Xilinx HDL Language Template, version 2022.1

   OBUFDS #(
      .IOSTANDARD("DEFAULT"), // Specify the output I/O standard
      .SLEW("SLOW")           // Specify the output slew rate
   ) OBUFDS_inst (
      .O(s_data_p_o),     // Diff_p output (connect directly to top-level port)
      .OB(s_data_n_o),   // Diff_n output (connect directly to top-level port)
      .I(s_data_w)      // Buffer input
   );

   // End of OBUFDS_inst instantiation

 // OSERDESE2: Output SERial/DESerializer with bitslip
   //            Virtex-7
   // Xilinx HDL Language Template, version 2022.1

   OSERDESE2 #(
      .DATA_RATE_OQ("DDR"),   // DDR, SDR
      .DATA_RATE_TQ("SDR"),   // DDR, BUF, SDR
      .DATA_WIDTH(10),         // Parallel data width (2-8,10,14)
      .INIT_OQ(1'b0),         // Initial value of OQ output (1'b0,1'b1)
      .INIT_TQ(1'b0),         // Initial value of TQ output (1'b0,1'b1)
      .SERDES_MODE("MASTER"), // MASTER, SLAVE
      .SRVAL_OQ(1'b0),        // OQ output value when SR is used (1'b0,1'b1)
      .SRVAL_TQ(1'b0),        // TQ output value when SR is used (1'b0,1'b1)
      .TBYTE_CTL("FALSE"),    // Enable tristate byte operation (FALSE, TRUE)
      .TBYTE_SRC("FALSE"),    // Tristate byte source (FALSE, TRUE)
      .TRISTATE_WIDTH(1)      // 3-state converter width (1,4)
   )
   OSERDESE2_inst0 (
      .OFB(),             // 1-bit output: Feedback path for data
      .OQ(s_data_w),               // 1-bit output: Data path output
      // SHIFTOUT1 / SHIFTOUT2: 1-bit (each) output: Data output expansion (1-bit each)
      .SHIFTOUT1(),
      .SHIFTOUT2(),
      .TBYTEOUT(),   // 1-bit output: Byte group tristate
      .TFB(),             // 1-bit output: 3-state control
      .TQ(),               // 1-bit output: 3-state control
      .CLK(serial_clk_i),             // 1-bit input: High speed clock
      .CLKDIV(clk_i),       // 1-bit input: Divided clock
      // D1 - D8: 1-bit (each) input: Parallel data inputs (1-bit each)
      .D1(p_data_i[0]),
      .D2(p_data_i[1]),
      .D3(p_data_i[2]),
      .D4(p_data_i[3]),
      .D5(p_data_i[4]),
      .D6(p_data_i[5]),
      .D7(p_data_i[6]),
      .D8(p_data_i[7]),
      .OCE(1'b1),             // 1-bit input: Output data clock enable
      .RST(!a_rst_n_i),             // 1-bit input: Reset
      // SHIFTIN1 / SHIFTIN2: 1-bit (each) input: Data input expansion (1-bit each)
      .SHIFTIN1(SHIFTIN1),
      .SHIFTIN2(SHIFTIN2),
      // T1 - T4: 1-bit (each) input: Parallel 3-state inputs
      .T1(1'b0),
      .T2(1'b0),
      .T3(1'b0),
      .T4(1'b0),
      .TBYTEIN(1'b0),     // 1-bit input: Byte group tristate
      .TCE(1'b0)              // 1-bit input: 3-state clock enable
   );
   
   
      OSERDESE2 #(
      .DATA_RATE_OQ("DDR"),   // DDR, SDR
      .DATA_RATE_TQ("SDR"),   // DDR, BUF, SDR
      .DATA_WIDTH(10),         // Parallel data width (2-8,10,14)
      .INIT_OQ(1'b0),         // Initial value of OQ output (1'b0,1'b1)
      .INIT_TQ(1'b0),         // Initial value of TQ output (1'b0,1'b1)
      .SERDES_MODE("SLAVE"), // MASTER, SLAVE
      .SRVAL_OQ(1'b0),        // OQ output value when SR is used (1'b0,1'b1)
      .SRVAL_TQ(1'b0),        // TQ output value when SR is used (1'b0,1'b1)
      .TBYTE_CTL("FALSE"),    // Enable tristate byte operation (FALSE, TRUE)
      .TBYTE_SRC("FALSE"),    // Tristate byte source (FALSE, TRUE)
      .TRISTATE_WIDTH(1)      // 3-state converter width (1,4)
   )
   OSERDESE2_inst1 (
      .OFB(),             // 1-bit output: Feedback path for data
      .OQ(),               // 1-bit output: Data path output
      // SHIFTOUT1 / SHIFTOUT2: 1-bit (each) output: Data output expansion (1-bit each)
      .SHIFTOUT1(SHIFTIN1),
      .SHIFTOUT2(SHIFTIN2),
      .TBYTEOUT(),   // 1-bit output: Byte group tristate
      .TFB(),             // 1-bit output: 3-state control
      .TQ(),               // 1-bit output: 3-state control
      .CLK(serial_clk_i),             // 1-bit input: High speed clock
      .CLKDIV(clk_i),       // 1-bit input: Divided clock
      // D1 - D8: 1-bit (each) input: Parallel data inputs (1-bit each)
      .D1(),
      .D2(),
      .D3(p_data_i[8]),
      .D4(p_data_i[9]),
      .D5(),
      .D6(),
      .D7(),
      .D8(),
      .OCE(1'b1),             // 1-bit input: Output data clock enable
      .RST(!a_rst_n_i),             // 1-bit input: Reset
      // SHIFTIN1 / SHIFTIN2: 1-bit (each) input: Data input expansion (1-bit each)
      .SHIFTIN1(),
      .SHIFTIN2(),
      // T1 - T4: 1-bit (each) input: Parallel 3-state inputs
      .T1(1'b0),
      .T2(1'b0),
      .T3(1'b0),
      .T4(1'b0),
      .TBYTEIN(1'b0),     // 1-bit input: Byte group tristate
      .TCE(1'b0)              // 1-bit input: 3-state clock enable
   );


   // End of OSERDESE2_inst instantiation




endmodule