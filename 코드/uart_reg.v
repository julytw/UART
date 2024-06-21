module uart_reg(
	input         pclk,    // APB clock
	input         presetn, // APB reset
	input         psel,    // APB sel
	input         penable, // APB enable
	input         pwrite,  // APB write
	input  [31:0] pwdata,  // APB write data
	input  [31:0] paddr,   // APB data
	input         rx_load, // UART RX load
	input  [31:0] rx_data, // UART RX data 
	input         tx_comp, // UART TX complete
	output [31:0] prdata,  // APB read data
	output [31:0] tx_data, // UART TX data
	output        tx_load, // UART TX load
	output        pready,  // APB ready
	output        irqreq,  // APB interrupt
	output        pslverr,  // APB pslverr
	output [11:0] ubrr_out
	);
	
	// register
	reg [31:0] tx_data_reg;
	reg [31:0] rx_data_reg;
	reg [31:0] control_reg;
	reg [31:0] status_reg;
	reg [31:0] ubrr_reg;
	
	//wire
	wire wirte_tx;
	wire write_control;
	wire write_status;
	wire read_rx;
	
	// address define
	parameter ADDR_TXB = 8'h00;
	parameter ADDR_RXB = 8'h04;
	parameter ADDR_CONTROL = 8'h08;
	parameter ADDR_STATUS = 8'h0C;
	parameter ADDR_UBRR = 8'h10;
	
	// transfer assign
	assign write_tx			=		penable & psel & pwrite & (paddr[7:0] == ADDR_TXB);
	assign write_control	=		penable & psel & pwrite & (paddr[7:0] == ADDR_CONTROL);
	assign write_status		=		penable & psel & pwrite & (paddr[7:0] == ADDR_STATUS);
	assign write_ubrr		=		penable & psel & pwrite & (paddr[7:0] == ADDR_UBRR);
	assign read_rx			=		penable & psel & !pwrite & (paddr[7:0] == ADDR_RXB);
	

	// write tx register
	always@(posedge pclk or negedge presetn)begin
		if(!presetn)
			tx_data_reg <= 32'b0;
		else if(write_tx)
			tx_data_reg <= pwdata;
		/*else if(tx_comp)
			tx_data_reg <= 32'b0;*/
	end
		
	assign tx_data = (tx_load) ? tx_data_reg : 32'b0;
		
	// write control register
	always@(posedge pclk or negedge presetn)begin
		if(!presetn)
			control_reg <= 32'b0;
		else if(write_control)
			control_reg <= pwdata;
		else if(tx_comp)
			control_reg[0] <= 1'b0;
	end
	
	// write status register
	always@(posedge pclk or negedge presetn)begin
		if(!presetn)
			status_reg <= {24'b0, 4'b0001, 1'b0, 1'b1, 1'b0, 1'b0};
		else if(write_status)
			status_reg <= pwdata;
		else if(rx_load)
			status_reg[0] <= 1'b1;   // RXC
		else if(read_rx)
			status_reg[0] <= 1'b0;
		else if(write_tx)begin
			status_reg[2] <= 1'b0;   // UDRE
			status_reg[3] <= 1'b1;   // tx_load
			end
		else if(tx_comp)begin
			status_reg[1] <= 1'b1;   // TXC
			status_reg[2] <= 1'b1;   // UDRE
			status_reg[3] <= 1'b0;   // tx_load
			end
		else
			status_reg <= {status_reg[31:4], status_reg[3], 1'b1, 1'b0, status_reg[0]};
	end
	
	assign tx_load = status_reg[3];
	
	
	//write ubrr register
	always@(posedge pclk or negedge presetn)begin
		if(!presetn)
			ubrr_reg <= {24'b0, 8'b0100_0100};
		else if(write_ubrr)
			ubrr_reg <= pwdata;
	end
	
	assign ubrr_out = {status_reg[7:4], ubrr_reg[7:0]};
	
	
	// read rx register
	always@(posedge pclk or negedge presetn)begin
		if(!presetn)
			rx_data_reg <= 32'b0;
		else if(rx_load)
			rx_data_reg <= rx_data;
		else if(read_rx)
			rx_data_reg <= 32'b0;
	end
	
	//read transfer
	reg [31:0] pre_data;
	
	always@(*)begin
		pre_data = 32'b0;
		case(paddr[7:0])
			ADDR_TXB : pre_data = tx_data_reg; 
			ADDR_RXB : pre_data = rx_data_reg;
			ADDR_CONTROL : pre_data = control_reg;
			ADDR_STATUS  : pre_data = status_reg;
		endcase
	end
		
	assign prdata = pre_data; 
	
	assign irqreq = (control_reg[3] && status_reg[0]) ? 1'b1 : 1'b0;
	//assign pready = status_reg[2];
	assign pslverr = 1'b0; 
	
	/*
	assign prdata = (paddr[7:0] == ADDR_TXB) ? tx_data_reg :
					(paddr[7:0] == ADDR_RXB) ? rx_data_reg :
					(paddr[7:0] == ADDR_CONTROL) ? control_reg :
					(paddr[7:0] == ADDR_STATUS) ? status_reg : 32'b0;
					
	assign irqreq = 1'b0;*/
	assign pready = 1'b1;
	assign pslverr = 1'b0;
	
endmodule