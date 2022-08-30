module  pc_counter(

input wire [31:0]PC_bar, 

input wire clk,

input wire rst,

input wire stallF,

output wire [31:0] PC

);

reg [31:0] PC_reg;
assign PC = PC_reg;

always @(posedge clk, negedge rst) 

begin
    
if(!rst)

begin 

PC_reg <= 32'b0;

end 

else if (stallF)

begin

PC_reg <= PC_reg;

end 

else 

begin

PC_reg <= PC_bar;

end 


end


endmodule 

