//////////////////////////////////////////////////////////////////////////////////
// Author: Osayamen Aimuyo
// 
// Create Date:    	2/10/2023 
// Module Name:    	PC
// Project Name:		Project 1 - Part 2
//
//////////////////////////////////////////////////////////////////////////////////
module Pipeline_Register 
						#(parameter BUS_WIDTH = 8)
						(
							clk, 
							rst,
							load_enable,							
							in,
							out
						);
			
						input wire clk;
						input wire rst;
						input wire load_enable;
						input wire [BUS_WIDTH - 1:0] in;

						output reg [BUS_WIDTH - 1:0] out;

						always @(posedge clk) begin
						  if(rst) begin
								out  <= {BUS_WIDTH{1'b0}};
						  end
						  else if(load_enable) begin
								out <= in;
						  end
						  else 
								out <= out;
						end

endmodule
