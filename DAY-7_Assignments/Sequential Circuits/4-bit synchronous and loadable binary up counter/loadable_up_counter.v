module loadable_up_counter(
    input clk,
    input rst,
    input ld,
    input [3:0] din,
    output reg [3:0] count
);

always @(posedge clk)
begin
    if(rst)
        count <= 4'b0000;
    else if(ld)
        count <= din;
    else
        count <= count + 1'b1;
end

endmodule
