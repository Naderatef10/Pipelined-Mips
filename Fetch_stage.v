module Fetch_stage (
    input   wire [1:0]  PCSrcF,
    input   wire [31:0] PCjumpF,
    input   wire [31:0] PCBranchF,
    input   wire        stallF,
    input   wire        clkF,
    input   wire        rstF,
    output  wire [31:0] instrF,
    output  wire [31:0] PCPlus4F       
);

wire [31:0] PC;
wire [31:0] PCF;

// mux 
mux4 mux4_F (
     .sel(PCSrcF),
     .IN1(PCPlus4F),
     .IN2(PCBranchF),
     .IN3(PCjumpF),
     .OUT(PC)
);

//PC

pc_counter pc_counter_F(
    .PC_bar(PC), 
    .clk(clkF),
    .rst(rstF),
    .stallF(stallF),
    .PC(PCF)
);

// Adder

adder adder_F (
    .PCPlus4D(PCF),
    .shifted_signal(32'd4),
    .PCBranchD(PCPlus4F)
);

// Instruction memory

instruction_memory instruction_memory_F (
    .PC(PCF),
    .Instr(instrF)
);


endmodule