module loadable_up_counter_tb;

reg clk;
reg rst;
reg ld;
reg [3:0] din;

wire [3:0] count;

loadable_up_counter dut(
    .clk(clk),
    .rst(rst),
    .ld(ld),
    .din(din),
    .count(count)
);

always #5 clk = ~clk;

initial
begin
    clk = 0;
    rst = 1;
    ld  = 0;
    din = 4'b0000;

    // Reset
    #10 rst = 0;

    // Normal counting
    #20;

    // Load value 9
    ld  = 1;
    din = 4'b1001;
    #10;

    // Continue counting
    ld = 0;
    #40;

    // Load value 3
    ld  = 1;
    din = 4'b0011;
    #10;

    ld = 0;
    #40;

    $finish;
end

endmodule
