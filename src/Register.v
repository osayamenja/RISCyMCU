//////////////////////////////////////////////////////////////////////////////////
// Author:			Osayamen Aimuyo
 
// Create Date: 	02/07/2023 
// Module Name: 	Register
//	Project Name:	Project 1 - Part 2 
//
//////////////////////////////////////////////////////////////////////////////////
module Register(
						clk, 
						rst, 
						write_control, 
						active_enable, 
						in_data, 
						out_data
					);
			
					parameter BUS_WIDTH = 8;
					
					input wire clk;
					input wire rst;
					input wire write_control;
					input wire active_enable;
					input wire [BUS_WIDTH - 1:0] in_data;
					output reg [BUS_WIDTH - 1:0] out_data;
					
					wire should_write;
					
					assign should_write = active_enable & write_control;
					
					always@(negedge clk) begin
						if(rst) begin
							out_data <= 8'h00;
						end
						else if(should_write) begin
							out_data <= in_data;
						end
						else begin
							out_data <= out_data;
						end
					end
endmodule
