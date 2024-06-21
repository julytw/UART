module TOP (
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 PCLK CLK" *)
  (* X_INTERFACE_PARAMETER = "ASSOCIATED_RESET PRESETn FREQ_HZ 50000000" *)
  input PCLK, // (required)
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 PRESETn RST" *)
  (* X_INTERFACE_PARAMETER = "POLARITY ACTIVE_LOW" *)
  input PRESETn, // (required)
  (* X_INTERFACE_INFO = "xilinx.com:signal:interrupt:1.0 irqreq INTERRUPT" *)
  (* X_INTERFACE_PARAMETER = "SENSITIVITY EDGE_RISING" *)
  output irqreq,
  (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 S_APB PADDR" *)
  input [31:0] PADDR, // Address (required)
  //(* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 <interface_name> PPROT" *)
  //input [2:0] <s_pprot>, // Protection (optional)
  (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 S_APB PSEL" *)
  input PSEL, // Slave Select (required)
  (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 S_APB PENABLE" *)
  input PENABLE, // Enable (required)
  (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 S_APB PWRITE" *)
  input PWRITE, // Write Control (required)
  (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 S_APB PWDATA" *)
  input [31:0] PWDATA, // Write Data (required)
  //(* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 <interface_name> PSTRB" *)
  //input [3:0] <s_pstrb>, // Write data strobe (optional)
  (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 S_APB PREADY" *)
  output PREADY, // Slave Ready (required)
  (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 S_APB PRDATA" *)
  output [31:0] PRDATA, // Read Data (required)
  (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 S_APB PSLVERR" *)
  output PSLVERR, // Slave Error Response (required)
//  additional ports here
  input  rxd,
  output txd
);
/*module TOP(
	input         PCLK,
	input         PRESETn,
	input  [31:0] PADDR,
	input         PSEL,
	input         PENABLE,
	input         PWRITE,
	input  [31:0] PWDATA,
	output        PREADY,
	output [31:0] PRDATA,
	output        PSLVERR,
	output        irqreq,
	input         rxd,
	output        txd
	);*/
	//wire       m_clk;
	wire          rx_load;
	wire   [31:0] rx_data;
	wire          tx_load;
	wire   [31:0] tx_data;
	wire          tx_comp;
	wire   [11:0] ubrr_out;
	wire          tick;
	
	uart_baud_rate u0(
		.clk(PCLK), 
		.reset(PRESETn), 
		.ubrr_in(ubrr_out), 
		.tick(tick)
		);
	uart_rx        u1(
		.clk(PCLK), 
		.reset(PRESETn), 
		.enable(tick), 
		.rxd(rxd), 
		.data_out(rx_data), 
		.load(rx_load)
		);
	uart_tx        u2(
		.clk(PCLK),
		.reset(PRESETn),
		.load(tx_load),
		.enable(tick),
		.data_in(tx_data),
		.txd(txd), 
		.comp(tx_comp)
		);
	uart_reg       u3(
		.pclk(PCLK), 
		.presetn(PRESETn), 
		.psel(PSEL), 
		.penable(PENABLE), 
		.pwrite(PWRITE), 
		.pwdata(PWDATA), 
		.paddr(PADDR),
		.rx_load(rx_load), 
		.rx_data(rx_data), 
		.tx_comp(tx_comp), 
		.prdata(PRDATA), 
		.tx_data(tx_data), 
		.tx_load(tx_load),
		.pready(PREADY), 
		.irqreq(irqreq),
		.pslverr(PSLVERR),
		.ubrr_out(ubrr_out)
		);
	
endmodule