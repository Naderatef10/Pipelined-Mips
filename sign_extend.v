module sign_extend(

input wire [15:0]Instr,
output wire [31:0]SignlmmD

);

wire [15:0]extend_signal;


assign extend_signal = {16{Instr[15]}};

assign SignlmmD = {extend_signal,Instr};





endmodule











