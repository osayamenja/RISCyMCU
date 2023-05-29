//////////////////////////////////////////////////////////////////////////////////
// Author:			Osayamen Aimuyo
 
// Create Date: 	02/07/2023 
// Module Name: 	Mux
//	Project Name:	Project 1 - Part 2 
//
//////////////////////////////////////////////////////////////////////////////////

module Four_Input_mux(in1, in2, in3, in4, select, out);
			parameter BUS_WIDTH = 8;
			parameter LEFTMOST = BUS_WIDTH - 1;
			
			input wire [LEFTMOST: 0] in1, in2, in3, in4;
			input wire [1:0] select;
			output reg[LEFTMOST : 0] out;
			
			always @(*) begin
				case(select)
					2'b00: out <= in1;
					2'b01: out <= in2;
					2'b10: out <= in3;
					2'b11: out <= in4;
				endcase
			end

endmodule
