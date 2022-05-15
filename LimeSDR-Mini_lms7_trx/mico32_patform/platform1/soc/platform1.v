//   ==================================================================
//   >>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
//   ------------------------------------------------------------------
//   Copyright (c) 2006-2011 by Lattice Semiconductor Corporation
//   ------------------------------------------------------------------
//   ALL RIGHTS RESERVED
//
//   IMPORTANT: THIS FILE IS AUTO-GENERATED BY THE LATTICEMICO SYSTEM.
//
//   Permission:
//
//      Lattice Semiconductor grants permission to use this code
//      pursuant to the terms of the Lattice Semiconductor Corporation
//      Open Source License Agreement.
//
//   Disclaimer:
//
//      Lattice Semiconductor provides no warranty regarding the use or
//      functionality of this code. It is the user's responsibility to
//      verify the user�s design for consistency and functionality through
//      the use of formal verification methods.
//
//   --------------------------------------------------------------------
//
//                  Lattice Semiconductor Corporation
//                  5555 NE Moore Court
//                  Hillsboro, OR 97214
//                  U.S.A
//
//                  TEL: 1-800-Lattice (USA and Canada)
//                         503-286-8001 (other locations)
//
//                  web: http://www.latticesemi.com/
//                  email: techsupport@latticesemi.com
//
//   --------------------------------------------------------------------
//
//      Project:           platform1
//      File:              platform1.v
//      Date:              Sk, 15 Geg 2022 12:36:48 EEST
//      Version:           2.1
//      Targeted Family:   LFE5U-85F
//
//   =======================================================================

