// 
// Create Date:    	1/25/2023 
// Module Name:    	Data Memory 
// Project Name:		Project 1 - Part 1
//
//////////////////////////////////////////////////////////////////////////////////
module DataMemory (
							inAddress, 
							inData, 
							readWriteControl, 
							outData
						);
						
						parameter BUS_WIDTH = 8;
						
						// readWriteControl == 1 -> write
						// readWriteControl == 0 -> read
						input wire readWriteControl; 
						
						input wire [BUS_WIDTH - 1:0] inAddress;
						input wire [BUS_WIDTH - 1:0] inData;
						output reg [BUS_WIDTH - 1:0] outData;
						
						reg [BUS_WIDTH - 1:0] dMemory [0:255];
						
						integer i;
						initial begin
							for(i = 0; i < 256; i = i+1) begin
								dMemory[i] <= 8'h00;
							end
						end
						
						always @(*) begin
							if(!readWriteControl) begin
								outData <= dMemory[inAddress[7:0]];
							end
							else if(readWriteControl) begin
								dMemory[inAddress[7:0]] <= inData;
								outData <= outData;
							end
						end
endmodule
