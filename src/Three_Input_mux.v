//////////////////////////////////////////////////////////////////////////////////
// Author:			Osayamen Aimuyo
 
// Create Date: 	02/08/2023 
// Module Name: 	Mux
//	Project Name:	Project 1 - Part 2 
//
//////////////////////////////////////////////////////////////////////////////////

module Three_Input_mux(
								in1, 
								in2, 
								in3, 
								select, 
								out
							);
							parameter BUS_WIDTH = 8;
							parameter MSB = BUS_WIDTH - 1;
							
							input wire [MSB: 0] in1; 
							input wire [MSB: 0] in2; 
							input wire [MSB: 0] in3;
							input wire [1:0] select;
							output reg [MSB : 0] out;
							
							always @(*) begin
								case(select)
									2'b00: out <= in1;
									2'b01: out <= in2;
									2'b10: out <= in3;
									default: out <= out;
								endcase
							end

endmodule
