/////////////////////////////////////////////////////////////////////////////////////////////////////////
// Company:        MICRO-ELECTRONICS RESEARCH LABORATORY                                               //
//                                                                                                     //
// Engineers:      M.Uzair Qureshi								                                                     //
//                                                                                                     //
// Additional contributions by:                                                                        //
//                                                                                                     //
// Create Date:    08-MARCH-2022                                                                       //
// Design Name:    Uart                                                                                //
// Module Name:    uarr_core.sv                                                                        //
// Project Name:   UART PERIPHERAL								                                                     //
// Language:       SystemVerilog			                                                                 //
//                                                                                                     //
// Description:                                                                                        //
//     -Connects all the modules of uart and contains all the configurable registers  								 //
//       				                                                                                       //
//                                                                                                     //
// Revision Date:                                                                                      //
//                                                                                                     //
/////////////////////////////////////////////////////////////////////////////////////////////////////////

module uart_top_apb(
  input logic pclk_i,
  input logic prst_ni,
  input logic [31:0] pwdata_i,
  input logic [11:0] paddr_i,
  input logic psel_i,
  input logic pwrite_i,
  input logic rx_i,
  input logic penable_i,
  output logic pslverr_o,
  output logic [31:0] prdata_o,
  output logic pready_o,
  output logic tx_o,
  output logic intr_tx_o,
  output logic intr_rx_o,
  output logic intr_tx_level_o,
  output logic intr_rx_timeout_o,
  output logic intr_tx_full_o,
  output logic intr_tx_empty_o,
  output logic intr_rx_full_o,
  output logic intr_rx_empty_o
);

logic pwrite_w;
logic pwrite_r;

uart_core utc(
  .pclk_i(pclk_i),
  .prst_ni(prst_ni),
  .pwdata_i(pwdata_i),
  .paddr_i(paddr_i),
  .pwrite_i(pwrite_w),
  .pread_i(pwrite_r),
  .rx_i(rx_i),
  .tx_o(tx_o),
  .intr_rx(intr_rx_o),
  .intr_tx(intr_tx_o),
  .intr_tx_empty(intr_tx_empty_o),
  .intr_rx_empty(intr_rx_empty_o),
  .intr_tx_level(intr_tx_level_o),
  .intr_rx_timeout(intr_rx_timeout_o),
  .intr_tx_full(intr_tx_full_o),
  .intr_rx_full(intr_rx_full_o)
);

assign pwrite_w = pwrite_i && psel_i && penable_i;              //when pwrite_i is set high and psel_i and penable_i are also high then the pwrite_w signal will set high
assign pwrite_r = !pwrite_i && psel_i && penable_i;             //when pwrite_i is set low and psel_i and penable_i are also high then the pwrite_r signal will set high
assign pslverr_o = 1'b0;
assign pready_o 1'b1;

endmodule