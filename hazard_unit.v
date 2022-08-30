module hazard_unit(
input wire [4:0] WriteRegW, WriteRegM, WriteRegE,RsE,RtE,RsD,RtD,

input wire BranchD, MemtoRegE, RegWriteE, MemtoRegM, RegWriteM, RegWriteW, jumpD,


output wire StallF, StallD, FlushE,

output reg ForwardAD, ForwardBD, 

output reg [1:0] ForwardAE, ForwardBE


);

wire lwstall;

wire branchstall;

always @ (*)

begin

if((RsE != 0) && (RsE == WriteRegM) && (RegWriteM) )

begin

ForwardAE = 2'b10;

end 

else if ((RsE != 0) && (RsE == WriteRegW) && (RegWriteW) )

begin

ForwardAE = 2'b01;

end 

else 

begin

ForwardAE = 2'b00;

end 


/*********************************************************/


if((RtE != 0) && (RtE == WriteRegM) && (RegWriteM) )

begin

ForwardBE = 2'b10;

end 

else if ((RtE != 0) && (RtE == WriteRegW) && (RegWriteW) )

begin
    
ForwardBE = 2'b01;

end 

else 

begin

ForwardBE = 2'b00;

end 

end 

/*************************************************************/

always @ (*)

begin

ForwardAD = (RsD != 5'b0) && (RsD == WriteRegM) && (RegWriteM);

ForwardBD = (RtD != 5'b0) && (RtD == WriteRegM) && (RegWriteM);



end 


assign lwstall = ((RsD == RtE) || (RtD==RtE)) && (MemtoRegE) ;


assign branchstall = (BranchD && RegWriteE && (WriteRegE == RsD || WriteRegE == RtD) ) || (BranchD && MemtoRegM && (WriteRegM == RsD || WriteRegM == RtD));



assign StallF = ( lwstall || branchstall );

assign StallD = ( lwstall || branchstall );

assign FlushE = ( lwstall || branchstall || jumpD );


/*******************************************************************/


endmodule 