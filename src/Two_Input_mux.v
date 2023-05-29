//////////////////////////////////////////////////////////////////////////////////
// Author:			Osayamen Aimuyo
 
// Create Date: 	02/07/2023 
// Module Name: 	Mux
//	Project Name:	Project 1 - Part 2 
//
//////////////////////////////////////////////////////////////////////////////////
module Two_Input_mux(
							in1, 
							in2, 
							select, 
							out
						);
						parameter BUS_WIDTH = 8;
						parameter MSB = BUS_WIDTH - 1;
						
						input wire [MSB: 0] in1; 
						input wire [MSB: 0] in2;
						input wire select;
						output reg [MSB : 0] out;
						
						always @(*) begin
							out <= (select)? in2 : in1;
						end

endmodule
