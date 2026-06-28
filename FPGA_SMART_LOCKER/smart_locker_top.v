`timescale 1ns / 1ps

module smart_locker_top(

    input clk_24mhz,

    input key0,
    input key1,
    input key2,
    input key3,

    input key4,
    input key5,
    input key6,
    input key7,

    input key8,
    input key9,
    input keyA,
    input keyB,

    input keyC,
    input keyD,
    input keyE,
    input keyF,

    output buzzer,

    output led_green,
    output led_red,

    output servo_out,

    output uart_tx_pin,
    input  uart_rx_pin,

    // MAX7219
    output seg_din,
    output seg_clk,
    output seg_cs

);

//////////////////////////////////////////////////
// RESET
//////////////////////////////////////////////////

wire rst;
assign rst = 1'b0;

//////////////////////////////////////////////////
// INTERNAL SIGNALS
//////////////////////////////////////////////////

wire [3:0] key_code;
wire key_valid;

wire unlock;
wire alarm;

wire uart_granted;
wire uart_denied;

wire tx_start;
wire [7:0] tx_data;
wire tx_busy;

wire [3:0] d0;
wire [3:0] d1;
wire [3:0] d2;
wire [3:0] d3;

//////////////////////////////////////////////////
// KEYPAD DECODER
//////////////////////////////////////////////////

keypad_decoder U1
(
    .clk(clk_24mhz),
    .rst(rst),

    .key0(key0),
    .key1(key1),
    .key2(key2),
    .key3(key3),

    .key4(key4),
    .key5(key5),
    .key6(key6),
    .key7(key7),

    .key8(key8),
    .key9(key9),
    .keyA(keyA),
    .keyB(keyB),

    .keyC(keyC),
    .keyD(keyD),
    .keyE(keyE),
    .keyF(keyF),

    .key_code(key_code),
    .key_valid(key_valid)
);

//////////////////////////////////////////////////
// PASSWORD FSM
//////////////////////////////////////////////////

password_fsm U2
(
    .clk(clk_24mhz),
    .rst(rst),

    .key_code(key_code),
    .key_valid(key_valid),

    .unlock(unlock),
    .alarm(alarm),

    .uart_granted(uart_granted),
    .uart_denied(uart_denied)
);

//////////////////////////////////////////////////
// BUZZER
//////////////////////////////////////////////////

buzzer_controller U3
(
    .clk(clk_24mhz),
    .rst(rst),

    .unlock(unlock),
    .alarm(alarm),

    .buzzer(buzzer)
);

//////////////////////////////////////////////////
// UART MESSAGE
//////////////////////////////////////////////////

uart_message U4
(
    .clk(clk_24mhz),
    .rst(rst),

    .uart_granted(uart_granted),
    .uart_denied(uart_denied),

    .tx_busy(tx_busy),

    .tx_start(tx_start),
    .tx_data(tx_data)
);

//////////////////////////////////////////////////
// UART TX
//////////////////////////////////////////////////

uart_tx U5
(
    .clk(clk_24mhz),
    .rst(rst),

    .tx_start(tx_start),
    .tx_data(tx_data),

    .tx(uart_tx_pin),
    .tx_busy(tx_busy)
);

//////////////////////////////////////////////////
// SERVO
//////////////////////////////////////////////////

servo_pwm U6
(
    .clk(clk_24mhz),
    .rst(rst),

    .unlock(unlock),

    .servo_pwm(servo_out)
);

//////////////////////////////////////////////////
// PASSWORD DISPLAY
//////////////////////////////////////////////////

password_display U7
(
    .clk(clk_24mhz),
    .rst(rst),

    .key_code(key_code),
    .key_valid(key_valid),

    .unlock(unlock),
    .alarm(alarm),

    .d0(d0),
    .d1(d1),
    .d2(d2),
    .d3(d3)
);

//////////////////////////////////////////////////
// MAX7219 DISPLAY DRIVER
//////////////////////////////////////////////////

seg_display U8
(
    .clk_24mhz(clk_24mhz),

    .d0(d0),
    .d1(d1),
    .d2(d2),
    .d3(d3),

    .seg_din(seg_din),
    .seg_clk(seg_clk),
    .seg_cs(seg_cs)
);

//////////////////////////////////////////////////
// LEDS
//////////////////////////////////////////////////

assign led_green = unlock;
assign led_red   = alarm;

endmodule
