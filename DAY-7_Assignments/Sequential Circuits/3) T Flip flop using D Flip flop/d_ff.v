module d_ff(
    input D,
    input clk,
    input rst,
    output reg Q,
    output Qn
);

always @(posedge clk)
begin
    if(rst)
        Q <= 1'b0;
    else
        Q <= D;
end

assign Qn = ~Q;

endmodule
