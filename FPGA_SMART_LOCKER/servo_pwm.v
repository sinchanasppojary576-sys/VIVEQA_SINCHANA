`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/22/2026 04:06:24 PM
// Design Name: 
// Module Name: servo_pwm
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns / 1ps

module servo_pwm(

    input clk,
    input rst,

    input unlock,

    output reg servo_pwm

);

parameter PERIOD = 480000;     // 20 ms @ 24MHz

parameter LOCK_POS   = 24000;  // 1 ms pulse
parameter UNLOCK_POS = 48000;  // 2 ms pulse

reg [18:0] counter;

always @(posedge clk)
begin

    if(rst)
    begin
        counter <= 0;
        servo_pwm <= 0;
    end
    else
    begin

        if(counter >= PERIOD-1)
            counter <= 0;
        else
            counter <= counter + 1;

        if(unlock)
        begin
            if(counter < UNLOCK_POS)
                servo_pwm <= 1'b1;
            else
                servo_pwm <= 1'b0;
        end
        else
        begin
            if(counter < LOCK_POS)
                servo_pwm <= 1'b1;
            else
                servo_pwm <= 1'b0;
        end

    end

end

endmodule
