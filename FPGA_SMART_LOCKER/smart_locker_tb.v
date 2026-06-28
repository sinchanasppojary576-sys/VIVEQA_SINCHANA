`timescale 1ns/1ps

module smart_locker_tb;

reg clk_24mhz;

reg key0,key1,key2,key3;
reg key4,key5,key6,key7;
reg key8,key9,keyA,keyB;
reg keyC,keyD,keyE,keyF;

wire buzzer;
wire led_green;
wire led_red;
wire servo_out;
wire uart_tx_pin;
wire seg_din;
wire seg_clk;
wire seg_cs;

//////////////////////////////////////////////////
// DUT
//////////////////////////////////////////////////

smart_locker_top DUT
(
    .clk_24mhz(clk_24mhz),

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

    .buzzer(buzzer),

    .led_green(led_green),
    .led_red(led_red),

    .servo_out(servo_out),

    .uart_tx_pin(uart_tx_pin),
    .uart_rx_pin(1'b1),

    .seg_din(seg_din),
    .seg_clk(seg_clk),
    .seg_cs(seg_cs)
);

//////////////////////////////////////////////////
// 24 MHz CLOCK
//////////////////////////////////////////////////

initial
    clk_24mhz = 0;

always
    #21 clk_24mhz = ~clk_24mhz;

//////////////////////////////////////////////////
// INITIALIZE KEYS
//////////////////////////////////////////////////

initial begin

    key0=0; key1=0; key2=0; key3=0;
    key4=0; key5=0; key6=0; key7=0;
    key8=0; key9=0; keyA=0; keyB=0;
    keyC=0; keyD=0; keyE=0; keyF=0;

end

//////////////////////////////////////////////////
// FORCE INTERNALS
//////////////////////////////////////////////////

initial begin

    force DUT.U2.entered_pass = 16'd0;
    force DUT.U2.digit_count  = 3'd0;
    force DUT.U2.unlock       = 1'b0;
    force DUT.U2.alarm        = 1'b0;
    force DUT.U2.timer        = 28'd0;
    force DUT.U2.key_valid_d  = 1'b0;

    force DUT.U3.buzzer        = 1'b0;
    force DUT.U3.beep_counter  = 22'd0;
    force DUT.U3.alarm_counter = 22'd0;
    force DUT.U3.unlock_d      = 1'b0;

    repeat(10) @(posedge clk_24mhz);

    release DUT.U2.entered_pass;
    release DUT.U2.digit_count;
    release DUT.U2.unlock;
    release DUT.U2.alarm;
    release DUT.U2.timer;
    release DUT.U2.key_valid_d;

    release DUT.U3.buzzer;
    release DUT.U3.beep_counter;
    release DUT.U3.alarm_counter;
    release DUT.U3.unlock_d;

end

//////////////////////////////////////////////////
// KEY TASKS
//////////////////////////////////////////////////

task hit_0;
begin
    key0=1;
    repeat(30000) @(posedge clk_24mhz);
    key0=0;
    repeat(30000) @(posedge clk_24mhz);
end
endtask

task hit_1;
begin
    key1=1;
    repeat(30000) @(posedge clk_24mhz);
    key1=0;
    repeat(30000) @(posedge clk_24mhz);
end
endtask

task hit_2;
begin
    key2=1;
    repeat(30000) @(posedge clk_24mhz);
    key2=0;
    repeat(30000) @(posedge clk_24mhz);
end
endtask

task hit_3;
begin
    key3=1;
    repeat(30000) @(posedge clk_24mhz);
    key3=0;
    repeat(30000) @(posedge clk_24mhz);
end
endtask

task hit_4;
begin
    key4=1;
    repeat(30000) @(posedge clk_24mhz);
    key4=0;
    repeat(30000) @(posedge clk_24mhz);
end
endtask

task hit_5;
begin
    key5=1;
    repeat(30000) @(posedge clk_24mhz);
    key5=0;
    repeat(30000) @(posedge clk_24mhz);
end
endtask

task hit_7;
begin
    key7=1;
    repeat(30000) @(posedge clk_24mhz);
    key7=0;
    repeat(30000) @(posedge clk_24mhz);
end
endtask

task hit_A;
begin
    keyA=1;
    repeat(30000) @(posedge clk_24mhz);
    keyA=0;
    repeat(30000) @(posedge clk_24mhz);
end
endtask

//////////////////////////////////////////////////
// TEST SEQUENCE
//////////////////////////////////////////////////

initial begin

    repeat(1000) @(posedge clk_24mhz);

    //////////////////////////////////////////////
    // CORRECT PASSWORD = 0145A
    //////////////////////////////////////////////

    hit_0;
    hit_1;
    hit_4;
    hit_5;
    hit_A;

    wait(led_green == 1'b1);

    $display("CORRECT PASSWORD ACCEPTED");

    wait(led_green == 1'b0);

    $display("UNLOCK PERIOD COMPLETE");

    repeat(10000) @(posedge clk_24mhz);

    //////////////////////////////////////////////
    // WRONG PASSWORD = 1237A
    //////////////////////////////////////////////

    hit_1;
    hit_2;
    hit_3;
    hit_7;
    hit_A;

    wait(led_red == 1'b1);

    $display("WRONG PASSWORD DETECTED");

    wait(led_red == 1'b0);

    $display("ALARM PERIOD COMPLETE");

    repeat(10000) @(posedge clk_24mhz);

    $finish;

end

endmodule
