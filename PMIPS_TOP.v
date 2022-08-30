module PMIPS_TOP (
    input  wire CLK,RST,
    output [15:0] TestValue 

);

wire RegWrite_top,RegDst_top,MemtoReg_top,MemWrite_top,ALUSrc_top,Branch_top,Jump_top;
wire [2:0] ALUControl_top;
wire [5:0] Op_top,Funct_top;
wire EqualD_top,BEQ;
wire [1:0] PCSRC_top; 

assign BEQ = Branch_top & EqualD_top;
assign PCSRC_top = {Jump_top,BEQ};

Control_Unit U1 (
    .Op(Op_top),
    .Funct(Funct_top),
    .RegWrite(RegWrite_top),
    .RegDst(RegDst_top),
    .MemtoReg(MemtoReg_top),
    .MemWrite(MemWrite_top),
    .ALUSrc(ALUSrc_top),
    .Branch(Branch_top),
    .Jump(Jump_top),
    .ALUControl(ALUControl_top)
);

wire stallF_top,stallD_top,clr_top,FlushE_top,ForwardAD_top,ForwardBD_top;
wire [1:0] ForwardAE_top ,ForwardBE_top;
wire [4:0] RsD_top,RtD_top,RsE_top,RtE_top,WriteRegE_top,WriteRegM_top,WriteRegW_top;
wire RegWriteE_top,MemtoRegE_top,RegWriteM_top,MemtoRegM_top,RegWriteW_top;

assign  clr_top = (|PCSRC_top); 

datapath U2 (
    // inputs of datapath
    .clk_datapath(CLK),
    .rst_datapath(RST), 
    .stallF_datapath(stallF_top),
    .stallD_datapath(stallD_top), 
    .PCSRC_datapath(PCSRC_top),
    .ForwardAE_datapath(ForwardAE_top),
    .ForwardBE_datapath(ForwardBE_top),
    .ForwardAD_datapath(ForwardAD_top),
    .ForwardBD_datapath(ForwardBD_top),
    .FlushE_datapath(FlushE_top),
    .CLR_pipeline(clr_top),
    .RegWrite_datapath(RegWrite_top),
    .RegDst_datapath(RegDst_top),
    .MemtoReg_datapath(MemtoReg_top),
    .MemWrite_datapath(MemWrite_top),
    .ALUSrc_datapath(ALUSrc_top),
    .ALUControl_datapath(ALUControl_top),

    // outputs of datapath
    .Op_datapath(Op_top),
    .Funct_datapath(Funct_top),
    .WriteRegE_datapath(WriteRegE_top),
    .WriteRegM_datapath(WriteRegM_top),
    .WriteRegW_datapath(WriteRegW_top),
    .test_value_datapath(TestValue),
    .RsD_datapath(RsD_top),
    .RtD_datapath(RtD_top),
    .RsE_datapath(RsE_top),
    .RtE_datapath(RtE_top),
    .EqualD_datapath(EqualD_top),
    .RegWriteE_datapath(RegWriteE_top),
    .MemtoRegE_datapath(MemtoRegE_top),
    .RegWriteM_datapath(RegWriteM_top),
    .MemtoRegM_datapath(MemtoRegM_top),
    .RegWriteW_datapath(RegWriteW_top)

);


hazard_unit U3 (
    .WriteRegW(WriteRegW_top), 
    .WriteRegM(WriteRegM_top),
    .WriteRegE(WriteRegE_top),
    .RsE(RsE_top),
    .RtE(RtE_top),
    .RsD(RsD_top),
    .RtD(RtD_top),
    .BranchD(Branch_top), 
    .MemtoRegE(MemtoRegE_top), 
    .RegWriteE(RegWriteE_top), 
    .MemtoRegM(MemtoRegM_top), 
    .RegWriteM(RegWriteM_top), 
    .RegWriteW(RegWriteW_top), 
    .jumpD(Jump_top),
    .StallF(stallF_top), 
    .StallD(stallD_top),
    .FlushE(FlushE_top),
    .ForwardAD(ForwardAD_top), 
    .ForwardBD(ForwardBD_top),
    .ForwardAE(ForwardAE_top), 
    .ForwardBE(ForwardBE_top)

);
endmodule 