//////////////////////////////////////////////////////////////////////////////////
// Author: Osayamen Aimuyo
// 
// Create Date:    	1/25/2023 
// Module Name:    	Test bench for the MCU
// Project Name:		Project 1 - Part 1
//
//////////////////////////////////////////////////////////////////////////////////
module MCU_testBench();
							reg clk;
							reg rst;
							reg [7:0] in, KB;
							wire [7:0] output_msb;
							wire [7:0] output_lsb;
							
							MCU_Toplevel MCU(
											.clk(clk),
											.rst(rst),
											.in(in),
											.KB(KB),
											.output_LSB(output_lsb),
											.output_MSB(output_msb)
							);
							
							always 
								#5 clk <= ~clk;
								
							initial begin
								$dumpfile("MCU_TopLevel.vcd");
								$dumpvars(0, MCU_testBench);
								
								clk <= 1'b0;
								rst <= 1'b1;
								#10 rst <= 1'b0; 

								// instructions execute during this time.

								#150 $finish;
								
							end

endmodule
