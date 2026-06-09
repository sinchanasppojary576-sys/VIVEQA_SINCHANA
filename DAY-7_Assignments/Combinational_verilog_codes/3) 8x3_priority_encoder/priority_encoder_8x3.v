module priority_encoder_8x3(
    input  [7:0] d,
    output [2:0] y
);

assign y[2] = d[4] | d[5] | d[6] | d[7];

assign y[1] = d[6] | d[7] |
             ((~d[7]) & (~d[6]) & d[2]) |
             ((~d[7]) & (~d[6]) & d[3]);

assign y[0] = d[7] |
             ((~d[7]) & (~d[6]) & (~d[5]) & (~d[4]) & d[3]) |
             ((~d[7]) & (~d[6]) & d[5]) |
             ((~d[7]) & (~d[6]) & (~d[5]) & (~d[4]) &
              (~d[3]) & (~d[2]) & d[1]);

endmodule
