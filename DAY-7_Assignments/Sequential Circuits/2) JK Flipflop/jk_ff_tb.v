module jk_ff_tb;

reg clk;
reg rst;
reg J;
reg K;

wire Q;
wire Qn;

jk_ff dut(
    .clk(clk),
    .rst(rst),
    .J(J),
    .K(K),
    .Q(Q),
    .Qn(Qn)
);

always #5 clk = ~clk;

initial
begin
    clk = 0;
    rst = 1;
    J = 0;
    K = 0;

    #10 rst = 0;

    // HOLD
    J = 0; K = 0;
    #10;

    // RESET
    J = 0; K = 1;
    #10;

    // SET
    J = 1; K = 0;
    #10;

    // TOGGLE
    J = 1; K = 1;
    #10;

    // TOGGLE
    J = 1; K = 1;
    #10;

    // HOLD
    J = 0; K = 0;
    #10;

    $finish;
end

initial
begin
    $monitor("Time=%0t J=%b K=%b Q=%b",
              $time,J,K,Q);
end

endmodule
