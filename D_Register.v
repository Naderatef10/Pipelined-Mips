module D_Register ( 
    //DR at the end of the i/p & o/p ports names referred to Decode Register
    //(meaning Register between Decode & Excute Stage)        **//RegD register bits table**
    input              CLK_DReg,CLR_DReg,RST_DReg,             //RegWriteDR     -->   [118]
    input              RegWriteDR,RegDstDR,                    //MemtoRegDR     -->   [117]
    input              MemtoRegDR,MemWriteDR,                  //MemWriteDR     -->   [116]
    input              ALUSrcDR,                               //ALUControlDR   -->   [113:115]
    input      [  2:0] ALUControlDR,                           //ALUSrcDR       -->   [112]
    input      [  4:0] RsDR,RtDR,RdDR,                         //RegDstDR       -->   [111]
    input      [ 31:0] Op1DR,Op2DR,                            //Op1DR          -->   [79:110]
    input      [ 31:0] SignImmDR,                              //Op2DR          -->   [47:78]
    output reg [118:0] RegD                                    //RsDR           -->   [46:42]
);                                                             //RtDR           -->   [41:37]
                                                               //RdDR           -->   [36:32]
                                                               //SignImmDR      -->   [31:0]

always@ (posedge CLK_DReg or negedge RST_DReg)
begin
    if((!RST_DReg) | CLR_DReg)
    begin
        RegD <= 119'b0;
    end
    else
    begin
        //          [102]      [101]     [100]      [99:97]      [96]     [95]    [94:63][62:31][30:26][25:21][20:16]  [31:0]
        RegD <= {RegWriteDR,MemtoRegDR,MemWriteDR,ALUControlDR,ALUSrcDR,RegDstDR,  Op1DR,  Op2DR,  RsDR,  RtDR,  RdDR,SignImmDR};
    end
end

endmodule
