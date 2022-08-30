module equality(

input wire [31:0]R1,
input wire [31:0]R2,

output wire EqualD


);


assign EqualD = (R1==R2);



endmodule