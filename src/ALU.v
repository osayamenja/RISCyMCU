//////////////////////////////////////////////////////////////////////////////////
// Author:			Osayamen Aimuyo
 
// Create Date: 	02/05/2023 
// Module Name: 	ALU
//	Project Name:	Project 1 - Part 2 
//
//////////////////////////////////////////////////////////////////////////////////
module ALU(
				FS, 
				SH, 
				A, 
				B, 
				mcu_input,
				kb_input,
				F, 
				N, 
				Z, 
				C, 
				V, 
				D
			);
			
			parameter BUS_WIDTH = 8;
			parameter MSB = BUS_WIDTH - 1;
			
			input wire [MSB:0] A; 
			input wire [MSB:0] B; 
			input wire [MSB:0] mcu_input;
			input wire [MSB:0] kb_input;
			input wire [3:0] FS;
			input wire [2:0] SH;
			
			output reg [MSB: 0] F;
			output reg N; 
			output reg Z; 
			output reg C; 
			output reg V;
			output reg D;
			
			reg [MSB: 0] sum;
			reg [MSB: 0] sub;
			reg c_out;
			
			always @(*) begin
				{c_out, sum} <= A + B;
				
				if(FS == 4'b1110)
					{c_out, sum} <= A + ((~B) + 8'h01);
				
				//test for overflow
				V <= ((A[MSB] && B[MSB]) && (!sum[MSB])) || ((!A[MSB] && !B[MSB]) && (sum[MSB]));
				
				C <= c_out;
				
				case (FS)
					4'b0000: F <= sum;
					4'b0001: F <= sum;
					4'b0010: F <= A | B;
					4'b0011: F <= {BUS_WIDTH{A < B}};
					4'b0100: F <= A;
					4'b0101: F <= kb_input;
					4'b0110: F <= A; 
					4'b0111: F <= A;
					4'b1000: F <= ~A;
					4'b1001: F <= A << SH;
					4'b1010: F <= sum;
					4'b1011: F <= A ^ B;
					4'b1100: F <= mcu_input;
					4'b1101: F <= A;
					4'b1110: F <= sum;
					4'b1111: F <= A & B;
					default: F <= 8'hzz;
				endcase;
				N <= F[MSB];
				
				D <= V ^ N;
				Z <= (F == 8'h00) ? 1'b1 : 1'b0;					
			end
endmodule
