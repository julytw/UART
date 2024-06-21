module uart_rx(
	input            clk, reset,
	input            irx,
	output reg [7:0] data_out,
	output reg       load
	);
	
	parameter [3:0] idle = 4'd0, start = 4'd1, rx0 = 4'd2, rx1 = 4'd3, rx2 = 4'd4, rx3 = 4'd5, rx4 = 4'd6, rx5 = 4'd7, rx6 = 4'd8, rx7 = 4'd9, stop = 4'd10;
	reg       [3:0] next_state, rx_state;
	reg             irx_sync_1, irx_sync_2; // 동기화 플립플롭
	
	
	always@(posedge clk or negedge reset) 
		begin
			if (!reset) begin
				irx_sync_1 <= 1'b1;
				irx_sync_2 <= 1'b1;
			end else begin
				irx_sync_1 <= irx; // 첫 번째 단계 동기화
				irx_sync_2 <= irx_sync_1; // 두 번째 단계 동기화
			end
		end

	
	always@(posedge clk or negedge reset)
		begin
			if(!reset)
				rx_state <= idle;
			else
				rx_state <= next_state;
		end

	always@(*)
		begin
			case(rx_state)
				idle :
					begin
						load <= 1'b0;
						if (irx_sync_2 == 1'b0) // 동기화된 신호 사용
							next_state <= start;
						else
							next_state <= idle;
					end
				start : 
						next_state <= rx0;
				rx0 :
					begin
						next_state <= rx1;
						data_out[0] <= irx;
					end
				rx1 :
					begin
						next_state <= rx2;
						data_out[1] <= irx;
					end
				rx2 :
					begin
						next_state <= rx3;
						data_out[2] <= irx;
					end
				rx3 :
					begin
						next_state <= rx4;
						data_out[3] <= irx;
					end
				rx4 :
					begin
						next_state <= rx5;
						data_out[4] <= irx;
					end
				rx5 :
					begin
						next_state <= rx6;
						data_out[5] <= irx;
					end
				rx6 :
					begin
						next_state <= rx7;
						data_out[6] <= irx;
					end
				rx7 :
					begin
						next_state <= stop;
						data_out[7] <= irx_sync_2;
					end
				stop :
					begin
						if (irx_sync_2 == 1'b1)
							load <= 1'b1; // 유효한 스탑 비트
						else
							load <= 1'b0; // 오류 처리를 위한 확장이 필요
						next_state <= idle;
					end
				default :
					begin
						next_state <= idle;
						load <= 1'b0;
					end
			endcase
		end
		
endmodule