`timescale 1ns / 1ps

module password_display(

    input clk,
    input rst,

    input [3:0] key_code,
    input key_valid,

    input unlock,
    input alarm,

    output reg [3:0] d0,
    output reg [3:0] d1,
    output reg [3:0] d2,
    output reg [3:0] d3
);

//////////////////////////////////////////////////
// INTERNAL SIGNALS
//////////////////////////////////////////////////

reg [2:0] digit_count;
reg key_valid_d;

//////////////////////////////////////////////////
// EDGE DETECTION FOR KEY PRESS
//////////////////////////////////////////////////

always @(posedge clk)
begin
    if(rst)
        key_valid_d <= 0;
    else
        key_valid_d <= key_valid;
end

//////////////////////////////////////////////////
// MAIN LOGIC
//////////////////////////////////////////////////

always @(posedge clk)
begin

    if(rst)
    begin
        d0 <= 0;
        d1 <= 0;
        d2 <= 0;
        d3 <= 0;

        digit_count <= 0;
    end

    else
    begin

        //////////////////////////////////////////////////
        // SUCCESS DISPLAY
        //////////////////////////////////////////////////
        if(unlock)
        begin
            d0 <= 1;
            d1 <= 1;
            d2 <= 1;
            d3 <= 1;

            digit_count <= 0;
        end

        //////////////////////////////////////////////////
        // FAIL DISPLAY
        //////////////////////////////////////////////////
        else if(alarm)
        begin
            d0 <= 9;
            d1 <= 9;
            d2 <= 9;
            d3 <= 9;

            digit_count <= 0;
        end

        //////////////////////////////////////////////////
        // KEY PRESS HANDLING
        //////////////////////////////////////////////////
        else if(key_valid && !key_valid_d)
        begin

            // CLEAR = F
            if(key_code == 4'd15)
            begin
                d0 <= 0;
                d1 <= 0;
                d2 <= 0;
                d3 <= 0;

                digit_count <= 0;
            end

            // ENTER = A (do nothing here)
            else if(key_code == 4'd10)
            begin
                digit_count <= 0;
            end

            // NORMAL DIGIT ENTRY (SHIFT STYLE FIX)
            else
            begin
                d3 <= d2;
                d2 <= d1;
                d1 <= d0;
                d0 <= key_code;

                if(digit_count < 4)
                    digit_count <= digit_count + 1;
            end

        end

    end

end

endmodule
