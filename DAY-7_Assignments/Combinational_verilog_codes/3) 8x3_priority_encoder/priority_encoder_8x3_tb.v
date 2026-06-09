module priority_encoder_8x3_tb;

reg [7:0] d;
wire [2:0] y;

priority_encoder_8x3 dut(
    .d(d),
    .y(y)
);

initial
begin
    d = 8'b00000001; #10; // y=000
    d = 8'b00000010; #10; // y=001
    d = 8'b00000100; #10; // y=010
    d = 8'b00001000; #10; // y=011
    d = 8'b00010000; #10; // y=100
    d = 8'b00100000; #10; // y=101
    d = 8'b01000000; #10; // y=110
    d = 8'b10000000; #10; // y=111

    // Priority check
    d = 8'b10101010; #10; // Highest priority bit = d7 -> y=111

    $finish;
end

endmodule
