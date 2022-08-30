module datapath(

input wire clk_datapath,
input wire rst_datapath, 
input wire stallF_datapath,
input wire stallD_datapath, 
input wire [1:0] PCSRC_datapath,
input wire [1:0] ForwardAE_datapath,ForwardBE_datapath,
input wire ForwardAD_datapath,ForwardBD_datapath,
input wire FlushE_datapath,


input wire        CLR_pipeline,
input wire       RegWrite_datapath,RegDst_datapath,
input wire       MemtoReg_datapath,MemWrite_datapath,
input wire       ALUSrc_datapath,
input wire [2:0] ALUControl_datapath,




output  wire [5:0] Op_datapath,Funct_datapath,

output wire [4:0] WriteRegE_datapath, WriteRegM_datapath, WriteRegW_datapath,

output wire [15:0]test_value_datapath,

output wire [4:0] RsD_datapath,RtD_datapath,RsE_datapath,RtE_datapath,

output wire EqualD_datapath,

output wire MemtoRegE_datapath,RegWriteE_datapath,MemtoRegM_datapath,RegWriteM_datapath,RegWriteW_datapath

);

wire [31:0] Instr_pipeline,PCPlus4F_pipeline,PCBranch_decode_fetch, PCJUMP_decode_fetch;
wire [31:0] InstrD_pipeline, PCPlus4D_pipeline;
wire  RegWriteW_stage4_decode;
wire [31:0] ALUOUTM_D,ResultW_D;
wire [31:0] OUT1_dregister, OUT2_dregister;
wire [4:0] RdD_dregister;
wire [31:0] SignlmmD_dregister;
wire [31:0]  ALUOUTE_Stage3;
wire [31:0]  WriteDataE_stage3;
wire [31:0]  WriteDataM_stage4;
wire [118:0] regdst;
wire RegWrite_stage4,MemtoReg_stage4,Memwrite_stage4;
wire [31:0] RDM_stage4;
wire [31:0] ReadDataW_datapath;
wire [31:0] AluoutW_datapath;
wire MemtoRegW_datpath;


assign RegWriteE_datapath = regdst[118];
assign MemtoRegE_datapath = regdst[117];
assign RegWriteM_datapath = RegWrite_stage4;
assign MemtoRegM_datapath = MemtoReg_stage4;
assign RegWriteW_datapath = RegWriteW_stage4_decode;


Fetch_stage F1(

.PCSrcF(PCSRC_datapath),
.PCjumpF(PCJUMP_decode_fetch),
.PCBranchF(PCBranch_decode_fetch),
.stallF(stallF_datapath),
.clkF(clk_datapath),
.rstF(rst_datapath),
.instrF(Instr_pipeline),
.PCPlus4F(PCPlus4F_pipeline)   
);


pipeline_register stage1(

.CLK(clk_datapath),
.rst(rst_datapath), 
.CLR(CLR_pipeline), 
.EN(stallD_datapath), 
.InstrF(Instr_pipeline),
.PCPlus4F(PCPlus4F_pipeline),
.InstrD(InstrD_pipeline), 
.PCPlus4D(PCPlus4D_pipeline)
);



Decode_stage D1(
.instrD(InstrD_pipeline),
.PCPlus4D(PCPlus4D_pipeline),
.ForwardAD(ForwardAD_datapath),
.ForwardBD(ForwardBD_datapath),
.clkD(clk_datapath),
.rstD(rst_datapath),
.RegwriteW(RegWriteW_stage4_decode),
.AluOutM_D(ALUOUTM_D),
.ResultW(ResultW_D),
.WriteRegW(WriteRegW_datapath),
.OPCode(Op_datapath),
.Funct(Funct_datapath),
.EqualD(EqualD_datapath),
.OUT1(OUT1_dregister),
.OUT2(OUT2_dregister),
.RsD(RsD_datapath),
.RtD(RtD_datapath),
.RdD(RdD_dregister),
.SignlmmD(SignlmmD_dregister),
.PCBranchD(PCBranch_decode_fetch),
.PCjumpD(PCJUMP_decode_fetch)
);



