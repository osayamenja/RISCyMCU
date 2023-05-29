//////////////////////////////////////////////////////////////////////////////////
// Author: Osayamen Aimuyo
// 
// Create Date:    	2/10/2023 
// Module Name:    	CPU_Toplevel
// Project Name:		Project 1 - Part 3
//////////////////////////////////////////////////////////////////////////////////
module InstructionDecoder(
									opcode,
									FS,
									RW,
									MD,
									BS,
									PS,
									MW,
									MB,
									MA,
									CS,
									OE
								);

								input wire [4:0] opcode;
								
								output reg [3:0] FS;
								output reg [1:0] MD;
								output reg [1:0] BS;
								output reg RW;
								output reg PS;
								output reg MW;
								output reg MB;
								output reg MA;
								output reg CS;
								output reg OE;
								
								always @(*) begin
									case(opcode)
										5'b00000: {FS, MD, BS, RW, PS, MW, MB, MA, CS, OE} <= {4'bz, 2'bzz, 2'b00, 7'bzzzzzzz};
										5'b00001: {FS, MD, BS, RW, PS, MW, MB, MA, CS, OE} <= {4'bz, 2'bzz, 2'b00, 7'b0z100z0}; // store
										5'b00010: {FS, MD, BS, RW, PS, MW, MB, MA, CS, OE} <= {4'bz, 2'bzz, 2'b11, 7'b0z01z10}; // jump
										5'b00011: {FS, MD, BS, RW, PS, MW, MB, MA, CS, OE} <= {4'bz, 2'b00, 2'b00, 7'b0z00001}; // output
										5'b00100: {FS, MD, BS, RW, PS, MW, MB, MA, CS, OE} <= {4'bz, 2'bzz, 2'b10, 7'b0z0z0z0}; // jmr
										5'b00101: {FS, MD, BS, RW, PS, MW, MB, MA, CS, OE} <= {4'bz, 2'b01, 2'b00, 7'b1z0z0z0}; // load
										
										//ALU operations
										5'b10000: {FS, MD, BS, RW, PS, MW, MB, MA, CS, OE} <= {opcode[3:0], 2'b00, 2'b00, 7'b1z000z0};// add
										5'b10001: {FS, MD, BS, RW, PS, MW, MB, MA, CS, OE} <= {opcode[3:0], 2'b00, 2'b00, 7'b1z01010}; //addi
										5'b10010: {FS, MD, BS, RW, PS, MW, MB, MA, CS, OE} <= {opcode[3:0], 2'b00, 2'b00, 7'b1z000z0}; // OR
										5'b10011: {FS, MD, BS, RW, PS, MW, MB, MA, CS, OE} <= {opcode[3:0], 2'b00, 2'b00, 7'b1z000z0}; // slt
										5'b10100: {FS, MD, BS, RW, PS, MW, MB, MA, CS, OE} <= {opcode[3:0], 2'b00, 2'b00, 7'b1z0z0z0}; // MoveA
										5'b10101: {FS, MD, BS, RW, PS, MW, MB, MA, CS, OE} <= {opcode[3:0], 2'b00, 2'b00, 7'b1z00000}; // INK
										5'b10110: {FS, MD, BS, RW, PS, MW, MB, MA, CS, OE} <= {opcode[3:0], 2'b00, 2'b00, 7'b0001010}; // BZ
										5'b10111: {FS, MD, BS, RW, PS, MW, MB, MA, CS, OE} <= {opcode[3:0], 2'bzz, 2'b01, 7'b0101010}; // BNZ
										5'b11000: {FS, MD, BS, RW, PS, MW, MB, MA, CS, OE} <= {opcode[3:0], 2'b00, 2'b00, 7'b1z0z0z0}; // CMP
										5'b11001: {FS, MD, BS, RW, PS, MW, MB, MA, CS, OE} <= {opcode[3:0], 2'b00, 2'b00, 7'b1z0z0z0}; // LSL
										5'b11010: {FS, MD, BS, RW, PS, MW, MB, MA, CS, OE} <= {opcode[3:0], 2'b00, 2'b00, 7'b1z01000}; // AIU
										5'b11011: {FS, MD, BS, RW, PS, MW, MB, MA, CS, OE} <= {opcode[3:0], 2'b00, 2'b00, 7'b1z01000}; // XRI
										5'b11100: {FS, MD, BS, RW, PS, MW, MB, MA, CS, OE} <= {opcode[3:0], 2'b00, 2'b00, 7'b1z00000}; // input
										5'b11101: {FS, MD, BS, RW, PS, MW, MB, MA, CS, OE} <= {opcode[3:0], 2'b00, 2'b11, 7'b1z01110}; // JML
										5'b11110: {FS, MD, BS, RW, PS, MW, MB, MA, CS, OE} <= {opcode[3:0], 2'b00, 2'b00, 7'b1z01000}; // SIU
										5'b11111: {FS, MD, BS, RW, PS, MW, MB, MA, CS, OE} <= {opcode[3:0], 2'b00, 2'b00, 7'b1z01000}; // ANI
										
										default: {FS, MD, BS, RW, PS, MW, MB, MA, CS, OE} <= {4'hz, 2'bzz, 2'b00, 7'bzzzzzzz};
									endcase
								end
endmodule
