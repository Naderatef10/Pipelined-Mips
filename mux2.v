module mux2
#(parameter WIDTH1 =32,
parameter WIDTH2 =32,
parameter WIDTH3 = 32
)


(

input wire sel,
input wire [WIDTH1-1:0] IN1,
input wire [WIDTH2-1:0] IN2,
output wire [WIDTH3-1:0] out

);

reg [WIDTH3-1:0] out_reg;
assign out = out_reg;

always @ (*)

begin


if(sel)

begin

out_reg = IN2; 

end 


else


begin 

out_reg = IN1;


end 

end 

endmodule