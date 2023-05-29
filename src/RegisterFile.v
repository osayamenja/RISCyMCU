//////////////////////////////////////////////////////////////////////////////////
// Author:			Osayamen Aimuyo
 
// Create Date: 	02/07/2023 
// Module Name: 	RegisterFile
//	Project Name:	Project 1 - Part 2 
//
//////////////////////////////////////////////////////////////////////////////////
module RegisterFile(
							clk, 
							rst, 
							addrA, 
							addrB, 
							write_addr, 
							data_in, 
							write_enable, 
							Data_A, 
							Data_B
						);
						
						parameter ADDRESS_WIDTH = 3;
						parameter BUS_WIDTH = 8;
						
						input wire clk;
						input wire rst;
						input wire write_enable;
						input wire [ADDRESS_WIDTH - 1:0] addrA; 
						input wire [ADDRESS_WIDTH - 1:0] addrB; 
						input wire [ADDRESS_WIDTH - 1:0] write_addr;
						input wire [BUS_WIDTH - 1:0] data_in;
						
						output wire [BUS_WIDTH - 1:0] Data_A; 
						output wire [BUS_WIDTH - 1:0] Data_B;
						
						wire [BUS_WIDTH - 1:0] registerFile [0: BUS_WIDTH - 1];
						wire [BUS_WIDTH - 1:0] register_enable;
						
						Three_Input_Decoder decoder(
												.in(write_addr),
												.out(register_enable)
						);
						
						generate
							genvar i;
							for(i = 0; i < BUS_WIDTH; i = i + 1) begin : generate_Registers
								Register r(
										.clk(clk),
										.rst(rst),
										.write_control(write_enable),
										.active_enable(register_enable[i]),
										.in_data(data_in),
										.out_data(registerFile[i])
								);
							end
						endgenerate
						
						assign Data_A = registerFile[addrA];
						assign Data_B = registerFile[addrB];
			
endmodule