D_Register register_datapath(

.RegWriteDR(RegWrite_datapath),  
.MemtoRegDR(MemtoReg_datapath), 
.MemWriteDR(MemWrite_datapath),  
.ALUControlDR(ALUControl_datapath),
.ALUSrcDR(ALUSrc_datapath),    
.RegDstDR(RegDst_datapath),    
.Op1DR(OUT1_dregister),      
.Op2DR(OUT2_dregister),       
.RsDR(RsD_datapath),        
.RtDR(RtD_datapath),        
.RdDR(RdD_dregister),        
.SignImmDR(SignlmmD_dregister),   
.CLK_DReg(clk_datapath),
.CLR_DReg(FlushE_datapath),
.RST_DReg(rst_datapath),
.RegD(regdst)

);


Excute_stage E1(

.RD1E(regdst[110:79]),
.RD2E(regdst[78:47]),
.RsE(regdst[46:42]),
.RtE(regdst[41:37]),
.RdE(regdst[36:32]),
.SignImmE(regdst[31:0]),
.ALUOutM(ALUOUTM_D),
.ResultW(ResultW_D),
.ForwardAE(ForwardAE_datapath),
.ForwardBE(ForwardBE_datapath),
.RegDstE(regdst[111]),
.ALUSrcE(regdst[112]),
.ALUControlE(regdst[115:113]),
.ALUOutE(ALUOUTE_Stage3),
.WriteDataE(WriteDataE_stage3),
.WriteRegE(WriteRegE_datapath),
.RsE_HZ(RsE_datapath),
.RtE_HZ(RtE_datapath)
);







stage3 register_4(

.AluoutE(ALUOUTE_Stage3),
.writeDataE(WriteDataE_stage3),
.writeRegE(WriteRegE_datapath),
.clk(clk_datapath),
.Rst(rst_datapath),
.RegWriteE2(regdst[118]), 
.MemtoRegE2(regdst[117]), 
.MemwriteE2(regdst[116]), 
.AluoutM(ALUOUTM_D),
.writeDataM(WriteDataM_stage4),  
.writeRegM(WriteRegM_datapath),
.RegWriteM(RegWrite_stage4), 
.MemtoRegM(MemtoReg_stage4), 
.MemwriteM(Memwrite_stage4)

);








Memory_stage M1(


.ALUOutM(ALUOUTM_D),
.WriteDataM(WriteDataM_stage4),
.CLKM(clk_datapath),
.RSTM(rst_datapath),
.MemWriteM(Memwrite_stage4),
.RDM(RDM_stage4),
.test_value(test_value_datapath)


);




stage4 s4(


.ReadDataM(RDM_stage4),
.AluoutM2(ALUOUTM_D),
.writeRegM2(WriteRegM_datapath),
.RegWriteM2(RegWrite_stage4),
.MemtoRegM2(MemtoReg_stage4),
.clk(clk_datapath),
.rst(rst_datapath),
.ReadDataW(ReadDataW_datapath),
.AluoutW(AluoutW_datapath),
.writeRegW(WriteRegW_datapath),
.RegWriteW(RegWriteW_stage4_decode), 
.MemtoRegW(MemtoRegW_datpath)


);

WriteBack_stage W(
.ReadDataW(ReadDataW_datapath),
.ALUOutW(AluoutW_datapath),
.MemtoRegW(MemtoRegW_datpath),
.ResultW(ResultW_D)

);











//RegD register bits table**
 //RegWriteDR     -->   [118]
 //MemtoRegDR     -->   [117]
 //MemWriteDR     -->   [116]
 //ALUControlDR   -->   [113:115]
 //ALUSrcDR       -->   [112]
 //RegDstDR       -->   [111]
 //Op1DR          -->   [79:110]
 //Op2DR          -->   [47:78]
 //RsDR           -->   [46:42]
 //RtDR           -->   [41:37]
 //RdDR           -->   [36:32]
 //SignImmDR      -->   [31:0]



endmodule 