`include "system_conf.v"

module arbiter2
#(
	parameter MAX_DAT_WIDTH = 32,
	parameter WBS_DAT_WIDTH = 32,
	parameter WBM0_DAT_WIDTH = 32,
	parameter WBM1_DAT_WIDTH = 32
)(
	// Multiple Master Port0
	WBM0_ADR_O,
	WBM0_DAT_O,
	WBM0_DAT_I,
	WBM0_SEL_O,
	WBM0_WE_O,
	WBM0_ACK_I,
	WBM0_ERR_I,
	WBM0_RTY_I,
	WBM0_CTI_O,
	WBM0_BTE_O,
	WBM0_LOCK_O,
	WBM0_CYC_O,
	WBM0_STB_O,
	// Multiple Master Port1
	WBM1_ADR_O,
	WBM1_DAT_O,
	WBM1_DAT_I,
	WBM1_SEL_O,
	WBM1_WE_O,
	WBM1_ACK_I,
	WBM1_ERR_I,
	WBM1_RTY_I,
	WBM1_CTI_O,
	WBM1_BTE_O,
	WBM1_LOCK_O,
	WBM1_CYC_O,
	WBM1_STB_O,
	// Single Slave Port
	WBS_ADR_I,
	WBS_DAT_I,
	WBS_DAT_O,
	WBS_SEL_I,
	WBS_WE_I,
	WBS_ACK_O,
	WBS_ERR_O,
	WBS_RTY_O,
	WBS_CTI_I,
	WBS_BTE_I,
	WBS_LOCK_I,
	WBS_CYC_I,
	WBS_STB_I,

	clk,
	reset
);

input clk, reset;
input [31:0]WBM0_ADR_O;
input [WBM0_DAT_WIDTH-1:0] WBM0_DAT_O;
output [WBM0_DAT_WIDTH-1:0] WBM0_DAT_I;
input [WBM0_DAT_WIDTH/8-1:0] WBM0_SEL_O;
input  WBM0_WE_O;
output  WBM0_ACK_I;
output  WBM0_ERR_I;
output  WBM0_RTY_I;
input [2:0]WBM0_CTI_O;
input [1:0]WBM0_BTE_O;
input  WBM0_LOCK_O;
input  WBM0_CYC_O;
input  WBM0_STB_O;
input [31:0]WBM1_ADR_O;
input [WBM1_DAT_WIDTH-1:0] WBM1_DAT_O;
output [WBM1_DAT_WIDTH-1:0] WBM1_DAT_I;
input [WBM1_DAT_WIDTH/8-1:0] WBM1_SEL_O;
input  WBM1_WE_O;
output  WBM1_ACK_I;
output  WBM1_ERR_I;
output  WBM1_RTY_I;
input [2:0]WBM1_CTI_O;
input [1:0]WBM1_BTE_O;
input  WBM1_LOCK_O;
input  WBM1_CYC_O;
input  WBM1_STB_O;
output [31:0]WBS_ADR_I;
output [WBS_DAT_WIDTH-1:0] WBS_DAT_I;
input [WBS_DAT_WIDTH-1:0] WBS_DAT_O;
output [WBS_DAT_WIDTH/8-1:0] WBS_SEL_I;
output  WBS_WE_I;
input  WBS_ACK_O;
input  WBS_ERR_O;
input  WBS_RTY_O;
output [2:0]WBS_CTI_I;
output [1:0]WBS_BTE_I;
output  WBS_LOCK_I;
output  WBS_CYC_I;
output  WBS_STB_I;
wire [MAX_DAT_WIDTH-1:0] WBM0_DAT_I_INT;
wire [MAX_DAT_WIDTH-1:0] WBM0_DAT_O_INT;
wire [MAX_DAT_WIDTH/8-1:0] WBM0_SEL_O_INT;
wire [MAX_DAT_WIDTH-1:0] WBM1_DAT_I_INT;
wire [MAX_DAT_WIDTH-1:0] WBM1_DAT_O_INT;
wire [MAX_DAT_WIDTH/8-1:0] WBM1_SEL_O_INT;
wire [MAX_DAT_WIDTH-1:0] WBS_DAT_O_INT;
wire [MAX_DAT_WIDTH-1:0] WBS_DAT_I_INT;
wire [MAX_DAT_WIDTH/8-1:0] WBS_SEL_I_INT;

generate
	if ((WBS_DAT_WIDTH == 8) && ((WBM0_DAT_WIDTH == 32) || (WBM1_DAT_WIDTH == 32))) begin
		assign WBS_DAT_I = ((WBS_ADR_I[1:0] == 2'b00)
			? WBS_DAT_I_INT[31:24]
			: ((WBS_ADR_I[1:0] == 2'b01)
			? WBS_DAT_I_INT[23:16]
			: ((WBS_ADR_I[1:0] == 2'b10)
			? WBS_DAT_I_INT[15:8]
			: WBS_DAT_I_INT[7:0]
			)));
		assign WBS_SEL_I = ((WBS_ADR_I[1:0] == 2'b00)
			? WBS_SEL_I_INT[3]
			: ((WBS_ADR_I[1:0] == 2'b01)
			? WBS_SEL_I_INT[2]
			: ((WBS_ADR_I[1:0] == 2'b10)
			? WBS_SEL_I_INT[1]
			: WBS_SEL_I_INT[0]
			)));
		assign WBS_DAT_O_INT = {4{WBS_DAT_O}};
	end
	else begin
		assign WBS_DAT_I = WBS_DAT_I_INT;
		assign WBS_SEL_I = WBS_SEL_I_INT;
		assign WBS_DAT_O_INT = WBS_DAT_O;
	end
endgenerate

generate
	if ((WBS_DAT_WIDTH == 32) && (WBM0_DAT_WIDTH == 8)) begin
		assign WBM0_DAT_I = ((WBM0_ADR_O[1:0] == 2'b00)
			? WBM0_DAT_I_INT[31:24]
			: ((WBM0_ADR_O[1:0] == 2'b01)
			? WBM0_DAT_I_INT[23:16]
			: ((WBM0_ADR_O[1:0] == 2'b10)
			? WBM0_DAT_I_INT[15:8]
			: WBM0_DAT_I_INT[7:0]
			)));
		assign WBM0_DAT_O_INT = {4{WBM0_DAT_O}};
		assign WBM0_SEL_O_INT = ((WBM0_ADR_O[1:0] == 2'b00)
			? {WBM0_SEL_O, 3'b000}
			: ((WBM0_ADR_O[1:0] == 2'b01)
			? {1'b0, WBM0_SEL_O, 2'b00}
			: ((WBM0_ADR_O[1:0] == 2'b10)
			? {2'b00, WBM0_SEL_O, 1'b0}
			: {3'b000, WBM0_SEL_O}
			)));
	end
	else if ((WBS_DAT_WIDTH == 8) && (MAX_DAT_WIDTH == 32)) begin
		assign WBM0_DAT_I = WBM0_DAT_I_INT;
		assign WBM0_SEL_O_INT = {4{WBM0_SEL_O}};
		assign WBM0_DAT_O_INT = {4{WBM0_DAT_O}};
	end
	else begin
		assign WBM0_DAT_I = WBM0_DAT_I_INT;
		assign WBM0_SEL_O_INT = WBM0_SEL_O;
		assign WBM0_DAT_O_INT = WBM0_DAT_O;
	end
endgenerate

generate
	if ((WBS_DAT_WIDTH == 32) && (WBM1_DAT_WIDTH == 8)) begin
		assign WBM1_DAT_I = ((WBM1_ADR_O[1:0] == 2'b00)
			? WBM1_DAT_I_INT[31:24]
			: ((WBM1_ADR_O[1:0] == 2'b01)
			? WBM1_DAT_I_INT[23:16]
			: ((WBM1_ADR_O[1:0] == 2'b10)
			? WBM1_DAT_I_INT[15:8]
			: WBM1_DAT_I_INT[7:0]
			)));
		assign WBM1_DAT_O_INT = {4{WBM1_DAT_O}};
		assign WBM1_SEL_O_INT = ((WBM1_ADR_O[1:0] == 2'b00)
			? {WBM1_SEL_O, 3'b000}
			: ((WBM1_ADR_O[1:0] == 2'b01)
			? {1'b0, WBM1_SEL_O, 2'b00}
			: ((WBM1_ADR_O[1:0] == 2'b10)
			? {2'b00, WBM1_SEL_O, 1'b0}
			: {3'b000, WBM1_SEL_O}
			)));
	end
	else if ((WBS_DAT_WIDTH == 8) && (MAX_DAT_WIDTH == 32)) begin
		assign WBM1_DAT_I = WBM1_DAT_I_INT;
		assign WBM1_SEL_O_INT = {4{WBM1_SEL_O}};
		assign WBM1_DAT_O_INT = {4{WBM1_DAT_O}};
	end
	else begin
		assign WBM1_DAT_I = WBM1_DAT_I_INT;
		assign WBM1_SEL_O_INT = WBM1_SEL_O;
		assign WBM1_DAT_O_INT = WBM1_DAT_O;
	end
endgenerate


reg [2-1:0] 		selected; // which master is selected.
reg locked;
always @(posedge clk or posedge reset)
begin
	if (reset) begin
		selected <= #1 0;
		locked   <= #1 0;
	end
	else begin
		if (selected == 0) begin
			if (WBM0_STB_O) begin
				selected <= #1 2'd1;
				locked   <= #1 WBM0_LOCK_O;
			end
			else if (WBM1_STB_O) begin
				selected <= #1 2'd2;
				locked   <= #1 WBM1_LOCK_O;
			end
		end
		else if (selected == 2'd1) begin
			if ((WBS_ACK_O || WBS_ERR_O || locked) && ((WBM0_CTI_O == 3'b000) || (WBM0_CTI_O == 3'b111) || locked) && !WBM0_LOCK_O) begin
				selected <= #1 0;
				locked <= #1 0;
			end
		end
		else if (selected == 2'd2) begin
			if ((WBS_ACK_O || WBS_ERR_O || locked) && ((WBM1_CTI_O == 3'b000) || (WBM1_CTI_O == 3'b111) || locked) && !WBM1_LOCK_O) begin
				selected <= #1 0;
				locked <= #1 0;
			end
		end
	end
end

assign WBS_ADR_I = 
	(selected == 2'd1 ? WBM0_ADR_O : 
	(selected == 2'd2 ? WBM1_ADR_O : 
	0));
assign WBS_DAT_I_INT = 
	(selected == 2'd1 ? WBM0_DAT_O_INT : 
	(selected == 2'd2 ? WBM1_DAT_O_INT : 
	0));
assign WBS_SEL_I_INT = 
	(selected == 2'd1 ? WBM0_SEL_O_INT : 
	(selected == 2'd2 ? WBM1_SEL_O_INT : 
	0));
assign WBS_WE_I = 
	(selected == 2'd1 ? WBM0_WE_O : 
	(selected == 2'd2 ? WBM1_WE_O : 
	0));
assign WBS_CTI_I = 
	(selected == 2'd1 ? WBM0_CTI_O : 
	(selected == 2'd2 ? WBM1_CTI_O : 
	0));
assign WBS_BTE_I = 
	(selected == 2'd1 ? WBM0_BTE_O : 
	(selected == 2'd2 ? WBM1_BTE_O : 
	0));
assign WBS_LOCK_I = 
	(selected == 2'd1 ? WBM0_LOCK_O : 
	(selected == 2'd2 ? WBM1_LOCK_O : 
	0));
assign WBS_CYC_I = 
	(selected == 2'd1 ? WBM0_CYC_O : 
	(selected == 2'd2 ? WBM1_CYC_O : 
	0));
assign WBS_STB_I = 
	(selected == 2'd1 ? WBM0_STB_O : 
	(selected == 2'd2 ? WBM1_STB_O : 
	0));

assign WBM0_DAT_I_INT = WBS_DAT_O_INT;
assign WBM0_ACK_I = (selected == 2'd1 ? WBS_ACK_O : 0);
assign WBM0_ERR_I = (selected == 2'd1 ? WBS_ERR_O : 0);
assign WBM0_RTY_I = (selected == 2'd1 ? WBS_RTY_O : 0);

assign WBM1_DAT_I_INT = WBS_DAT_O_INT;
assign WBM1_ACK_I = (selected == 2'd2 ? WBS_ACK_O : 0);
assign WBM1_ERR_I = (selected == 2'd2 ? WBS_ERR_O : 0);
assign WBM1_RTY_I = (selected == 2'd2 ? WBS_RTY_O : 0);

endmodule

`include "../components/lm32_top/rtl/verilog/lm32_include_all.v"
`include "../components/wb_ebr_ctrl/rtl/verilog/wb_ebr_ctrl.v"
`include "../components/spi_flash/rtl/verilog/spi_flash.v"
`include "../components/spi_flash/rtl/verilog/wb_intf.v"
`include "../components/spi_flash/rtl/verilog/spi_flash_intf.v"
`include "../components/gpio/rtl/verilog/gpio.v"
`include "../components/gpio/rtl/verilog/tpio.v"
`include "../components/Reg_Comp/rtl/verilog/Reg_Comp.v"
`include "../components/Reg_Comp/rtl/verilog/wb_reg_dev.v"
`include "../components/spi/rtl/verilog/wb_spi.v"
`include "../components/FIFO_Comp/rtl/verilog/FIFO_Comp.v"
`include "../components/FIFO_Comp/rtl/verilog/wb_fifo_dev.v"
`include "../components/uart_core/rtl/verilog/uart_core.v"
`include "../components/i2cm_opencores/rtl/verilog/i2c_master_bit_ctrl.v"
`include "../components/i2cm_opencores/rtl/verilog/i2c_master_byte_ctrl.v"
`include "../components/i2cm_opencores/rtl/verilog/i2c_master_core.v"


module platform1 ( 
	clk_i,reset_n
, SPIFlash_CEJ
, SPIFlash_SCK
, SPIFlash_SI
, SPIFlash_SO
, SPIFlash_WPJ
, LEDPIO_OUT
, GPIOPIO_BOTH_IN
, GPIOPIO_BOTH_OUT
, GPOout_pins
, spiMISO_MASTER
, spiMOSI_MASTER
, spiSS_N_MASTER
, spiSCLK_MASTER
, FIFOout_pins
, FIFOof_d
, FIFOof_wr
, FIFOof_wrfull
, FIFOif_d
, FIFOif_rd
, FIFOif_rdempty
, FIFOfifo_rst
, uartSIN
, uartSOUT
, lms_ctr_gpioPIO_OUT
, SPIFlash_USRMCLKTS_PIO_OUT
, i2cm_oc_SDA
, i2cm_oc_SCL
, dac_spi_MISO_MASTER
, dac_spi_MOSI_MASTER
, dac_spi_SS_N_MASTER
, dac_spi_SCLK_MASTER
);
input	clk_i, reset_n;
genvar i;
wire [31:0] zwire = 32'hZZZZZZZZ;
wire [31:0] zerowire = 32'h00000000;
wire [31:0] SHAREDBUS_ADR_I;
wire [31:0] SHAREDBUS_DAT_I;
wire [31:0] SHAREDBUS_DAT_O;
wire [3:0] SHAREDBUS_SEL_I;
wire   SHAREDBUS_WE_I;
wire   SHAREDBUS_ACK_O;
wire   SHAREDBUS_ERR_O;
wire   SHAREDBUS_RTY_O;
wire [2:0] SHAREDBUS_CTI_I;
wire [1:0] SHAREDBUS_BTE_I;
wire   SHAREDBUS_LOCK_I;
wire   SHAREDBUS_CYC_I;
wire   SHAREDBUS_STB_I;
wire SHAREDBUS_en;

wire [31:0] LM32I_ADR_O;
wire [31:0] LM32I_DAT_O;
wire [31:0] LM32I_DAT_I;
wire [3:0] LM32I_SEL_O;
wire   LM32I_WE_O;
wire   LM32I_ACK_I;
wire   LM32I_ERR_I;
wire   LM32I_RTY_I;
wire [2:0] LM32I_CTI_O;
wire [1:0] LM32I_BTE_O;
wire   LM32I_LOCK_O;
wire   LM32I_CYC_O;
wire   LM32I_STB_O;
wire [31:0] LM32D_ADR_O;
wire [31:0] LM32D_DAT_O;
wire [31:0] LM32D_DAT_I;
wire [3:0] LM32D_SEL_O;
wire   LM32D_WE_O;
wire   LM32D_ACK_I;
wire   LM32D_ERR_I;
wire   LM32D_RTY_I;
wire [2:0] LM32D_CTI_O;
wire [1:0] LM32D_BTE_O;
wire   LM32D_LOCK_O;
wire   LM32D_CYC_O;
wire   LM32D_STB_O;
wire [31:0] LM32DEBUG_DAT_O;
wire   LM32DEBUG_ACK_O;
wire   LM32DEBUG_ERR_O;
wire   LM32DEBUG_RTY_O;
wire LM32DEBUG_en;
wire [31:0] LM32interrupt_n;

wire [31:0] ebrEBR_DAT_O;
wire   ebrEBR_ACK_O;
wire   ebrEBR_ERR_O;
wire   ebrEBR_RTY_O;
wire ebrEBR_en;

wire [7:0] SPIFlash_S_DAT_O;
wire   SPIFlash_S_ACK_O;
wire   SPIFlash_S_ERR_O;
wire   SPIFlash_S_RTY_O;
wire SPIFlash_S_en;
wire [7:0] SPIFlash_C_DAT_O;
wire   SPIFlash_C_ACK_O;
wire   SPIFlash_C_ERR_O;
wire   SPIFlash_C_RTY_O;
wire SPIFlash_C_en;
output  SPIFlash_CEJ;
output  SPIFlash_SCK;
output  SPIFlash_SI;
input  SPIFlash_SO;
output  SPIFlash_WPJ;

wire [31:0] LEDGPIO_DAT_O;
wire   LEDGPIO_ACK_O;
wire   LEDGPIO_ERR_O;
wire   LEDGPIO_RTY_O;
wire LEDGPIO_en;
wire LEDIRQ_O;
output [8-1:0] LEDPIO_OUT;

wire [31:0] GPIOGPIO_DAT_O;
wire   GPIOGPIO_ACK_O;
wire   GPIOGPIO_ERR_O;
wire   GPIOGPIO_RTY_O;
wire GPIOGPIO_en;
wire GPIOIRQ_O;
input [1-1:0] GPIOPIO_BOTH_IN;
output [1-1:0] GPIOPIO_BOTH_OUT;

wire [31:0] GPOwb_DAT_O;
wire   GPOwb_ACK_O;
wire   GPOwb_ERR_O;
wire   GPOwb_RTY_O;
wire GPOwb_en;
wire GPOINTR_O;
output [7:0]  GPOout_pins;

wire [31:0] spiSPI_DAT_O;
wire   spiSPI_ACK_O;
wire   spiSPI_ERR_O;
wire   spiSPI_RTY_O;
wire spiSPI_en;
wire spiSPI_INT_O;
input  spiMISO_MASTER;
output  spiMOSI_MASTER;
output [2-1:0] spiSS_N_MASTER;
output  spiSCLK_MASTER;

wire [31:0] FIFOwb_DAT_O;
wire   FIFOwb_ACK_O;
wire   FIFOwb_ERR_O;
wire   FIFOwb_RTY_O;
wire FIFOwb_en;
wire FIFOINTR_O;
output [7:0]  FIFOout_pins;
output [31:0]  FIFOof_d;
output  FIFOof_wr;
input  FIFOof_wrfull;
input [31:0]  FIFOif_d;
output  FIFOif_rd;
input  FIFOif_rdempty;
output  FIFOfifo_rst;

wire [7:0] uartUART_DAT_O;
wire   uartUART_ACK_O;
wire   uartUART_ERR_O;
wire   uartUART_RTY_O;
wire uartUART_en;
wire uartINTR;
input  uartSIN;
output  uartSOUT;

wire [31:0] lms_ctr_gpioGPIO_DAT_O;
wire   lms_ctr_gpioGPIO_ACK_O;
wire   lms_ctr_gpioGPIO_ERR_O;
wire   lms_ctr_gpioGPIO_RTY_O;
wire lms_ctr_gpioGPIO_en;
wire lms_ctr_gpioIRQ_O;
output [4-1:0] lms_ctr_gpioPIO_OUT;

wire [31:0] SPIFlash_USRMCLKTS_GPIO_DAT_O;
wire   SPIFlash_USRMCLKTS_GPIO_ACK_O;
wire   SPIFlash_USRMCLKTS_GPIO_ERR_O;
wire   SPIFlash_USRMCLKTS_GPIO_RTY_O;
wire SPIFlash_USRMCLKTS_GPIO_en;
wire SPIFlash_USRMCLKTS_IRQ_O;
output [1-1:0] SPIFlash_USRMCLKTS_PIO_OUT;

wire [31:0] i2cm_oc_I2CM_DAT_O;
wire   i2cm_oc_I2CM_ACK_O;
wire   i2cm_oc_I2CM_ERR_O;
wire   i2cm_oc_I2CM_RTY_O;
wire i2cm_oc_I2CM_en;
wire i2cm_oc_INTR_N;
inout  i2cm_oc_SDA;
inout  i2cm_oc_SCL;

wire [31:0] dac_spi_SPI_DAT_O;
wire   dac_spi_SPI_ACK_O;
wire   dac_spi_SPI_ERR_O;
wire   dac_spi_SPI_RTY_O;
wire dac_spi_SPI_en;
wire dac_spi_SPI_INT_O;
input  dac_spi_MISO_MASTER;
output  dac_spi_MOSI_MASTER;
output [1-1:0] dac_spi_SS_N_MASTER;
output  dac_spi_SCLK_MASTER;
reg [2:0] counter;
wire sys_reset = !counter[2];
always @(posedge clk_i or negedge reset_n)
if (reset_n == 1'b0)
counter <= #1 3'b000;
else
if (counter[2] == 1'b0)
counter <= #1 counter + 1'b1;


wire one_zero = 1'b0;
wire[1:0] two_zero = 2'b00;
wire[2:0] three_zero = 3'b000;
wire[3:0] four_zero = 4'b0000;
wire[31:0] thirtytwo_zero = 32'b0000_0000_0000_0000_0000_0000_0000_0000;

arbiter2
#(
.MAX_DAT_WIDTH ( 32 )
,.WBS_DAT_WIDTH ( 32 )
,.WBM0_DAT_WIDTH ( 32 )
,.WBM1_DAT_WIDTH ( 32 )
)
arbiter (
.WBM0_ADR_O(LM32I_ADR_O),
.WBM0_DAT_O(LM32I_DAT_O[31:0]),
.WBM0_DAT_I(LM32I_DAT_I),
.WBM0_SEL_O(LM32I_SEL_O[3:0]),
.WBM0_WE_O(LM32I_WE_O),
.WBM0_ACK_I(LM32I_ACK_I),
.WBM0_ERR_I(LM32I_ERR_I),
.WBM0_RTY_I(LM32I_RTY_I),
.WBM0_CTI_O(LM32I_CTI_O),
.WBM0_BTE_O(LM32I_BTE_O),
.WBM0_LOCK_O(LM32I_LOCK_O),
.WBM0_CYC_O(LM32I_CYC_O),
.WBM0_STB_O(LM32I_STB_O),
.WBM1_ADR_O(LM32D_ADR_O),
.WBM1_DAT_O(LM32D_DAT_O[31:0]),
.WBM1_DAT_I(LM32D_DAT_I),
.WBM1_SEL_O(LM32D_SEL_O[3:0]),
.WBM1_WE_O(LM32D_WE_O),
.WBM1_ACK_I(LM32D_ACK_I),
.WBM1_ERR_I(LM32D_ERR_I),
.WBM1_RTY_I(LM32D_RTY_I),
.WBM1_CTI_O(LM32D_CTI_O),
.WBM1_BTE_O(LM32D_BTE_O),
.WBM1_LOCK_O(LM32D_LOCK_O),
.WBM1_CYC_O(LM32D_CYC_O),
.WBM1_STB_O(LM32D_STB_O),
.WBS_ADR_I(SHAREDBUS_ADR_I[31:0]),
.WBS_DAT_I(SHAREDBUS_DAT_I[31:0]),
.WBS_DAT_O(SHAREDBUS_DAT_O[31:0]),
.WBS_SEL_I(SHAREDBUS_SEL_I[3:0]),
.WBS_WE_I(SHAREDBUS_WE_I),
.WBS_ACK_O(SHAREDBUS_ACK_O),
.WBS_ERR_O(SHAREDBUS_ERR_O),
.WBS_RTY_O(SHAREDBUS_RTY_O),
.WBS_CTI_I(SHAREDBUS_CTI_I),
.WBS_BTE_I(SHAREDBUS_BTE_I),
.WBS_LOCK_I(SHAREDBUS_LOCK_I),
.WBS_CYC_I(SHAREDBUS_CYC_I),
.WBS_STB_I(SHAREDBUS_STB_I),
.clk (clk_i),
.reset (sys_reset));
assign SHAREDBUS_DAT_O = 
LM32DEBUG_en ? LM32DEBUG_DAT_O : 
ebrEBR_en ? ebrEBR_DAT_O : 
SPIFlash_S_en ? {4{SPIFlash_S_DAT_O[7:0]}} : 
SPIFlash_C_en ? {4{SPIFlash_C_DAT_O[7:0]}} : 
LEDGPIO_en ? LEDGPIO_DAT_O : 
GPIOGPIO_en ? GPIOGPIO_DAT_O : 
GPOwb_en ? GPOwb_DAT_O : 
spiSPI_en ? spiSPI_DAT_O : 
FIFOwb_en ? FIFOwb_DAT_O : 
uartUART_en ? {4{uartUART_DAT_O[7:0]}} : 
lms_ctr_gpioGPIO_en ? lms_ctr_gpioGPIO_DAT_O : 
SPIFlash_USRMCLKTS_GPIO_en ? SPIFlash_USRMCLKTS_GPIO_DAT_O : 
i2cm_oc_I2CM_en ? i2cm_oc_I2CM_DAT_O : 
dac_spi_SPI_en ? dac_spi_SPI_DAT_O : 
0;
assign SHAREDBUS_ERR_O = SHAREDBUS_CYC_I & !(
(!LM32DEBUG_ERR_O & LM32DEBUG_en) | 
(!ebrEBR_ERR_O & ebrEBR_en) | 
(!SPIFlash_S_ERR_O & SPIFlash_S_en) | 
(!SPIFlash_C_ERR_O & SPIFlash_C_en) | 
(!LEDGPIO_ERR_O & LEDGPIO_en) | 
(!GPIOGPIO_ERR_O & GPIOGPIO_en) | 
(!GPOwb_ERR_O & GPOwb_en) | 
(!spiSPI_ERR_O & spiSPI_en) | 
(!FIFOwb_ERR_O & FIFOwb_en) | 
(!uartUART_ERR_O & uartUART_en) | 
(!lms_ctr_gpioGPIO_ERR_O & lms_ctr_gpioGPIO_en) | 
(!SPIFlash_USRMCLKTS_GPIO_ERR_O & SPIFlash_USRMCLKTS_GPIO_en) | 
(!i2cm_oc_I2CM_ERR_O & i2cm_oc_I2CM_en) | 
(!dac_spi_SPI_ERR_O & dac_spi_SPI_en) | 
0);
assign SHAREDBUS_ACK_O = 
LM32DEBUG_en ? LM32DEBUG_ACK_O : 
ebrEBR_en ? ebrEBR_ACK_O : 
SPIFlash_S_en ? SPIFlash_S_ACK_O : 
SPIFlash_C_en ? SPIFlash_C_ACK_O : 
LEDGPIO_en ? LEDGPIO_ACK_O : 
GPIOGPIO_en ? GPIOGPIO_ACK_O : 
GPOwb_en ? GPOwb_ACK_O : 
spiSPI_en ? spiSPI_ACK_O : 
FIFOwb_en ? FIFOwb_ACK_O : 
uartUART_en ? uartUART_ACK_O : 
lms_ctr_gpioGPIO_en ? lms_ctr_gpioGPIO_ACK_O : 
SPIFlash_USRMCLKTS_GPIO_en ? SPIFlash_USRMCLKTS_GPIO_ACK_O : 
i2cm_oc_I2CM_en ? i2cm_oc_I2CM_ACK_O : 
dac_spi_SPI_en ? dac_spi_SPI_ACK_O : 
0;
assign SHAREDBUS_RTY_O = 
LM32DEBUG_en ? LM32DEBUG_RTY_O : 
ebrEBR_en ? ebrEBR_RTY_O : 
SPIFlash_S_en ? SPIFlash_S_RTY_O : 
SPIFlash_C_en ? SPIFlash_C_RTY_O : 
LEDGPIO_en ? LEDGPIO_RTY_O : 
GPIOGPIO_en ? GPIOGPIO_RTY_O : 
GPOwb_en ? GPOwb_RTY_O : 
spiSPI_en ? spiSPI_RTY_O : 
FIFOwb_en ? FIFOwb_RTY_O : 
uartUART_en ? uartUART_RTY_O : 
lms_ctr_gpioGPIO_en ? lms_ctr_gpioGPIO_RTY_O : 
SPIFlash_USRMCLKTS_GPIO_en ? SPIFlash_USRMCLKTS_GPIO_RTY_O : 
i2cm_oc_I2CM_en ? i2cm_oc_I2CM_RTY_O : 
dac_spi_SPI_en ? dac_spi_SPI_RTY_O : 
0;
wire [31:0] LM32DEBUG_DAT_I;
assign LM32DEBUG_DAT_I = SHAREDBUS_DAT_I[31:0];
wire [3:0] LM32DEBUG_SEL_I;
assign LM32DEBUG_SEL_I = SHAREDBUS_SEL_I;
assign LM32DEBUG_en = ( SHAREDBUS_ADR_I[31:14] == 18'b000000000000000000);
lm32_top 
 LM32( 
.I_ADR_O(LM32I_ADR_O),
.I_DAT_O(LM32I_DAT_O),
.I_DAT_I(LM32I_DAT_I),
.I_SEL_O(LM32I_SEL_O),
.I_WE_O(LM32I_WE_O),
.I_ACK_I(LM32I_ACK_I),
.I_ERR_I(LM32I_ERR_I),
.I_RTY_I(LM32I_RTY_I),
.I_CTI_O(LM32I_CTI_O),
.I_BTE_O(LM32I_BTE_O),
.I_LOCK_O(LM32I_LOCK_O),
.I_CYC_O(LM32I_CYC_O),
.I_STB_O(LM32I_STB_O),
.D_ADR_O(LM32D_ADR_O),
.D_DAT_O(LM32D_DAT_O),
.D_DAT_I(LM32D_DAT_I),
.D_SEL_O(LM32D_SEL_O),
.D_WE_O(LM32D_WE_O),
.D_ACK_I(LM32D_ACK_I),
.D_ERR_I(LM32D_ERR_I),
.D_RTY_I(LM32D_RTY_I),
.D_CTI_O(LM32D_CTI_O),
.D_BTE_O(LM32D_BTE_O),
.D_LOCK_O(LM32D_LOCK_O),
.D_CYC_O(LM32D_CYC_O),
.D_STB_O(LM32D_STB_O),
.DEBUG_ADR_I(SHAREDBUS_ADR_I[31:0]),
.DEBUG_DAT_I(LM32DEBUG_DAT_I[31:0]),
.DEBUG_DAT_O(LM32DEBUG_DAT_O[31:0]),
.DEBUG_SEL_I(LM32DEBUG_SEL_I[3:0]),
.DEBUG_WE_I(SHAREDBUS_WE_I),
.DEBUG_ACK_O(LM32DEBUG_ACK_O),
.DEBUG_ERR_O(LM32DEBUG_ERR_O),
.DEBUG_RTY_O(LM32DEBUG_RTY_O),
.DEBUG_CTI_I(SHAREDBUS_CTI_I),
.DEBUG_BTE_I(SHAREDBUS_BTE_I),
.DEBUG_LOCK_I(SHAREDBUS_LOCK_I),
.DEBUG_CYC_I(SHAREDBUS_CYC_I & LM32DEBUG_en),
.DEBUG_STB_I(SHAREDBUS_STB_I & LM32DEBUG_en),
.interrupt_n(LM32interrupt_n),
.clk_i (clk_i), .rst_i (sys_reset));


wire [31:0] ebrEBR_DAT_I;
assign ebrEBR_DAT_I = SHAREDBUS_DAT_I[31:0];
wire [3:0] ebrEBR_SEL_I;
assign ebrEBR_SEL_I = SHAREDBUS_SEL_I;
assign ebrEBR_en = ( SHAREDBUS_ADR_I[31:15] == 17'b00001000000000000);
wb_ebr_ctrl 
#(
.SIZE(32768),
.EBR_WB_DAT_WIDTH(32),
.INIT_FILE_NAME("none"),
.INIT_FILE_FORMAT("hex"))
 ebr( 
.EBR_ADR_I(SHAREDBUS_ADR_I[31:0]),
.EBR_DAT_I(ebrEBR_DAT_I[31:0]),
.EBR_DAT_O(ebrEBR_DAT_O[31:0]),
.EBR_SEL_I(ebrEBR_SEL_I[3:0]),
.EBR_WE_I(SHAREDBUS_WE_I),
.EBR_ACK_O(ebrEBR_ACK_O),
.EBR_ERR_O(ebrEBR_ERR_O),
.EBR_RTY_O(ebrEBR_RTY_O),
.EBR_CTI_I(SHAREDBUS_CTI_I),
.EBR_BTE_I(SHAREDBUS_BTE_I),
.EBR_LOCK_I(SHAREDBUS_LOCK_I),
.EBR_CYC_I(SHAREDBUS_CYC_I & ebrEBR_en),
.EBR_STB_I(SHAREDBUS_STB_I & ebrEBR_en),
.CLK_I (clk_i), .RST_I (sys_reset));


wire [7:0] SPIFlash_S_DAT_I;
assign SPIFlash_S_DAT_I = ((
	SHAREDBUS_ADR_I[1:0] == 2'b00) ? SHAREDBUS_DAT_I[31:24] : ((
	SHAREDBUS_ADR_I[1:0] == 2'b01) ? SHAREDBUS_DAT_I[23:16] : ((
	SHAREDBUS_ADR_I[1:0] == 2'b10) ? SHAREDBUS_DAT_I[15:8] : SHAREDBUS_DAT_I[7:0])));
wire [7:0] SPIFlash_C_DAT_I;
assign SPIFlash_C_DAT_I = ((
	SHAREDBUS_ADR_I[1:0] == 2'b00) ? SHAREDBUS_DAT_I[31:24] : ((
	SHAREDBUS_ADR_I[1:0] == 2'b01) ? SHAREDBUS_DAT_I[23:16] : ((
	SHAREDBUS_ADR_I[1:0] == 2'b10) ? SHAREDBUS_DAT_I[15:8] : SHAREDBUS_DAT_I[7:0])));
wire SPIFlash_S_SEL_I;
assign SPIFlash_S_SEL_I = ((
	SHAREDBUS_ADR_I[1:0] == 2'b00) ? SHAREDBUS_SEL_I[3] : ((
	SHAREDBUS_ADR_I[1:0] == 2'b01) ? SHAREDBUS_SEL_I[2] : ((
	SHAREDBUS_ADR_I[1:0] == 2'b10) ? SHAREDBUS_SEL_I[1] : SHAREDBUS_SEL_I[0])));
wire SPIFlash_C_SEL_I;
assign SPIFlash_C_SEL_I = ((
	SHAREDBUS_ADR_I[1:0] == 2'b00) ? SHAREDBUS_SEL_I[3] : ((
	SHAREDBUS_ADR_I[1:0] == 2'b01) ? SHAREDBUS_SEL_I[2] : ((
	SHAREDBUS_ADR_I[1:0] == 2'b10) ? SHAREDBUS_SEL_I[1] : SHAREDBUS_SEL_I[0])));
assign SPIFlash_S_en = ( SHAREDBUS_ADR_I[31:27] == 5'b00010);
assign SPIFlash_C_en = ( SHAREDBUS_ADR_I[31:11] == 21'b100000000000000000000);
spi_flash 
#(
.LATTICE_FAMILY("ECP5U"),
.S_WB_DAT_WIDTH(8),
.S_WB_ADR_WIDTH(32),
.C_PORT_ENABLE(1),
.C_WB_DAT_WIDTH(8),
.C_WB_ADR_WIDTH(11),
.CLOCK_SEL(32'ha),
.PAGE_PRG_BUF_ENA(1),
.PAGE_PRG_BUFFER_EBR(0),
.PAGE_PRG_BUFFER_DISTRIBUTED_RAM(1),
.PAGE_READ_BUF_ENA(1),
.PAGE_READ_BUFFER_EBR(0),
.PAGE_READ_BUFFER_DISTRIBUTED_RAM(1),
.SPI_READ(32'h3),
.SPI_FAST_READ(32'hb),
.SPI_BYTE_PRG(32'h2),
.SPI_PAGE_PRG(32'h2),
.SPI_BLK1_ERS(32'h20),
.SPI_BLK2_ERS(32'h52),
.SPI_BLK3_ERS(32'hd8),
.SPI_CHIP_ERS(32'hc7),
.SPI_WRT_ENB(32'h6),
.SPI_WRT_DISB(32'h4),
.SPI_READ_STAT(32'h5),
.SPI_WRT_STAT(32'h1),
.SPI_PWD_DOWN(32'hb9),
.SPI_PWD_UP(32'hab),
.SPI_DEV_ID(32'h90))
 SPIFlash_( 
.S_ADR_I(SHAREDBUS_ADR_I[31:0]),
.S_DAT_I(SPIFlash_S_DAT_I[7:0]),
.S_DAT_O(SPIFlash_S_DAT_O[7:0]),
.S_SEL_I(SPIFlash_S_SEL_I),
.S_WE_I(SHAREDBUS_WE_I),
.S_ACK_O(SPIFlash_S_ACK_O),
.S_ERR_O(SPIFlash_S_ERR_O),
.S_RTY_O(SPIFlash_S_RTY_O),
.S_CTI_I(SHAREDBUS_CTI_I),
.S_BTE_I(SHAREDBUS_BTE_I),
.S_LOCK_I(SHAREDBUS_LOCK_I),
.S_CYC_I(SHAREDBUS_CYC_I & SPIFlash_S_en),
.S_STB_I(SHAREDBUS_STB_I & SPIFlash_S_en),
.C_ADR_I(SHAREDBUS_ADR_I[10:0]),
.C_DAT_I(SPIFlash_C_DAT_I[7:0]),
.C_DAT_O(SPIFlash_C_DAT_O[7:0]),
.C_SEL_I(SPIFlash_C_SEL_I),
.C_WE_I(SHAREDBUS_WE_I),
.C_ACK_O(SPIFlash_C_ACK_O),
.C_ERR_O(SPIFlash_C_ERR_O),
.C_RTY_O(SPIFlash_C_RTY_O),
.C_CTI_I(SHAREDBUS_CTI_I),
.C_BTE_I(SHAREDBUS_BTE_I),
.C_LOCK_I(SHAREDBUS_LOCK_I),
.C_CYC_I(SHAREDBUS_CYC_I & SPIFlash_C_en),
.C_STB_I(SHAREDBUS_STB_I & SPIFlash_C_en),
.CEJ(SPIFlash_CEJ),
.SCK(SPIFlash_SCK),
.SI(SPIFlash_SI),
.SO(SPIFlash_SO),
.WPJ(SPIFlash_WPJ),
.CLK_I(clk_i), .RST_I(sys_reset));


wire [31:0] LEDGPIO_DAT_I;
assign LEDGPIO_DAT_I = SHAREDBUS_DAT_I[31:0];
wire [3:0] LEDGPIO_SEL_I;
assign LEDGPIO_SEL_I = SHAREDBUS_SEL_I;
assign LEDGPIO_en = ( SHAREDBUS_ADR_I[31:4] == 28'b1000000000000000000010000000);
gpio 
#(
.GPIO_WB_DAT_WIDTH(32),
.GPIO_WB_ADR_WIDTH(4),
.OUTPUT_PORTS_ONLY(1),
.INPUT_PORTS_ONLY(0),
.TRISTATE_PORTS(0),
.BOTH_INPUT_AND_OUTPUT(0),
.DATA_WIDTH(32'h8),
.INPUT_WIDTH(32'h1),
.OUTPUT_WIDTH(32'h1),
.IRQ_MODE(0),
.LEVEL(0),
.EDGE(1),
.EITHER_EDGE_IRQ(0),
.POSE_EDGE_IRQ(1),
.NEGE_EDGE_IRQ(0))
 LED( 
.GPIO_ADR_I(SHAREDBUS_ADR_I[3:0]),
.GPIO_DAT_I(LEDGPIO_DAT_I[31:0]),
.GPIO_DAT_O(LEDGPIO_DAT_O[31:0]),
.GPIO_SEL_I(LEDGPIO_SEL_I[3:0]),
.GPIO_WE_I(SHAREDBUS_WE_I),
.GPIO_ACK_O(LEDGPIO_ACK_O),
.GPIO_ERR_O(LEDGPIO_ERR_O),
.GPIO_RTY_O(LEDGPIO_RTY_O),
.GPIO_CTI_I(SHAREDBUS_CTI_I),
.GPIO_BTE_I(SHAREDBUS_BTE_I),
.GPIO_LOCK_I(SHAREDBUS_LOCK_I),
.GPIO_CYC_I(SHAREDBUS_CYC_I & LEDGPIO_en),
.GPIO_STB_I(SHAREDBUS_STB_I & LEDGPIO_en),
.PIO_OUT(LEDPIO_OUT),
.IRQ_O(LEDIRQ_O),
.CLK_I(clk_i), .RST_I(sys_reset));


wire [31:0] GPIOGPIO_DAT_I;
assign GPIOGPIO_DAT_I = SHAREDBUS_DAT_I[31:0];
wire [3:0] GPIOGPIO_SEL_I;
assign GPIOGPIO_SEL_I = SHAREDBUS_SEL_I;
assign GPIOGPIO_en = ( SHAREDBUS_ADR_I[31:4] == 28'b1000000000000000000100000000);
gpio 
#(
.GPIO_WB_DAT_WIDTH(32),
.GPIO_WB_ADR_WIDTH(4),
.OUTPUT_PORTS_ONLY(0),
.INPUT_PORTS_ONLY(0),
.TRISTATE_PORTS(0),
.BOTH_INPUT_AND_OUTPUT(1),
.DATA_WIDTH(32'h1),
.INPUT_WIDTH(32'h1),
.OUTPUT_WIDTH(32'h1),
.IRQ_MODE(0),
.LEVEL(0),
.EDGE(1),
.EITHER_EDGE_IRQ(0),
.POSE_EDGE_IRQ(1),
.NEGE_EDGE_IRQ(0))
 GPIO( 
.GPIO_ADR_I(SHAREDBUS_ADR_I[3:0]),
.GPIO_DAT_I(GPIOGPIO_DAT_I[31:0]),
.GPIO_DAT_O(GPIOGPIO_DAT_O[31:0]),
.GPIO_SEL_I(GPIOGPIO_SEL_I[3:0]),
.GPIO_WE_I(SHAREDBUS_WE_I),
.GPIO_ACK_O(GPIOGPIO_ACK_O),
.GPIO_ERR_O(GPIOGPIO_ERR_O),
.GPIO_RTY_O(GPIOGPIO_RTY_O),
.GPIO_CTI_I(SHAREDBUS_CTI_I),
.GPIO_BTE_I(SHAREDBUS_BTE_I),
.GPIO_LOCK_I(SHAREDBUS_LOCK_I),
.GPIO_CYC_I(SHAREDBUS_CYC_I & GPIOGPIO_en),
.GPIO_STB_I(SHAREDBUS_STB_I & GPIOGPIO_en),
.PIO_BOTH_IN(GPIOPIO_BOTH_IN),
.PIO_BOTH_OUT(GPIOPIO_BOTH_OUT),
.IRQ_O(GPIOIRQ_O),
.CLK_I(clk_i), .RST_I(sys_reset));


wire [31:0] GPOwb_DAT_I;
assign GPOwb_DAT_I = SHAREDBUS_DAT_I[31:0];
wire [3:0] GPOwb_SEL_I;
assign GPOwb_SEL_I = SHAREDBUS_SEL_I;
assign GPOwb_en = ( SHAREDBUS_ADR_I[31:5] == 27'b100000000000000000011000000);
Reg_Comp 
#(
.reg_08_int_val(32'h1234abcd),
.CLK_MHZ(48.0))
 GPO( 
.wb_ADR_I(SHAREDBUS_ADR_I[31:0]),
.wb_DAT_I(GPOwb_DAT_I[31:0]),
.wb_DAT_O(GPOwb_DAT_O[31:0]),
.wb_SEL_I(GPOwb_SEL_I[3:0]),
.wb_WE_I(SHAREDBUS_WE_I),
.wb_ACK_O(GPOwb_ACK_O),
.wb_ERR_O(GPOwb_ERR_O),
.wb_RTY_O(GPOwb_RTY_O),
.wb_CTI_I(SHAREDBUS_CTI_I),
.wb_BTE_I(SHAREDBUS_BTE_I),
.wb_LOCK_I(SHAREDBUS_LOCK_I),
.wb_CYC_I(SHAREDBUS_CYC_I & GPOwb_en),
.wb_STB_I(SHAREDBUS_STB_I & GPOwb_en),
.out_pins(GPOout_pins),
.INTR_O(GPOINTR_O),
.CLK_I(clk_i), .RST_I(sys_reset));


wire [31:0] spiSPI_DAT_I;
assign spiSPI_DAT_I = SHAREDBUS_DAT_I[31:0];
wire [3:0] spiSPI_SEL_I;
assign spiSPI_SEL_I = SHAREDBUS_SEL_I;
assign spiSPI_en = ( SHAREDBUS_ADR_I[31:8] == 24'b100000000000000000100000);
spi 
#(
.MASTER(1),
.SLAVE_NUMBER(32'h2),
.CLOCK_SEL(7),
.CLKCNT_WIDTH(16),
.INTERVAL_LENGTH(2),
.DATA_LENGTH(32),
.SHIFT_DIRECTION(0),
.CLOCK_PHASE(0),
.CLOCK_POLARITY(0))
 spi( 
.SPI_ADR_I(SHAREDBUS_ADR_I[31:0]),
.SPI_DAT_I(spiSPI_DAT_I[31:0]),
.SPI_DAT_O(spiSPI_DAT_O[31:0]),
.SPI_SEL_I(spiSPI_SEL_I[3:0]),
.SPI_WE_I(SHAREDBUS_WE_I),
.SPI_ACK_O(spiSPI_ACK_O),
.SPI_ERR_O(spiSPI_ERR_O),
.SPI_RTY_O(spiSPI_RTY_O),
.SPI_CTI_I(SHAREDBUS_CTI_I),
.SPI_BTE_I(SHAREDBUS_BTE_I),
.SPI_LOCK_I(SHAREDBUS_LOCK_I),
.SPI_CYC_I(SHAREDBUS_CYC_I & spiSPI_en),
.SPI_STB_I(SHAREDBUS_STB_I & spiSPI_en),
.MISO_MASTER(spiMISO_MASTER),
.MOSI_MASTER(spiMOSI_MASTER),
.SS_N_MASTER(spiSS_N_MASTER),
.SCLK_MASTER(spiSCLK_MASTER),
.SPI_INT_O(spiSPI_INT_O),
.CLK_I(clk_i), .RST_I(sys_reset));


wire [31:0] FIFOwb_DAT_I;
assign FIFOwb_DAT_I = SHAREDBUS_DAT_I[31:0];
wire [3:0] FIFOwb_SEL_I;
assign FIFOwb_SEL_I = SHAREDBUS_SEL_I;
assign FIFOwb_en = ( SHAREDBUS_ADR_I[31:5] == 27'b100000000000000000101000000);
FIFO_Comp 
#(
.reg_16_int_val(32'h1234abcd))
 FIFO( 
.wb_ADR_I(SHAREDBUS_ADR_I[31:0]),
.wb_DAT_I(FIFOwb_DAT_I[31:0]),
.wb_DAT_O(FIFOwb_DAT_O[31:0]),
.wb_SEL_I(FIFOwb_SEL_I[3:0]),
.wb_WE_I(SHAREDBUS_WE_I),
.wb_ACK_O(FIFOwb_ACK_O),
.wb_ERR_O(FIFOwb_ERR_O),
.wb_RTY_O(FIFOwb_RTY_O),
.wb_CTI_I(SHAREDBUS_CTI_I),
.wb_BTE_I(SHAREDBUS_BTE_I),
.wb_LOCK_I(SHAREDBUS_LOCK_I),
.wb_CYC_I(SHAREDBUS_CYC_I & FIFOwb_en),
.wb_STB_I(SHAREDBUS_STB_I & FIFOwb_en),
.out_pins(FIFOout_pins),
.of_d(FIFOof_d),
.of_wr(FIFOof_wr),
.of_wrfull(FIFOof_wrfull),
.if_d(FIFOif_d),
.if_rd(FIFOif_rd),
.if_rdempty(FIFOif_rdempty),
.fifo_rst(FIFOfifo_rst),
.INTR_O(FIFOINTR_O),
.CLK_I(clk_i), .RST_I(sys_reset));


wire [7:0] uartUART_DAT_I;
assign uartUART_DAT_I = ((
	SHAREDBUS_ADR_I[1:0] == 2'b00) ? SHAREDBUS_DAT_I[31:24] : ((
	SHAREDBUS_ADR_I[1:0] == 2'b01) ? SHAREDBUS_DAT_I[23:16] : ((
	SHAREDBUS_ADR_I[1:0] == 2'b10) ? SHAREDBUS_DAT_I[15:8] : SHAREDBUS_DAT_I[7:0])));
wire uartUART_SEL_I;
assign uartUART_SEL_I = ((
	SHAREDBUS_ADR_I[1:0] == 2'b00) ? SHAREDBUS_SEL_I[3] : ((
	SHAREDBUS_ADR_I[1:0] == 2'b01) ? SHAREDBUS_SEL_I[2] : ((
	SHAREDBUS_ADR_I[1:0] == 2'b10) ? SHAREDBUS_SEL_I[1] : SHAREDBUS_SEL_I[0])));
assign uartUART_en = ( SHAREDBUS_ADR_I[31:4] == 28'b1000000000000000001100000000);
uart_core 
#(
.UART_WB_DAT_WIDTH(8),
.UART_WB_ADR_WIDTH(4),
.CLK_IN_MHZ(48.0),
.BAUD_RATE(115200),
.STDOUT_SIM(0),
.STDOUT_SIMFAST(0),
.LCR_DATA_BITS(8),
.LCR_STOP_BITS(1),
.LCR_PARITY_ENABLE(0),
.LCR_PARITY_ODD(0),
.LCR_PARITY_STICK(0),
.LCR_SET_BREAK(0),
.FIFO(0))
 uart( 
.UART_ADR_I(SHAREDBUS_ADR_I[3:0]),
.UART_DAT_I(uartUART_DAT_I[7:0]),
.UART_DAT_O(uartUART_DAT_O[7:0]),
.UART_SEL_I(uartUART_SEL_I),
.UART_WE_I(SHAREDBUS_WE_I),
.UART_ACK_O(uartUART_ACK_O),
.UART_ERR_O(uartUART_ERR_O),
.UART_RTY_O(uartUART_RTY_O),
.UART_CTI_I(SHAREDBUS_CTI_I),
.UART_BTE_I(SHAREDBUS_BTE_I),
.UART_LOCK_I(SHAREDBUS_LOCK_I),
.UART_CYC_I(SHAREDBUS_CYC_I & uartUART_en),
.UART_STB_I(SHAREDBUS_STB_I & uartUART_en),
.SIN(uartSIN),
.SOUT(uartSOUT),
.INTR(uartINTR),
.CLK(clk_i), .RESET(sys_reset));


wire [31:0] lms_ctr_gpioGPIO_DAT_I;
assign lms_ctr_gpioGPIO_DAT_I = SHAREDBUS_DAT_I[31:0];
wire [3:0] lms_ctr_gpioGPIO_SEL_I;
assign lms_ctr_gpioGPIO_SEL_I = SHAREDBUS_SEL_I;
assign lms_ctr_gpioGPIO_en = ( SHAREDBUS_ADR_I[31:4] == 28'b1000000000000000001110000000);
gpio 
#(
.GPIO_WB_DAT_WIDTH(32),
.GPIO_WB_ADR_WIDTH(4),
.OUTPUT_PORTS_ONLY(1),
.INPUT_PORTS_ONLY(0),
.TRISTATE_PORTS(0),
.BOTH_INPUT_AND_OUTPUT(0),
.DATA_WIDTH(32'h4),
.INPUT_WIDTH(32'h1),
.OUTPUT_WIDTH(32'h1),
.IRQ_MODE(0),
.LEVEL(0),
.EDGE(1),
.EITHER_EDGE_IRQ(0),
.POSE_EDGE_IRQ(1),
.NEGE_EDGE_IRQ(0))
 lms_ctr_gpio( 
.GPIO_ADR_I(SHAREDBUS_ADR_I[3:0]),
.GPIO_DAT_I(lms_ctr_gpioGPIO_DAT_I[31:0]),
.GPIO_DAT_O(lms_ctr_gpioGPIO_DAT_O[31:0]),
.GPIO_SEL_I(lms_ctr_gpioGPIO_SEL_I[3:0]),
.GPIO_WE_I(SHAREDBUS_WE_I),
.GPIO_ACK_O(lms_ctr_gpioGPIO_ACK_O),
.GPIO_ERR_O(lms_ctr_gpioGPIO_ERR_O),
.GPIO_RTY_O(lms_ctr_gpioGPIO_RTY_O),
.GPIO_CTI_I(SHAREDBUS_CTI_I),
.GPIO_BTE_I(SHAREDBUS_BTE_I),
.GPIO_LOCK_I(SHAREDBUS_LOCK_I),
.GPIO_CYC_I(SHAREDBUS_CYC_I & lms_ctr_gpioGPIO_en),
.GPIO_STB_I(SHAREDBUS_STB_I & lms_ctr_gpioGPIO_en),
.PIO_OUT(lms_ctr_gpioPIO_OUT),
.IRQ_O(lms_ctr_gpioIRQ_O),
.CLK_I(clk_i), .RST_I(sys_reset));


wire [31:0] SPIFlash_USRMCLKTS_GPIO_DAT_I;
assign SPIFlash_USRMCLKTS_GPIO_DAT_I = SHAREDBUS_DAT_I[31:0];
wire [3:0] SPIFlash_USRMCLKTS_GPIO_SEL_I;
assign SPIFlash_USRMCLKTS_GPIO_SEL_I = SHAREDBUS_SEL_I;
assign SPIFlash_USRMCLKTS_GPIO_en = ( SHAREDBUS_ADR_I[31:4] == 28'b1000000000000000010000000000);
gpio 
#(
.GPIO_WB_DAT_WIDTH(32),
.GPIO_WB_ADR_WIDTH(4),
.OUTPUT_PORTS_ONLY(1),
.INPUT_PORTS_ONLY(0),
.TRISTATE_PORTS(0),
.BOTH_INPUT_AND_OUTPUT(0),
.DATA_WIDTH(32'h1),
.INPUT_WIDTH(32'h1),
.OUTPUT_WIDTH(32'h1),
.IRQ_MODE(0),
.LEVEL(0),
.EDGE(1),
.EITHER_EDGE_IRQ(0),
.POSE_EDGE_IRQ(1),
.NEGE_EDGE_IRQ(0))
 SPIFlash_USRMCLKTS_( 
.GPIO_ADR_I(SHAREDBUS_ADR_I[3:0]),
.GPIO_DAT_I(SPIFlash_USRMCLKTS_GPIO_DAT_I[31:0]),
.GPIO_DAT_O(SPIFlash_USRMCLKTS_GPIO_DAT_O[31:0]),
.GPIO_SEL_I(SPIFlash_USRMCLKTS_GPIO_SEL_I[3:0]),
.GPIO_WE_I(SHAREDBUS_WE_I),
.GPIO_ACK_O(SPIFlash_USRMCLKTS_GPIO_ACK_O),
.GPIO_ERR_O(SPIFlash_USRMCLKTS_GPIO_ERR_O),
.GPIO_RTY_O(SPIFlash_USRMCLKTS_GPIO_RTY_O),
.GPIO_CTI_I(SHAREDBUS_CTI_I),
.GPIO_BTE_I(SHAREDBUS_BTE_I),
.GPIO_LOCK_I(SHAREDBUS_LOCK_I),
.GPIO_CYC_I(SHAREDBUS_CYC_I & SPIFlash_USRMCLKTS_GPIO_en),
.GPIO_STB_I(SHAREDBUS_STB_I & SPIFlash_USRMCLKTS_GPIO_en),
.PIO_OUT(SPIFlash_USRMCLKTS_PIO_OUT),
.IRQ_O(SPIFlash_USRMCLKTS_IRQ_O),
.CLK_I(clk_i), .RST_I(sys_reset));


wire [31:0] i2cm_oc_I2CM_DAT_I;
assign i2cm_oc_I2CM_DAT_I = SHAREDBUS_DAT_I[31:0];
wire [3:0] i2cm_oc_I2CM_SEL_I;
assign i2cm_oc_I2CM_SEL_I = SHAREDBUS_SEL_I;
assign i2cm_oc_I2CM_en = ( SHAREDBUS_ADR_I[31:7] == 25'b1000000000000000010010000);
i2cm_opencores 
#(
.SPEED(400),
.SYSCLK(48.0))
 i2cm_oc_( 
.I2CM_ADR_I(SHAREDBUS_ADR_I[31:0]),
.I2CM_DAT_I(i2cm_oc_I2CM_DAT_I[31:0]),
.I2CM_DAT_O(i2cm_oc_I2CM_DAT_O[31:0]),
.I2CM_SEL_I(i2cm_oc_I2CM_SEL_I[3:0]),
.I2CM_WE_I(SHAREDBUS_WE_I),
.I2CM_ACK_O(i2cm_oc_I2CM_ACK_O),
.I2CM_ERR_O(i2cm_oc_I2CM_ERR_O),
.I2CM_RTY_O(i2cm_oc_I2CM_RTY_O),
.I2CM_CTI_I(SHAREDBUS_CTI_I),
.I2CM_BTE_I(SHAREDBUS_BTE_I),
.I2CM_LOCK_I(SHAREDBUS_LOCK_I),
.I2CM_CYC_I(SHAREDBUS_CYC_I & i2cm_oc_I2CM_en),
.I2CM_STB_I(SHAREDBUS_STB_I & i2cm_oc_I2CM_en),
.SDA(i2cm_oc_SDA),
.SCL(i2cm_oc_SCL),
.INTR_N(i2cm_oc_INTR_N),
.CLK_I (clk_i), .RST_I (sys_reset));


wire [31:0] dac_spi_SPI_DAT_I;
assign dac_spi_SPI_DAT_I = SHAREDBUS_DAT_I[31:0];
wire [3:0] dac_spi_SPI_SEL_I;
assign dac_spi_SPI_SEL_I = SHAREDBUS_SEL_I;
assign dac_spi_SPI_en = ( SHAREDBUS_ADR_I[31:8] == 24'b100000000000000001010000);
spi 
#(
.MASTER(1),
.SLAVE_NUMBER(32'h1),
.CLOCK_SEL(7),
.CLKCNT_WIDTH(16),
.INTERVAL_LENGTH(2),
.DATA_LENGTH(16),
.SHIFT_DIRECTION(0),
.CLOCK_PHASE(1),
.CLOCK_POLARITY(0))
 dac_spi_( 
.SPI_ADR_I(SHAREDBUS_ADR_I[31:0]),
.SPI_DAT_I(dac_spi_SPI_DAT_I[31:0]),
.SPI_DAT_O(dac_spi_SPI_DAT_O[31:0]),
.SPI_SEL_I(dac_spi_SPI_SEL_I[3:0]),
.SPI_WE_I(SHAREDBUS_WE_I),
.SPI_ACK_O(dac_spi_SPI_ACK_O),
.SPI_ERR_O(dac_spi_SPI_ERR_O),
.SPI_RTY_O(dac_spi_SPI_RTY_O),
.SPI_CTI_I(SHAREDBUS_CTI_I),
.SPI_BTE_I(SHAREDBUS_BTE_I),
.SPI_LOCK_I(SHAREDBUS_LOCK_I),
.SPI_CYC_I(SHAREDBUS_CYC_I & dac_spi_SPI_en),
.SPI_STB_I(SHAREDBUS_STB_I & dac_spi_SPI_en),
.MISO_MASTER(dac_spi_MISO_MASTER),
.MOSI_MASTER(dac_spi_MOSI_MASTER),
.SS_N_MASTER(dac_spi_SS_N_MASTER),
.SCLK_MASTER(dac_spi_SCLK_MASTER),
.SPI_INT_O(dac_spi_SPI_INT_O),
.CLK_I(clk_i), .RST_I(sys_reset));


assign LM32interrupt_n[0] = !GPOINTR_O ;
assign LM32interrupt_n[1] = !spiSPI_INT_O ;
assign LM32interrupt_n[2] = !FIFOINTR_O ;
assign LM32interrupt_n[3] = !uartINTR ;
assign LM32interrupt_n[4] = !i2cm_oc_INTR_N ;
assign LM32interrupt_n[5] = !dac_spi_SPI_INT_O ;
assign LM32interrupt_n[6] = 1;
assign LM32interrupt_n[7] = 1;
assign LM32interrupt_n[8] = 1;
assign LM32interrupt_n[9] = 1;
assign LM32interrupt_n[10] = 1;
assign LM32interrupt_n[11] = 1;
assign LM32interrupt_n[12] = 1;
assign LM32interrupt_n[13] = 1;
assign LM32interrupt_n[14] = 1;
assign LM32interrupt_n[15] = 1;
assign LM32interrupt_n[16] = 1;
assign LM32interrupt_n[17] = 1;
assign LM32interrupt_n[18] = 1;
assign LM32interrupt_n[19] = 1;
assign LM32interrupt_n[20] = 1;
assign LM32interrupt_n[21] = 1;
assign LM32interrupt_n[22] = 1;
assign LM32interrupt_n[23] = 1;
assign LM32interrupt_n[24] = 1;
assign LM32interrupt_n[25] = 1;
assign LM32interrupt_n[26] = 1;
assign LM32interrupt_n[27] = 1;
assign LM32interrupt_n[28] = 1;
assign LM32interrupt_n[29] = 1;
assign LM32interrupt_n[30] = 1;
assign LM32interrupt_n[31] = 1;
endmodule
