module mod12_counter_tb;

reg clk;
reg rst;
reg ld;
reg [3:0] din;

wire [3:0] count;

mod12_counter dut(
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
    din = 0;

    // Reset
    #10 rst = 0;

    // Count normally
    #40;

    // Load value 8
    ld  = 1;
    din = 4'd8;
    #10;

    ld = 0;

    // Observe 8→9→10→11→0→1...
    #80;

    // Load value 5
    ld  = 1;
    din = 4'd5;
    #10;

    ld = 0;

    #50;

    $finish;
end

endmodule
