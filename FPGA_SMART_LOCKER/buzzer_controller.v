`timescale 1ns / 1ps

module buzzer_controller(

    input clk,
    input rst,

    input unlock,
    input alarm,

    output reg buzzer

);

//////////////////////////////////////////////////
// 24 MHz Clock
//////////////////////////////////////////////////

parameter SHORT_BEEP_TIME = 1200000; // 50 ms

reg [21:0] beep_counter;
reg [21:0] alarm_counter;

reg unlock_d;

always @(posedge clk)
begin

    if(rst)
    begin
        buzzer        <= 1'b0;
        beep_counter  <= 22'd0;
        alarm_counter <= 22'd0;
        unlock_d      <= 1'b0;
    end

    else
    begin

        unlock_d <= unlock;

        //////////////////////////////////////////////
        // Detect Rising Edge of Unlock
        //////////////////////////////////////////////

        if(unlock && !unlock_d)
        begin
            beep_counter <= SHORT_BEEP_TIME;
        end

        //////////////////////////////////////////////
        // Correct Password Beep
        //////////////////////////////////////////////

        if(beep_counter > 0)
        begin

            beep_counter <= beep_counter - 1;
            buzzer <= 1'b1;

        end

        //////////////////////////////////////////////
        // Wrong Password Alarm
        //////////////////////////////////////////////

        else if(alarm)
        begin

            alarm_counter <= alarm_counter + 1;

            // Generate square wave
            buzzer <= alarm_counter[15];

        end

        //////////////////////////////////////////////
        // Idle
        //////////////////////////////////////////////

        else
        begin

            buzzer <= 1'b0;
            alarm_counter <= 22'd0;

        end

    end

end

endmodule
