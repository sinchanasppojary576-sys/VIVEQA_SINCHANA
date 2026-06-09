module mux4x1_tb;

reg i0, i1, i2, i3;
reg [1:0] s;
wire y;

mux4x1 dut(
    .i0(i0),
    .i1(i1),
    .i2(i2),
    .i3(i3),
    .s(s),
    .y(y)
);

initial
begin
    i0 = 0;
    i1 = 1;
    i2 = 0;
    i3 = 1;

    s = 2'b00; #10;
    s = 2'b01; #10;
    s = 2'b10; #10;
    s = 2'b11; #10;

    i0 = 1;
    i1 = 0;
    i2 = 1;
    i3 = 0;

    s = 2'b00; #10;
    s = 2'b01; #10;
    s = 2'b10; #10;
    s = 2'b11; #10;

    $finish;
end

endmodule
