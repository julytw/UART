
// apb -  (slave directions)
// 
module uart (
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 pclk CLK" *)
  (* X_INTERFACE_PARAMETER = "ASSOCIATED_RESET presetn FREQ_HZ 50000000" *)
  input pclk, // (required)
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 presetn RST" *)
  (* X_INTERFACE_PARAMETER = "POLARITY ACTIVE_LOW" *)
  input presetn, // (required)
  (* X_INTERFACE_INFO = "xilinx.com:signal:interrupt:1.0 irqreq INTERRUPT" *)
  (* X_INTERFACE_PARAMETER = "SENSITIVITY EDGE_RISING" *)
  output irqreq,
  (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 S_APB PADDR" *)
  input [7:0] <paddr>, // Address (required)
  //(* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 <interface_name> PPROT" *)
  //input [2:0] <s_pprot>, // Protection (optional)
  (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 S_APB PSEL" *)
  input <psel>, // Slave Select (required)
  (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 S_APB PENABLE" *)
  input <penable>, // Enable (required)
  (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 S_APB PWRITE" *)
  input <pwrite>, // Write Control (required)
  (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 S_APB PWDATA" *)
  input [7:0] <pwdata>, // Write Data (required)
  //(* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 <interface_name> PSTRB" *)
  //input [3:0] <s_pstrb>, // Write data strobe (optional)
  (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 S_APB PREADY" *)
  output <pready>, // Slave Ready (required)
  (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 S_APB PRDATA" *)
  output [7:0] <prdata>, // Read Data (required)
  (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 S_APB PSLVERR" *)
  output <s_pslverr>, // Slave Error Response (required)
//  additional ports here
  input  rxd,
  output txd
);

//  user logic here

endmodule
			
			