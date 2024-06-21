`timescale 1ns / 1ps

module uart_testbench;

    // Testbench Signals
    reg clk;
    reg reset;
    reg pc_data;
    wire otx;

    // Instance of uart module
    uart uut(
        .clk(clk),
        .reset(reset),
        .pc_data(pc_data),
        .otx(otx)
    );

    // Clock generation (100MHz)
    initial clk = 0;
    always #5 clk = ~clk; // 10ns period -> 100MHz

    // Generate a slow clock for baud rate of 9600 using clock_divider with ubrr toggling at 325
    initial begin
		reset = 1;
		#3 reset = 0;
		#3 reset = 1;
	end
	initial begin
		pc_data = 1; //idle 
		#6500 pc_data = 0; //start 0000_0011
        #6500 pc_data = 1; //d0
		#6500 pc_data = 1; //d1
		#6500 pc_data = 0; //d2
		#6500 pc_data = 0; //d3
		#6500 pc_data = 0; //d4
		#6500 pc_data = 0; //d5
		#6500 pc_data = 0; //d6
		#6500 pc_data = 0; //d7
		#6500 pc_data = 1; //stop
		#6500 pc_data = 1; //idle
		#6500 pc_data = 0; //start 0000_0000
        #6500 pc_data = 0; //d0
		#6500 pc_data = 0; //d1
		#6500 pc_data = 0; //d2
		#6500 pc_data = 0; //d3
		#6500 pc_data = 0; //d4
		#6500 pc_data = 0; //d5
		#6500 pc_data = 0; //d6
		#6500 pc_data = 0; //d7
		#6500 pc_data = 1; //stop
		#6500 pc_data = 1; //idle
		#6500 pc_data = 0; //start 0010_0000
        #6500 pc_data = 0; //d0
		#6500 pc_data = 0; //d1
		#6500 pc_data = 0; //d2
		#6500 pc_data = 0; //d3
		#6500 pc_data = 0; //d4
		#6500 pc_data = 1; //d5
		#6500 pc_data = 0; //d6
		#6500 pc_data = 0; //d7
		#6500 pc_data = 1; //stop
		#6500 pc_data = 1; //idle
		#6500 pc_data = 0; //start 1010_0000
        #6500 pc_data = 0; //d0
		#6500 pc_data = 0; //d1
		#6500 pc_data = 0; //d2
		#6500 pc_data = 0; //d3
		#6500 pc_data = 0; //d4
		#6500 pc_data = 1; //d5
		#6500 pc_data = 0; //d6
		#6500 pc_data = 1; //d7
		#6500 pc_data = 1; //stop
		#6500 pc_data = 1; //idle
		#6500 pc_data = 0; //start 1100_0000
        #6500 pc_data = 0; //d0
		#6500 pc_data = 0; //d1
		#6500 pc_data = 0; //d2
		#6500 pc_data = 0; //d3
		#6500 pc_data = 0; //d4
		#6500 pc_data = 0; //d5
		#6500 pc_data = 1; //d6
		#6500 pc_data = 1; //d7
		#6500 pc_data = 1; //stop
		#6500 pc_data = 1; //idle
		#6500 pc_data = 0; //start 1110_0000
        #6500 pc_data = 0; //d0
		#6500 pc_data = 0; //d1
		#6500 pc_data = 0; //d2
		#6500 pc_data = 0; //d3
		#6500 pc_data = 0; //d4
		#6500 pc_data = 1; //d5
		#6500 pc_data = 1; //d6
		#6500 pc_data = 1; //d7
		#6500 pc_data = 1; //stop
		#6500 pc_data = 1; //idle
		#6500 pc_data = 0; //start 0000_0001
        #6500 pc_data = 1; //d0
		#6500 pc_data = 0; //d1
		#6500 pc_data = 0; //d2
		#6500 pc_data = 0; //d3
		#6500 pc_data = 0; //d4
		#6500 pc_data = 0; //d5
		#6500 pc_data = 0; //d6
		#6500 pc_data = 0; //d7
		#6500 pc_data = 1; //stop
		#6500 pc_data = 1; //idle
		#6500 pc_data = 0; //start 0000_1100
        #6500 pc_data = 0; //d0
		#6500 pc_data = 0; //d1
		#6500 pc_data = 1; //d2
		#6500 pc_data = 1; //d3
		#6500 pc_data = 0; //d4
		#6500 pc_data = 0; //d5
		#6500 pc_data = 0; //d6
		#6500 pc_data = 0; //d7
		#6500 pc_data = 1; //stop
		#6500 pc_data = 1; //idle
		#6500 pc_data = 0; //start 0000_0010
        #6500 pc_data = 0; //d0
		#6500 pc_data = 1; //d1
		#6500 pc_data = 0; //d2
		#6500 pc_data = 0; //d3
		#6500 pc_data = 0; //d4
		#6500 pc_data = 0; //d5
		#6500 pc_data = 0; //d6
		#6500 pc_data = 0; //d7
		#6500 pc_data = 1; //stop
		
    end

endmodule