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
							
							MCU_Toplevel MCU(
											.clk(clk),
											.rst(rst)
							);
							
							always 
								#5 clk <= ~clk;
								
							initial begin
								clk <= 1'b0;
								rst <= 1'b1;
								#10 rst <= 1'b0; 

								// instructions execute during this time.

								#150 $finish;
								
							end

endmodule
