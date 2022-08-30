module Memory_stage (
    input wire [31:0] ALUOutM,
    input wire [31:0] WriteDataM,
    input wire        CLKM,RSTM,
    input wire        MemWriteM,
    output wire [31:0] RDM,
    output wire [15:0] test_value
);

ram ram_M (
    .WD(WriteDataM),
    .addr(ALUOutM),
    .WE(MemWriteM),
    .clk(CLKM),
    .rst(RSTM),
    .RD(RDM),
    .test_value(test_value)
);

endmodule