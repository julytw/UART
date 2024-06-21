`timescale 1ns / 1ps

module uart_reg_testbench;

	reg         PCLK, PRESETn, PSEL, PENABLE, PWRITE, rxd;
	reg  [31:0] PWDATA, PADDR;
	wire        PREADY, PSLVERR, txd, irqreq;
	wire [31:0] PRDATA;

	
	TOP uut(
		.PCLK(PCLK),
		.PRESETn(PRESETn),
		.PADDR(PADDR),
		.PSEL(PSEL),
		.PENABLE(PENABLE),
		.PWRITE(PWRITE),
		.PWDATA(PWDATA),
		.PREADY(PREADY),
		.PRDATA(PRDATA),
		.PSLVERR(PSLVERR),
		.irqreq(irqreq),
		.rxd(rxd),
		.txd(txd)
		);
	
	initial PCLK = 0;
	always #5 PCLK = ~PCLK;
	
	initial
		begin
			PRESETn = 1;
			#3 PRESETn = 0;
			#3 PRESETn = 1;
		end
		
	initial
		begin
			PSEL = 0; PENABLE = 0; PWRITE = 0; PWDATA = 32'b0; PADDR = 32'b0;
		end
	
	/*write transfer
	initial
		begin
			#15 PSEL = 1; PWRITE = 1; PWDATA = 32'h00aa; PADDR = 32'h0000;
			#10 PENABLE = 1;
			#10 PENABLE = 0;
			#32400 ;
			#10 PSEL = 1; PWRITE = 0; PWDATA = 32'h0055; PADDR = 32'h0000;
			#10 PENABLE = 1;
			#10 PENABLE = 0;
			#32400 ;
			#10 PSEL = 1; PWRITE = 1; PWDATA = 32'h0056; PADDR = 32'h0000;
			#10 PENABLE = 1;
			#10 PENABLE = 0;
			#32400 ;
			#10 PSEL = 0; PWRITE = 1; PWDATA = 32'h0038; PADDR = 32'h0000;
			#10 PENABLE = 1;
			#10 PENABLE = 0;
			#32400 ;
			#10 PSEL = 1; PWRITE = 1; PWDATA = 32'h0039; PADDR = 32'h0000;
			#10 PENABLE = 1;
			#10 PENABLE = 0;
			#32400 ;
			#10 PSEL = 1; PWRITE = 1; PWDATA = 32'h0029; PADDR = 32'h0011;
			#10 PENABLE = 1;
			#10 PENABLE = 0;
			#32400 ;
			#10 PSEL = 1; PWRITE = 1; PWDATA = 32'h0030; PADDR = 32'h0000;
			#10 PENABLE = 1;
			#10 PENABLE = 0;
		end*/
	
	// read transfer
	initial 
		begin
			rxd = 1; //idle 
			#3240 rxd = 0; //start 0000_0011 03
			#3240 rxd = 1; //d0
			#3240 rxd = 1; //d1
			#3240 rxd = 0; //d2
			#3240 rxd = 0; //d3
			#3240 rxd = 0; //d4
			#3240 rxd = 0; //d5
			#3240 rxd = 0; //d6
			#3240 rxd = 0; //d7
			#3240 rxd = 1; //stop
			#15 PSEL = 1; PWRITE = 0; PWDATA = 8'b0; PADDR = 8'h01;
			#10 PENABLE = 1;
			#10 PENABLE = 0;
			#3240 rxd = 1; //idle
			#3240 rxd = 0; //start 0000_0000 00
			#3240 rxd = 0; //d0
			#3240 rxd = 0; //d1
			#3240 rxd = 0; //d2
			#3240 rxd = 0; //d3
			#3240 rxd = 0; //d4
			#3240 rxd = 0; //d5
			#3240 rxd = 0; //d6
			#3240 rxd = 0; //d7
			#3240 rxd = 1; //stop
			#10 PENABLE = 1;
			#10 PENABLE = 0;
			#3240 rxd = 1; //idle
			#3240 rxd = 0; //start 0010_0000 20
			#3240 rxd = 0; //d0
			#3240 rxd = 0; //d1
			#3240 rxd = 0; //d2
			#3240 rxd = 0; //d3
			#3240 rxd = 0; //d4
			#3240 rxd = 1; //d5
			#3240 rxd = 0; //d6
			#3240 rxd = 0; //d7
			#3240 rxd = 1; //stop
			#10 PENABLE = 1;
			#10 PENABLE = 0;
			#3240 rxd = 1; //idle
			#3240 rxd = 0; //start 1010_0000 a0
			#3240 rxd = 0; //d0
			#3240 rxd = 0; //d1
			#3240 rxd = 0; //d2
			#3240 rxd = 0; //d3
			#3240 rxd = 0; //d4
			#3240 rxd = 1; //d5
			#3240 rxd = 0; //d6
			#3240 rxd = 1; //d7
			#3240 rxd = 1; //stop
			#10 PENABLE = 1;
			#10 PENABLE = 0;
			#3240 rxd = 1; //idle
			#3240 rxd = 0; //start 1100_0000 c0
			#3240 rxd = 0; //d0
			#3240 rxd = 0; //d1
			#3240 rxd = 0; //d2
			#3240 rxd = 0; //d3
			#3240 rxd = 0; //d4
			#3240 rxd = 0; //d5
			#3240 rxd = 1; //d6
			#3240 rxd = 1; //d7
			#3240 rxd = 1; //stop
			#10 PENABLE = 1;
			#10 PENABLE = 0;
			#3240 rxd = 1; //idle
			#3240 rxd = 0; //start 1110_0000 e0
			#3240 rxd = 0; //d0
			#3240 rxd = 0; //d1
			#3240 rxd = 0; //d2
			#3240 rxd = 0; //d3
			#3240 rxd = 0; //d4
			#3240 rxd = 1; //d5
			#3240 rxd = 1; //d6
			#3240 rxd = 1; //d7
			#3240 rxd = 1; //stop
			#10 PENABLE = 1;
			#10 PENABLE = 0;
			#3240 rxd = 1; //idle
			#3240 rxd = 0; //start 0000_0001 01
			#3240 rxd = 1; //d0
			#3240 rxd = 0; //d1
			#3240 rxd = 0; //d2
			#3240 rxd = 0; //d3
			#3240 rxd = 0; //d4
			#3240 rxd = 0; //d5
			#3240 rxd = 0; //d6
			#3240 rxd = 0; //d7
			#3240 rxd = 1; //stop
			#10 PENABLE = 1;
			#10 PENABLE = 0;
			#3240 rxd = 1; //idle
			#3240 rxd = 0; //start 0000_1100 0c
			#3240 rxd = 0; //d0
			#3240 rxd = 0; //d1
			#3240 rxd = 1; //d2
			#3240 rxd = 1; //d3
			#3240 rxd = 0; //d4
			#3240 rxd = 0; //d5
			#3240 rxd = 0; //d6
			#3240 rxd = 0; //d7
			#3240 rxd = 1; //stop
			#10 PENABLE = 1;
			#10 PENABLE = 0;
			#3240 rxd = 1; //idle
			#3240 rxd = 0; //start 0000_0010 02
			#3240 rxd = 0; //d0
			#3240 rxd = 1; //d1
			#3240 rxd = 0; //d2
			#3240 rxd = 0; //d3
			#3240 rxd = 0; //d4
			#3240 rxd = 0; //d5
			#3240 rxd = 0; //d6
			#3240 rxd = 0; //d7
			#3240 rxd = 1; //stop
			#10 PENABLE = 1;
			#10 PENABLE = 0;
		end
endmodule