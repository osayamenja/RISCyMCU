//////////////////////////////////////////////////////////////////////////////////
// Author:			Osayamen Aimuyo
 
// Create Date: 	02/07/2023 
// Module Name: 	Decoder
//	Project Name:	Project 1 - Part 2 
//
//////////////////////////////////////////////////////////////////////////////////
module Three_Input_Decoder(
									in, 
									out
								);
								parameter BUS_WIDTH = 8;
								parameter ADDRESS_WIDTH = 3;
								
								input wire[ADDRESS_WIDTH - 1:0] in;
								
								output reg [BUS_WIDTH - 1:0] out;
								
								always@(*) begin
									case(in)
										3'b000: out <= 8'b0000_0000; // to prevent writes to R0;
										3'b001: out <= 8'b0000_0010;
										3'b010: out <= 8'b0000_0100;
										3'b011: out <= 8'b0000_1000;
										3'b100: out <= 8'b0001_0000;
										3'b101: out <= 8'b0010_0000;
										3'b110: out <= 8'b0100_0000;
										3'b111: out <= 8'b1000_0000;
									endcase
								end

endmodule
