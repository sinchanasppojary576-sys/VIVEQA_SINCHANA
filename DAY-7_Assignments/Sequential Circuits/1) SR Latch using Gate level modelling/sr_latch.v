module sr_latch(
    input S,
    input R,
    output Q,
    output Qn
);

nor (Q,  R, Qn);
nor (Qn, S, Q);

endmodule
