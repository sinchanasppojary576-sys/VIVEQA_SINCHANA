`timescale 1ns / 1ps

module uart_message(

    input clk,
    input rst,

    input uart_granted,
    input uart_denied,

    input tx_busy,

    output reg tx_start,
    output reg [7:0] tx_data
);

reg granted_d;
reg denied_d;

always @(posedge clk)
begin

    if(rst)
    begin
        tx_start   <= 1'b0;
        tx_data    <= 8'd0;

        granted_d  <= 1'b0;
        denied_d   <= 1'b0;
    end

    else
    begin

        tx_start <= 1'b0;

        granted_d <= uart_granted;
        denied_d  <= uart_denied;

        /////////////////////////////////////
        // Send G once
        /////////////////////////////////////
        if(uart_granted && !granted_d && !tx_busy)
        begin
            tx_data  <= "G";
            tx_start <= 1'b1;
        end

        /////////////////////////////////////
        // Send D once
        /////////////////////////////////////
        else if(uart_denied && !denied_d && !tx_busy)
        begin
            tx_data  <= "D";
            tx_start <= 1'b1;
        end

    end

end

endmodule
