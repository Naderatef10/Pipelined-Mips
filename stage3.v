module stage3(
    input [31:0] AluoutE,
    input [31:0] writeDataE,
    input [4:0]  writeRegE,
    input       clk, RegWriteE2, MemtoRegE2, MemwriteE2,Rst, 
    output reg [31:0] AluoutM,
    output reg [31:0] writeDataM,
    output reg [4:0]  writeRegM,
    output reg RegWriteM, MemtoRegM, MemwriteM
);

always @(posedge clk,negedge Rst) begin
    if (!Rst)
    begin
    AluoutM    <= 32'd0;
    writeDataM <= 32'd0;
    writeRegM  <= 5'd0;
    RegWriteM  <= 1'b0;
    MemtoRegM  <= 1'b0;
    MemwriteM  <= 1'b0;
  end

else begin
    AluoutM <= AluoutE;
    writeDataM <= writeDataE;
    writeRegM  <= writeRegE;
    RegWriteM  <= RegWriteE2;
    MemtoRegM  <= MemtoRegE2;
    MemwriteM  <= MemwriteE2;  
end
end

endmodule