module Decode_stage(
    input  wire [31:0] instrD,
    input  wire [31:0] PCPlus4D,
    input  wire        ForwardAD,
    input  wire        ForwardBD,
    input  wire        clkD,
    input  wire        rstD,
    input  wire        RegwriteW,
    input  wire [31:0] AluOutM_D,
    input  wire [31:0] ResultW,
    input  wire [4:0]  WriteRegW,
    output wire [5:0]  OPCode,
    output wire [5:0]  Funct,
    output wire        EqualD,
    output wire [31:0] OUT1,
    output wire [31:0] OUT2,
    output wire [4:0]  RsD,
    output wire [4:0]  RtD,
    output wire [4:0]  RdD,
    output wire [31:0] SignlmmD,
    output wire [31:0] PCBranchD,
    output wire [31:0] PCjumpD

);

wire [31:0] shout;
wire [25:0] shout2;
wire [31:0] RD1_D,RD2_D;

//wire [31:0] PC_temp; 

assign RsD = instrD [25:21];
assign RtD = instrD [20:16];
assign RdD = instrD [15:11];
assign OPCode = instrD [31:26];
assign Funct = instrD [5:0];
//assign PC_temp = PCPlus4D -32'd4;
assign PCjumpD = {PCPlus4D[31:26],shout2};



//Reg file 

Register_File Register_File_D (
     .A1(RsD),
     .A2(RtD),
     .A3(WriteRegW),
     .WD3(ResultW),
     .RST_RegFile(rstD),
     .CLK_RegFile(clkD),
     .WE3(RegwriteW),
     .RD1(RD1_D),
     .RD2(RD2_D)
);

// mux
mux2 mux2_D1(
    .sel(ForwardAD),
    .IN1(RD1_D),
    .IN2(AluOutM_D),
    .out(OUT1)
);

mux2 mux2_D2(
    .sel(ForwardBD),
    .IN1(RD2_D),
    .IN2(AluOutM_D),
    .out(OUT2)
);

//Comprator
equality equality_D(
    .R1(OUT1),
    .R2(OUT2),
    .EqualD(EqualD)
);

// sign Extend
sign_extend sign_extend_D (
    .Instr(instrD[15:0]),
    .SignlmmD(SignlmmD)
);

// sfift two
shift_two shift_two_D (
    .IN(SignlmmD),
    .OUT(shout)
);

//Adder
adder adder_D (
   .PCPlus4D(shout),
   .shifted_signal(PCPlus4D),
   .PCBranchD(PCBranchD)
);

//shift Width
shif_wid shif_wid_D (
    .IN(instrD [25:0]),
    .OUT(shout2)
);










endmodule