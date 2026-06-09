module mux4x1(
    input i0,
    input i1,
    input i2,
    input i3,
    input [1:0] s,
    output y
);

wire w1, w2;

mux2x1 M0(
    .i0(i0),
    .i1(i1),
    .s(s[0]),
    .y(w1)
);

mux2x1 M1(
    .i0(i2),
    .i1(i3),
    .s(s[0]),
    .y(w2)
);

mux2x1 M2(
    .i0(w1),
    .i1(w2),
    .s(s[1]),
    .y(y)
);

endmodule
