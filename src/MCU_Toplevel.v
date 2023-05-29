//////////////////////////////////////////////////////////////////////////////////
// Author: Osayamen Aimuyo
// 
// Create Date:    	1/25/2023 
// Module Name:    	Top level for the MCU
// Project Name:		Project 1 - Part 1
//
//////////////////////////////////////////////////////////////////////////////////
module MCU_Toplevel(
							clk,
							rst,
							in,
							KB,
							output_LSB,
							output_MSB
						);
			parameter BUS_WIDTH = 8;
			parameter INSTR_BUS_WIDTH = 17;
			
			input wire clk;
			input wire rst;
			input [BUS_WIDTH - 1:0] in;
			input [BUS_WIDTH - 1:0] KB;
			output [BUS_WIDTH - 1:0] output_LSB;
			output [BUS_WIDTH - 1:0] output_MSB;	
			
			wire MW;
			wire [BUS_WIDTH - 1:0] pc;
			wire [BUS_WIDTH - 1:0] dmAddr;
			wire [BUS_WIDTH - 1:0] dmIn;
			wire [BUS_WIDTH - 1:0] dataMemOut;
			wire [INSTR_BUS_WIDTH - 1:0] pMemOut;
			
			ProgramMemory progMemory(
									.inAddress(pc),
									.outData(pMemOut)
			);
			
			DataMemory dataMemory(
									.inAddress(dmAddr),
									.inData(dmIn),
									.readWriteControl(MW),
									.outData(dataMemOut)
			);
			
			CPU cpu (
					.clk(clk),
					.rst(rst),
					.instr(pMemOut),
					.dataInDM(dataMemOut),
					.mcu_input(in),
					.kb_input(KB),
					.MW_out(MW),
					.pcOut(pc),
					.BUS_A_out(dmAddr),
					.BUS_B_out(dmIn),
					.OUTPUT_MSB(output_MSB),
					.OUTPUT_LSB(output_LSB)
			);
			
endmodule
