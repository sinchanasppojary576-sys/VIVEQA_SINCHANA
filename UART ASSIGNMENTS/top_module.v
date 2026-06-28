`timescale 1ns / 1ps

module uart_button_led_top(

    input clk,
    input rst,

    input [15:0] buttons,

    input uart_rx,
    output uart_tx,

    output [7:0] leds

);


wire [7:0] ascii_char;
wire button_valid;

wire tx_busy;
reg  tx_start;
reg  [7:0] tx_data;

wire [7:0] rx_data;
wire rx_done;

reg [15:0] buttons_d;


reg [7:0] name_mem [0:7];

initial
begin
    name_mem[0] = "S";
    name_mem[1] = "i";
    name_mem[2] = "n";
    name_mem[3] = "c";
    name_mem[4] = "h";
    name_mem[5] = "a";
    name_mem[6] = "n";
    name_mem[7] = "a";
end

reg sending_name;
reg [2:0] char_index;


button_decoder u_decoder(
    .buttons(buttons),
    .ascii_char(ascii_char),
    .valid(button_valid)
);

uart_tx u_tx(

    .clk(clk),
    .rst(rst),

    .tx_start(tx_start),
    .tx_data(tx_data),

    .tx(uart_tx),
    .tx_busy(tx_busy)

);

uart_rx u_rx(

    .clk(clk),
    .rst(rst),

    .rx(uart_rx),

    .rx_data(rx_data),
    .rx_done(rx_done)

);


led_controller u_led(

    .clk(clk),
    .rst(rst),

    .rx_done(rx_done),
    .rx_data(rx_data),

    .leds(leds)

);

always @(posedge clk or posedge rst)
begin

    if(rst)
    begin
        buttons_d    <= 16'h0000;
        tx_start     <= 1'b0;
        tx_data      <= 8'h00;
        sending_name <= 1'b0;
        char_index   <= 3'd0;
    end

    else
    begin

        tx_start <= 1'b0;

       
        if((buttons != 16'h0000) &&
           (buttons_d == 16'h0000) &&
           button_valid &&
           !sending_name)
        begin
            sending_name <= 1'b1;
            char_index   <= 3'd0;
        end

    

        if(sending_name && !tx_busy)
        begin

            tx_data  <= name_mem[char_index];
            tx_start <= 1'b1;

            if(char_index == 3'd7)
            begin
                sending_name <= 1'b0;
            end
            else
            begin
                char_index <= char_index + 1'b1;
            end

        end

        buttons_d <= buttons;

    end

end

endmodule
