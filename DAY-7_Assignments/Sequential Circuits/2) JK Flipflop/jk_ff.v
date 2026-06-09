module jk_ff (
    input clk,
    input rst,
    input J,
    input K,
    output reg Q,
    output Qn
);

parameter HOLD   = 2'b00;
parameter RESET  = 2'b01;
parameter SET    = 2'b10;
parameter TOGGLE = 2'b11;

always @(posedge clk)
begin
    if (rst)
        Q <= 1'b0;
    else
    begin
        case ({J,K})
            HOLD   : Q <= Q;
            RESET  : Q <= 1'b0;
            SET    : Q <= 1'b1;
            TOGGLE : Q <= ~Q;
            default: Q <= Q;
        endcase
    end
end

assign Qn = ~Q;

endmodule
