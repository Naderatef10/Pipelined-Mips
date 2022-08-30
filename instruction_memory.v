module instruction_memory

#(
parameter  WIDTH = 32,
parameter DEPTH = 100


)



(

input wire [WIDTH-1:0]PC,
output wire [WIDTH-1:0]Instr

);


reg [WIDTH-1:0] Instr_reg;

reg [WIDTH-1:0] instruction_memory [DEPTH-1:0];

assign Instr = Instr_reg;

// we divide PC by 4 because memory is not alined

always @(*)

begin


Instr_reg = instruction_memory[PC >> 2] ;


end 


// to read the assembly testing program 
initial 
    
begin


 $readmemh ("Program.txt", instruction_memory);
        

end






endmodule