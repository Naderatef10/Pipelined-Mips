module Excute_stage (
    input wire [31:0] RD1E,RD2E,
    input wire [4:0]  RsE,RtE,RdE,
    input wire [31:0] SignImmE,
    input wire [31:0] ALUOutM,
    input wire [31:0] ResultW,
    input wire [1:0]   ForwardAE,ForwardBE,
    input wire          RegDstE,ALUSrcE,
    input wire [2:0]   ALUControlE,
    output wire [31:0] ALUOutE,
    output wire [31:0] WriteDataE,
    output wire [4:0]   WriteRegE,
    output wire [4:0]  RsE_HZ,RtE_HZ
);

wire [31:0] SrcAE,SrcBE;

assign RsE_HZ = RsE;
assign RtE_HZ = RtE;

//mux 2x1
mux2 #(.WIDTH1(5),.WIDTH2(5),.WIDTH3(5)) mux2_E (
    .sel(RegDstE),
    .IN1(RtE),
    .IN2(RdE),
    .out(WriteRegE)
);

//mux 4x1
mux4 mux4_AE(
    .sel(ForwardAE),
    .IN1(RD1E),
    .IN2(ResultW),
    .IN3(ALUOutM),
    .OUT(SrcAE)
);

//mux 4x1
mux4 mux4_BE(
    .sel(ForwardBE),
    .IN1(RD2E),
    .IN2(ResultW),
    .IN3(ALUOutM),
    .OUT(WriteDataE)
);

//mux 2x1
mux2 mux2_ALU_E (
    .sel(ALUSrcE),
    .IN1(WriteDataE),
    .IN2(SignImmE),
    .out(SrcBE)
);

//ALU
alu ALU_E (
    .srcA(SrcAE),
    .srcB(SrcBE),
    .alu_control(ALUControlE),
    .alu_out(ALUOutE) 
);

endmodule