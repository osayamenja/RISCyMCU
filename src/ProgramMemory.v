//////////////////////////////////////////////////////////////////////////////////
// Author: Osayamen Aimuyo
// 
// Create Date:    	1/25/2023 
// Module Name:    	Program Memory 
// Project Name:		Project 1 - Part 1
//
//////////////////////////////////////////////////////////////////////////////////
module ProgramMemory #(parameter IN_BUS_WIDTH = 8, parameter OUT_BUS_WIDTH = 17)
							(
								inAddress, 
								outData
							);
							
							input wire [IN_BUS_WIDTH - 1:0] inAddress;
							
							output reg [OUT_BUS_WIDTH - 1:0] outData; 
							
							reg [OUT_BUS_WIDTH - 1:0] pMemory [0:255];
							
							integer i;
							initial begin
								for(i = 0; i < 256; i = i+1) begin
									pMemory[i] <= 17'b0000_0000_0000_00000;
								end

								//pMemory[0] <= 17'b10001_001_000_011110; // add $R2, $R0, 30
                                				//pMemory[1] <= 17'b0000_0000_0000_00000; // exit
							end
							
							always @(*) begin
								outData <= pMemory[inAddress];
							end

endmodule
