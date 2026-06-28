`timescale 1ns / 1ps

module password_fsm(

    input clk,
    input rst,

    input [3:0] key_code,
    input key_valid,

    output reg unlock,
    output reg alarm,

    output reg uart_granted,
    output reg uart_denied
);

reg [15:0] entered_pass;
reg [2:0]  digit_count;

reg [27:0] timer;
reg key_valid_d;

always @(posedge clk)
begin
    key_valid_d <= key_valid;
end

always @(posedge clk)
begin

    if(rst)
    begin
        entered_pass <= 16'd0;
        digit_count  <= 0;

        unlock <= 0;
        alarm  <= 0;

        uart_granted <= 0;
        uart_denied  <= 0;

        timer <= 0;
    end

    else
    begin

        uart_granted <= 0;
        uart_denied  <= 0;

        if(unlock)
        begin
            if(timer >= 120000000)
            begin
                unlock <= 0;
                timer <= 0;
            end
            else
                timer <= timer + 1;
        end

        else if(alarm)
        begin
            if(timer >= 24000000)
            begin
                alarm <= 0;
                timer <= 0;
            end
            else
                timer <= timer + 1;
        end

        else if(key_valid && !key_valid_d)
        begin

            //////////////////////////////////////////////////
            // CLEAR = F
            //////////////////////////////////////////////////

            if(key_code == 4'd15)
            begin
                entered_pass <= 0;
                digit_count  <= 0;
            end

            //////////////////////////////////////////////////
            // ENTER = A
            //////////////////////////////////////////////////

            else if(key_code == 4'd10)
            begin

                if(digit_count == 4)
                begin

                    if(entered_pass == 16'h0145)
                    begin
                        unlock <= 1;
                        uart_granted <= 1;
                    end
                    else
                    begin
                        alarm <= 1;
                        uart_denied <= 1;
                    end

                end

                entered_pass <= 0;
                digit_count  <= 0;
                timer <= 0;

            end

            //////////////////////////////////////////////////
            // STORE DIGITS
            //////////////////////////////////////////////////

            else if(digit_count < 4)
            begin
                entered_pass <= {entered_pass[11:0], key_code};
                digit_count <= digit_count + 1;
            end

        end

    end

end

endmodule
