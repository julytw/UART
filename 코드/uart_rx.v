module uart_rx(
	input             clk, reset, enable,
	input             rxd,
	output     [31:0] data_out,
	output reg        load
	);
	
	parameter [3:0] 
		idle	=	4'd0,
		start	=	4'd1, 
		rx0		=	4'd2, 
		rx1		=	4'd3, 
		rx2		=	4'd4, 
		rx3		=	4'd5, 
		rx4		=	4'd6, 
		rx5		=	4'd7, 
		rx6		=	4'd8, 
		rx7		=	4'd9, 
		stop	=	4'd10;
		
	reg       [3:0] next_state, rx_state;
	reg       [7:0] data_out_reg;
	
	
	//state logic
	always@(posedge clk or negedge reset)begin
		if(!reset)
			rx_state <= idle;
		else if(enable)
			rx_state <= next_state;
	end


	//next state logic
	always@(*)begin
		next_state = idle;
		case(rx_state)
			idle :
				if(rxd == 1'b0)
					next_state = start;
				else
					next_state = idle;
			start : next_state = rx0;
			rx0 : next_state = rx1;
			rx1 : next_state = rx2;
			rx2 : next_state = rx3;
			rx3 : next_state = rx4;
			rx4 : next_state = rx5;
			rx5 : next_state = rx6;
			rx6 : next_state = rx7;
			rx7 : next_state = stop;
			stop: next_state = idle;
		endcase
	end
	
	
	//output logic	
	always@(posedge clk or negedge reset)begin 
		if(!reset)begin
			load <= 1'b0;
			data_out_reg <= 8'b0;
		end
		else if(enable)begin
			load <= 1'b0;
			case(rx_state)
				idle : load <= 1'b0;
				start : data_out_reg[0] <= rxd;
				rx0  : data_out_reg[1] <= rxd;
				rx1  : data_out_reg[2] <= rxd;
				rx2  : data_out_reg[3] <= rxd;
				rx3  : data_out_reg[4] <= rxd;
				rx4  : data_out_reg[5] <= rxd;
				rx5  : data_out_reg[6] <= rxd;
				rx6  : data_out_reg[7] <= rxd;
				rx7  : load <= 1'b1;
				stop : load <= 1'b1;
			endcase
		end
	end

		
	assign data_out = {24'b0, data_out_reg};
		
endmodule