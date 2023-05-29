//////////////////////////////////////////////////////////////////////////////////
// Author: Osayamen Aimuyo
// 
// Create Date:    	2/10/2023 
// Module Name:    	CPU_Toplevel
// Project Name:		Project 1 - Part 2
//
//////////////////////////////////////////////////////////////////////////////////
module CPU(
				clk,
				rst,
				instr,
				dataInDM,
				mcu_input,
				kb_input,
				MW_out,
				pcOut,
				BUS_A_out,
				BUS_B_out,
				OUTPUT_MSB,
				OUTPUT_LSB
			);
			
			parameter INSTR_BUS_WIDTH = 17; //instruction length excluding opcode.
			parameter BUS_WIDTH = 8;
			parameter EX_REG_BUS_WIDTH = 18;
			parameter WB_REG_BUS_WIDTH = 6;
			parameter D_BIT_BUS_WIDTH = 1;
			
			
			input wire clk;
			input wire rst;
			input wire [INSTR_BUS_WIDTH - 1:0] instr;
			input wire [BUS_WIDTH - 1:0] dataInDM;
			input wire [BUS_WIDTH - 1:0] mcu_input;
			input wire [BUS_WIDTH - 1:0] kb_input;
			output MW_out;
			output [BUS_WIDTH - 1:0] pcOut;
			output [BUS_WIDTH - 1:0] BUS_A_out;
			output [BUS_WIDTH - 1:0] BUS_B_out;
			output [BUS_WIDTH - 1:0] OUTPUT_MSB;
			output [BUS_WIDTH - 1:0] OUTPUT_LSB;
			
			wire [BUS_WIDTH - 1:0] muxAOut;
			wire [BUS_WIDTH - 1:0] muxBOut;
			wire [BUS_WIDTH - 1:0] muxCOut;
			reg [BUS_WIDTH - 1:0] pcIn;
			wire [BUS_WIDTH - 1:0] pcNext;
			reg [BUS_WIDTH - 1:0] pc_1In;
			wire [BUS_WIDTH - 1:0] pc_1Out;
			reg [BUS_WIDTH - 1:0] pc_2In;
			wire [BUS_WIDTH - 1:0] pc_2Out;
			wire [BUS_WIDTH - 1:0] aluOut;
			wire [BUS_WIDTH - 1:0] cuOut;
			wire [BUS_WIDTH - 1:0] muxDOut;
			wire [BUS_WIDTH - 1:0] regAOut;
			wire [BUS_WIDTH - 1:0] regBOut;
			wire [EX_REG_BUS_WIDTH - 1:0] EX_out;
			wire [WB_REG_BUS_WIDTH - 1:0] WB_out;
			wire D_out;
			wire [BUS_WIDTH - 1:0] F_Result_out;
			wire [BUS_WIDTH - 1:0] DATA_MEM_out;
			wire [BUS_WIDTH - 1:0] BrA;
			wire [BUS_WIDTH - 1:0] RAA;
			
			wire [3:0] FS;
			wire [2:0] DA;
			wire [2:0] DA_next;
			reg [2:0] DA_in;
			wire [1:0] MD;
			wire [1:0] MC;
			wire [1:0] BS;
			wire [1:0] BS_next;
			reg [1:0] BS_in;
			wire [1:0] BS_EX;
			wire MW;
			reg MW_in;
			wire MW_next;
			wire DHS;
			wire PS;
			wire OE;
			wire MB;
			wire MA;
			wire RW;
			wire RW_next;
			reg RW_in;
			wire CS;
			wire N;
			wire Z;
			wire C;
			wire V;
			wire D;
			wire Br_Detect;
			reg[INSTR_BUS_WIDTH - 1:0]IR_In;
			wire [INSTR_BUS_WIDTH - 1:0] IR_next;
			wire [INSTR_BUS_WIDTH - 1:0]IR_Out;
			
			Four_Input_mux muxC(
								.in1(pcNext),
								.in2(BrA),
								.in3(RAA),
								.in4(BrA),
								.select(MC),
								.out(muxCOut)
			);
			
			Pipeline_Register PC(
									.clk(clk),
									.rst(rst),
									.load_enable(DHS),
									.in(pcIn),
									.out(pcOut)
			);
			
			Pipeline_Register PC_1(
									.clk(clk),
									.rst(rst),
									.load_enable(DHS),
									.in(pc_1In),
									.out(pc_1Out)
			);
			
			Pipeline_Register PC_2(
									.clk(clk),
									.rst(rst),
									.load_enable(DHS),
									.in(pc_2In),
									.out(pc_2Out)
			);
			
			Pipeline_Register #(.BUS_WIDTH(INSTR_BUS_WIDTH))
										IR(
											.clk(clk),
											.rst(rst),
											.load_enable(DHS),
											.in(IR_In),
											.out(IR_Out)
										);
			
			ALU alu(
					.FS(EX_out[7:4]),
					.SH(EX_out[3:1]),
					.A(BUS_A_out),
					.B(BUS_B_out),
					.mcu_input(mcu_input),
					.kb_input(kb_input),
					.F(aluOut),
					.N(N),
					.Z(Z),
					.C(C),
					.V(V),
					.D(D)
			);
			
			RegisterFile rFile(
								.clk(clk),
								.rst(rst),
								.addrA(IR_Out[8:6]),
								.addrB(IR_Out[5:3]),
								.write_addr(WB_out[4:2]),
								.data_in(muxDOut),
								.write_enable(WB_out[5]),
								.Data_A(regAOut),
								.Data_B(regBOut)
			);
			
			Three_Input_mux muxD(
								.in1(F_Result_out),
								.in2(DATA_MEM_out),
								.in3({8{D_out}}),
								.select(WB_out[1:0]),
								.out(muxDOut)
			);
			
			Two_Input_mux muxB(
							.in1(regBOut),
							.in2(cuOut),
							.select(MB),
							.out(muxBOut)
			);
			
			Two_Input_mux muxA(
							.in1(regAOut),
							.in2(pc_1Out),
							.select(MA),
							.out(muxAOut)
			);
			
			Constant_Unit cu(
									.in(IR_Out[5:0]),
									.CS(CS),
									.out(cuOut)
			);
			
			InstructionDecoder control(
											.opcode(IR_Out[16:12]),
											.FS(FS),
											.RW(RW),
											.MD(MD),
											.BS(BS),
											.PS(PS),
											.MW(MW),
											.MB(MB),
											.MA(MA),
											.CS(CS),
											.OE(OE)
			);
			
			Pipeline_Register #(.BUS_WIDTH(EX_REG_BUS_WIDTH))
									DOF_TO_EX(
													.clk(clk),
													.rst(rst),
													.load_enable(1'b1),
													.in({RW_in, DA_in, MD, BS_in, PS, MW_in, FS, IR_Out[2:0], OE}),
													
													//EX_out[0] == OE
													//EX_out[3:1] == SH
													//EX_out[7:4] == FS
													//EX_out[8] == MW
													//EX_out[9] == PS
													//EX_out[11:10] == BS
													//EX_out[13:12] == MD
													//EX_out[16:14] == DA
													//EX_out[17] == RW
													.out(EX_out)
									);
			
			Pipeline_Register BUS_A(
									.clk(clk),
									.rst(rst),
									.load_enable(1'b1),
									.in(muxAOut),
									.out(BUS_A_out)
			);
			
			Pipeline_Register BUS_B(
									.clk(clk),
									.rst(rst),
									.load_enable(1'b1),
									.in(muxBOut),
									.out(BUS_B_out)
			);
			
			Pipeline_Register #(.BUS_WIDTH(WB_REG_BUS_WIDTH))
							EX_TO_WB(
											.clk(clk),
											.rst(rst),
											.load_enable(1'b1),
											.in({EX_out[17], EX_out[16:14], EX_out[13:12]}),
											
											//WB_out[0:1] == MD
											//WB_out[4:2] == DA
											//WB_out[5] == RW
											.out(WB_out)
							);
			
			Pipeline_Register O_MSB(
									.clk(clk),
									.rst(rst),
									.load_enable(EX_out[0]),
									.in(BUS_B_out),
									.out(OUTPUT_MSB)
			);
			
			Pipeline_Register O_LSB(
									.clk(clk),
									.rst(rst),
									.load_enable(EX_out[0]),
									.in(BUS_A_out),
									.out(OUTPUT_LSB)
			);
			
			Pipeline_Register #(.BUS_WIDTH(D_BIT_BUS_WIDTH))
									D_BIT(
													.clk(clk),
													.rst(rst),
													.load_enable(1'b1),
													.in(D),
													.out(D_out)
									);
			
			Pipeline_Register F_Result(
									.clk(clk),
									.rst(rst),
									.load_enable(1'b1),
									.in(aluOut),
									.out(F_Result_out)
			);
			
			Pipeline_Register DATA_MEM(
									.clk(clk),
									.rst(rst),
									.load_enable(1'b1),
									.in(dataInDM),
									.out(DATA_MEM_out)
			);
			
			
			
			assign DA = IR_Out[11:9];
			assign RAA = BUS_A_out;
			assign MW_out = EX_out[8]; 
			assign pcNext = pcOut + 1;
			
			assign OR_DA = (|EX_out[16:14]);
			assign Comp_AA = (EX_out[16:14] == IR_Out[8:6]);
			assign HA = !MA & Comp_AA & EX_out[17] & OR_DA;
			assign Comp_BA = (EX_out[16:14] == IR_Out[5:3]);
			assign HB = !MB & Comp_BA & EX_out[17] & OR_DA;
			assign DHS = !(HA | HB);
			
			assign BS_EX = EX_out[11:10];
			assign PS_Z = EX_out[9] ^ Z;
			assign BS1_PS_Z = PS_Z | BS_EX[1];
			assign new_BS0 = (BS_EX[0]) & BS1_PS_Z;
			assign Br_Detect = !(new_BS0 | BS_EX[1]);
			assign MC = {BS_EX[1], new_BS0};
			
			assign IR_next = ({17{Br_Detect}}) & instr;
			assign RW_next = RW & DHS & Br_Detect;
			assign BS_next = BS & ({2{DHS}}) & ({2{Br_Detect}});
			assign MW_next = MW & Br_Detect & DHS;
			assign DA_next = DA & ({3{DHS}});
			
			assign BrA = BUS_B_out + pc_2Out;
			always @(negedge clk) begin
				if (rst) begin
					pcIn <= 8'h00;
					IR_In <= 8'h00;
					pc_1In <= 8'h00;
					pc_2In <= 8'h00;
				end
				else begin
					pcIn <= muxCOut;
					IR_In <= IR_next;
					pc_1In <= pcOut;
					pc_2In <= pc_1Out;
					RW_in <= RW_next;
					BS_in <= BS_next;
					MW_in <= MW_next;
					DA_in <= DA_next;
				end
			end
endmodule
