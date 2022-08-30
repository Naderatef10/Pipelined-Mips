module pipeline_register
#(
parameter WIDTH = 32
)
(

// input control signals
input wire CLK,
input wire rst, // active low signal to reset register while starting up the processor
input wire CLR, // active high signal that clears the fetch register when a control hazard occurs while executing beq command (output from control unit)
input wire EN, // enable signal is active low which is corresponding to stall decoding stage when a low signal comes from the hazard unit

// input data signals to pipelined register
input wire [WIDTH-1:0] InstrF,
input wire [WIDTH-1:0] PCPlus4F, // F indication for fetch stage 

// output data signals from pipelined register

output reg [WIDTH-1:0] InstrD, // D is an indication for decode stage
output reg [WIDTH-1:0] PCPlus4D

);


// always block triggered on asycnhronous EN or CLR in addition to posedge of CLK.
always @(posedge CLK,negedge rst) 
begin

// rst has highest priority then clear then enabling stalling in case of LW command when dealing with the memory 
if(!rst)

begin
InstrD <= 0 ;
PCPlus4D <=0;

end 

// chcek after testing
// incase of control hazard
else if(CLR && !EN)

begin 

InstrD <= 0;
PCPlus4D <=PCPlus4F;

end 

else if(!EN)

// Normal pipeline behaviour
begin 

InstrD <= InstrF;
PCPlus4D <= PCPlus4F;


end 



end

endmodule