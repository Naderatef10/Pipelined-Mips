module shif_wid(
    input [25:0] IN,
    output reg [27:0] OUT
);

always @(*) begin
    OUT= {IN,2'b00};
end

endmodule 
