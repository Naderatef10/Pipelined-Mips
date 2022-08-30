module alu(
    input  [31:0] srcA,
    input  [31:0] srcB,
    input  [2:0]  alu_control,
    output reg [31:0] alu_out   
);

always @(*) 
begin
    case(alu_control)
    3'b000: alu_out = srcA & srcB;
    3'b001: alu_out = srcA | srcB;
    3'b010: alu_out = srcA + srcB;
    3'b100: alu_out = srcA - srcB;
    3'b101: alu_out = srcA * srcB;
    3'b110: 
      begin
        if (srcA < srcB) alu_out = 32'hFFFFFFFF;
        else  alu_out =32'b0;
      end
    default: alu_out = 32'b0;  
    endcase
end

 endmodule