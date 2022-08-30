module mux4

#(

parameter WIDTH1 = 32,
parameter WIDTH2 = 32,
parameter WIDTH3 = 32,
parameter WIDTH4 = 32
)


(
input wire [1:0]sel,
input wire [WIDTH1-1:0]IN1,
input wire [WIDTH2-1:0]IN2,
input wire [WIDTH3-1:0]IN3,
output wire [WIDTH4-1:0]OUT

);

reg [WIDTH4-1:0]out_reg; 
assign OUT = out_reg;



always @ (*)
begin 

    case(sel)

 

2'b00: begin 
         
        out_reg = IN1;

        end 

2'b01:begin
        
       out_reg = IN2;
    
      end

2'b10:begin 

       out_reg = IN3;

      end 

default: 
     
     begin

     out_reg = IN1;

     end 


    endcase  


end 



endmodule