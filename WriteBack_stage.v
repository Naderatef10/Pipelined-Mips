module WriteBack_stage (
    input wire [31:0] ReadDataW,
    input wire [31:0] ALUOutW,
    input wire        MemtoRegW,
    output wire [31:0] ResultW
);

mux2 mux_W (
    .sel(MemtoRegW),
    .IN1(ALUOutW),
    .IN2(ReadDataW),
    .out(ResultW)
);

endmodule
