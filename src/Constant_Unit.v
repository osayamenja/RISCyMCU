//////////////////////////////////////////////////////////////////////////////////
// Author:			Osayamen Aimuyo
 
// Create Date: 	02/09/2023 
// Module Name: 	Constant Unit
//	Project Name:	Project 1 - Part 2 
//////////////////////////////////////////////////////////////////////////////////

module Constant_Unit #(
								parameter OUT_BUS_WIDTH = 8,
								parameter IN_BUS_WIDTH = 6,
								parameter EXT_WIDTH = OUT_BUS_WIDTH - IN_BUS_WIDTH
							)
							(
								in, 
								CS, 
								out
							);
							
							input wire [IN_BUS_WIDTH - 1:0] in;
							input wire CS;
							output wire [OUT_BUS_WIDTH - 1:0] out;
							 
							assign out = {{EXT_WIDTH{(in[IN_BUS_WIDTH - 1] & CS)}}, in[IN_BUS_WIDTH - 1:0]};

endmodule
