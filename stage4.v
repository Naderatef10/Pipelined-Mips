module stage4(
    input [31:0]  ReadDataM,
    input [31:0]  AluoutM2,
    input [4:0]  writeRegM2,
    input RegWriteM2, MemtoRegM2, clk,rst,
    output reg [31:0] ReadDataW,
    output reg [31:0] AluoutW,
    output reg [4:0]  writeRegW,
    output reg RegWriteW, MemtoRegW
);

always @(posedge clk,negedge rst) begin
    if (!rst)begin
    ReadDataW <= 32'b0;
    AluoutW   <= 32'b0 ;
    writeRegW <= 5'b0;
    RegWriteW <= 1'b0;
    MemtoRegW <= 1'b0;
    end
    else begin
    ReadDataW <= ReadDataM;
    AluoutW   <= AluoutM2 ;
    writeRegW <= writeRegM2;
    RegWriteW <= RegWriteM2;
    MemtoRegW <= MemtoRegM2; 
    end   
end

endmodule