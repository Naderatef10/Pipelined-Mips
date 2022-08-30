module adder(

input wire [31:0]PCPlus4D,
input wire [31:0]shifted_signal,
output wire [31:0]PCBranchD

);

assign PCBranchD = shifted_signal + PCPlus4D ;


endmodule







