module up_down_counter(
    input clk,
    input rst,
    input ld,
    input ud,              // 1 = UP, 0 = DOWN
    input [3:0] din,
    output reg [3:0] count
);

always @(posedge clk)
begin
    if(rst)
        count <= 4'b0000;

    else if(ld)
        count <= din;

    else if(ud)
        count <= count + 1'b1;

    else
        count <= count - 1'b1;
end

endmodule
