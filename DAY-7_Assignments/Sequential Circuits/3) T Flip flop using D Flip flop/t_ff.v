module t_ff(
    input T,
    input clk,
    input rst,
    output Q,
    output Qn
);

wire D;
wire q_int;
wire qn_int;

assign D = T ^ q_int;

d_ff dff_inst(
    .D(D),
    .clk(clk),
    .rst(rst),
    .Q(q_int),
    .Qn(qn_int)
);

assign Q  = q_int;
assign Qn = qn_int;

endmodule
