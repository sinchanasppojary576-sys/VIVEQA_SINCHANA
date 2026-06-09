module t_ff_tb;

reg T;
reg clk;
reg rst;

wire Q;
wire Qn;

t_ff dut(
    .T(T),
    .clk(clk),
    .rst(rst),
    .Q(Q),
    .Qn(Qn)
);

always #5 clk = ~clk;

initial
begin
    clk = 0;
    rst = 1;
    T   = 0;

    #10 rst = 0;

    // Hold
    T = 0;
    #20;

    // Toggle
    T = 1;
    #20;

    // Toggle
    T = 1;
    #20;

    // Hold
    T = 0;
    #20;

    $finish;
end

initial
begin
    $monitor("Time=%0t T=%b Q=%b", $time, T, Q);
end

endmodule
