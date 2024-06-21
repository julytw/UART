module uart_tx(
	input        clk, reset, load, enable,
	input [31:0] data_in,
	output reg   txd,
	output reg   comp
	);
	
	parameter [3:0] 
			idle	=	4'd0, 
			start	=	4'd1, 
			tx0		=	4'd2, 
			tx1		=	4'd3, 
			tx2 	=	4'd4, 
			tx3		= 	4'd5, 
			tx4		= 	4'd6, 
			tx5		= 	4'd7, 
			tx6		= 	4'd8, 
			tx7		= 	4'd9, 
			stop 	= 	4'd10;
			
	reg       [3:0] next_state, tx_state;
	reg       [7:0] data_reg;
	
	
	always@(posedge clk or negedge reset)begin
		if(!reset)
			tx_state <= idle;
		else if(enable)
			tx_state <= next_state;
	end
	
	
	//next state logic
	always@(*)begin
		next_state = idle;
		case(tx_state)
			idle :
				if(load)
					next_state = start;
				else
					next_state = idle;
			start : next_state = tx0;
			tx0 : next_state = tx1;
			tx1 : next_state = tx2;
			tx2 : next_state = tx3;
			tx3 : next_state = tx4;
			tx4 : next_state = tx5;
			tx5 : next_state = tx6;
			tx6 : next_state = tx7;
			tx7 : next_state = stop;
			stop: next_state = idle;
		endcase
	end
	
	
	//output logic	
	always@(posedge clk or negedge reset)begin
		if(!reset)begin
			txd <= 1'b1;
			data_reg <= 8'b0;
			comp <= 1'b0;
		end
		else if(enable)begin
			case(tx_state)
				idle : 
					begin
						txd <= 1'b1;
						comp <= 1'b0;
						if(load)
							data_reg <= data_in[7:0];
					end
				start : txd <= 1'b0;
				tx0  : txd <= data_reg[0];
				tx1  : txd <= data_reg[1];
				tx2  : txd <= data_reg[2];
				tx3  : txd <= data_reg[3];
				tx4  : txd <= data_reg[4];
				tx5  : txd <= data_reg[5];
				tx6  : txd <= data_reg[6];
				tx7  : txd <= data_reg[7];
				stop : 
					begin
						txd <= 1'b1;
						comp <= 1'b1;
					end
				default : 
					begin
						txd <= 1'b1;
						comp <= 1'b0;
					end
			endcase
		end
	end
	/*always@(*)
		begin
			case(tx_state)
				idle :
					begin
						txd <= 1'b1;
						if(load)
							begin
								next_state <= start;
								data_reg <= data_in;
							end
						else
							next_state <= idle;
					end
				start : 
					begin
						next_state <= tx0;
						txd <= 1'b0;
					end
				tx0 :
					begin
						next_state <= tx1;
						txd <= data_reg[0];
					end
				tx1 :
					begin
						next_state <= tx2;
						txd <= data_reg[1];
					end
				tx2 :
					begin
						next_state <= tx3;
						txd <= data_reg[2];
					end
				tx3 :
					begin
						next_state <= tx4;
						txd <= data_reg[3];
					end
				tx4 :
					begin
						next_state <= tx5;
						txd <= data_reg[4];
					end
				tx5 :
					begin
						next_state <= tx6;
						txd <= data_reg[5];
					end
				tx6 :
					begin
						next_state <= tx7;
						txd <= data_reg[6];
					end
				tx7 :
					begin
						next_state <= stop;
						txd <= data_reg[7];
					end
				stop :
					begin
						next_state <= idle;
						txd <= 1'b1;
					end
				default :
					begin
						next_state <= idle;
						txd <= 1'b1;
						data_reg <= data_reg;
					end
			endcase
		end*/
		
endmodule