module Control_Unit (
    input      [5:0] Op,Funct,
    output reg       RegWrite,RegDst,
    output reg       MemtoReg,MemWrite,
    output reg       ALUSrc,Branch,Jump,
    output reg [2:0] ALUControl
);
    
reg [1:0] ALUOp;

//Main Decoder block
always@ (*)
begin
    case(Op)
        6'b10_0011: 
        begin
            ALUOp = 2'b00;
            MemWrite = 1'b0;
            RegWrite = 1'b1;
            RegDst = 1'b0;
            ALUSrc = 1'b1;
            MemtoReg = 1'b1;
            Branch = 1'b0;
            Jump = 1'b0;
        end
        6'b10_1011:
        begin 
            ALUOp = 2'b00;
            MemWrite = 1'b1;
            RegWrite = 1'b0;
            RegDst = 1'b0;
            ALUSrc = 1'b1;
            MemtoReg = 1'b1;
            Branch = 1'b0;
            Jump = 1'b0;
        end
        6'b00_0000:
        begin
            ALUOp = 2'b10;
            MemWrite = 1'b0;
            RegWrite = 1'b1;
            RegDst = 1'b1;
            ALUSrc = 1'b0;
            MemtoReg = 1'b0;
            Branch = 1'b0;
            Jump = 1'b0;
        end
        6'b00_1000:
        begin
            ALUOp = 2'b00;
            MemWrite = 1'b0;
            RegWrite = 1'b1;
            RegDst = 1'b0;
            ALUSrc = 1'b1;
            MemtoReg = 1'b0;
            Branch = 1'b0;
            Jump = 1'b0;
        end
        6'b00_0100:
        begin
            ALUOp = 2'b01;
            MemWrite = 1'b0;
            RegWrite = 1'b0;
            RegDst = 1'b0;
            ALUSrc = 1'b0;
            MemtoReg = 1'b0;
            Branch = 1'b1;
            Jump = 1'b0;
        end
        6'b00_0010:
        begin
            ALUOp = 2'b00;
            MemWrite = 1'b0;
            RegWrite = 1'b0;
            RegDst = 1'b0;
            ALUSrc = 1'b0;
            MemtoReg = 1'b0;
            Branch = 1'b0;
            Jump = 1'b1;
        end
        default:
        begin
            ALUOp = 2'b00;
            MemWrite = 1'b0;
            RegWrite = 1'b0;
            RegDst = 1'b0;
            ALUSrc = 1'b0;
            MemtoReg = 1'b0;
            Branch = 1'b0;
            Jump = 1'b0;
        end
    endcase
end

//ALU Decoder block
always@ (*)
begin
    case(ALUOp)
    2'b01: ALUControl = 3'b100;
    2'b10:  
    begin
        case(Funct)
        6'b10_0010: ALUControl = 3'b100;
        6'b10_1010: ALUControl = 3'b110;
        6'b01_1100: ALUControl = 3'b101;
        default: ALUControl = 3'b010;
        endcase
    end
    default: ALUControl = 3'b010;
    endcase
end

endmodule