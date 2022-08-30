module Register_File (
    input      [ 4:0] A1,A2,A3,
    input      [31:0] WD3,
    input             RST_RegFile,CLK_RegFile,WE3,
    output wire  [31:0] RD1,RD2
);

reg [31:0] RegFile [31:0];
integer i;


always@ (negedge CLK_RegFile , negedge RST_RegFile )
begin
    if(!RST_RegFile)
    begin  
        for (i=0; i<32; i=i+1)
        begin
            RegFile[i] <= 32'b0;
        end

    end
     else if(WE3)
    begin
        RegFile[A3] <= WD3;
    end
end

//combinational cloud block
   assign  RD1  = RegFile[A1];
   assign  RD2  = RegFile[A2];


endmodule