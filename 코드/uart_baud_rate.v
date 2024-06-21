module uart_baud_rate(
	input        clk, reset,
	input [11:0] ubrr_in,
	output       tick
	);
	
	reg [11:0]	ubrr;
	reg	[3:0]	count;
	wire		count_comp;
	
	always@(posedge clk or negedge reset)begin
		if(!reset)
			count <= 4'b0;
		else if(count == 4'd15)
			count <= 4'b0;
		else
			count <= count + 1'b1;
	end
	
	assign count_comp = (count == 4'd15) ? 1'b1 : 1'b0;
	
	
	always@(posedge clk or negedge reset)begin
		if(!reset)
			ubrr <= 12'b0;
		else if(ubrr == ubrr_in)
			ubrr <= 12'b0;
		else if(count_comp)
			ubrr <= ubrr + 1'b1;
	end
	
	assign tick = (ubrr == ubrr_in) ? 1'b1 : 1'b0;
	
endmodule