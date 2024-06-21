module clock_divider(
	input        clk, reset,
	output reg   m_clk = 1'b0
	);
	reg   [9:0] ubrr;
	
	always@(posedge clk or negedge reset)
		begin
			if(!reset)
				begin
					m_clk <= 1'b1;
					ubrr <= 10'b0;
				end
			else
				begin
					if(ubrr == 10'd318)
						begin
							ubrr <= 10'b0;
							m_clk <= ~m_clk;
						end
					else
						ubrr <= ubrr + 1'b1;
				end
		end

endmodule