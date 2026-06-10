module parity_task(
    input [31:0] address,
    output reg parity_reg
);

task parity_cal;
    input [31:0] data;
    output parity;

    begin
        #1 parity = ~^data;
    end
endtask

always @(address)
begin
    parity_cal(address, parity_reg);
end

endmodule
