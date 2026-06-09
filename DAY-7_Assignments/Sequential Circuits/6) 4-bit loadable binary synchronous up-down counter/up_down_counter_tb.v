module up_down_counter_tb;

reg clk;
reg rst;
reg ld;
reg ud;
reg [3:0] din;

wire [3:0] count;

up_down_counter dut(
    .clk(clk),
    .rst(rst),
    .ld(ld),
    .ud(ud),
    .din(din),
    .count(count)
);

always #5 clk = ~clk;

initial
begin
    clk = 0;
    rst = 1;
    ld  = 0;
    ud  = 1;
    din = 0;

    // Reset
    #10 rst = 0;

    // UP Count
    ud = 1;
    #40;

    // Load value 10
    ld  = 1;
    din = 4'd10;
    #10;

    ld = 0;

    // Continue UP Count
    #30;

    // DOWN Count
    ud = 0;
    #50;

    // Load value 5
    ld  = 1;
    din = 4'd5;
    #10;

    ld = 0;

    // Continue DOWN Count
    #40;

    $finish;
end

endmodule
