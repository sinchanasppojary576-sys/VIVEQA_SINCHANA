`timescale 1ns / 1ps

module uart_tx(

    input clk,
    input rst,

    input tx_start,
    input [7:0] tx_data,

    output reg tx,
    output reg tx_busy

);

//////////////////////////////////////////////////
// 24 MHz Clock
// 9600 Baud
//////////////////////////////////////////////////

parameter CLKS_PER_BIT = 2500;

reg [12:0] baud_counter;
reg [3:0] bit_index;

reg [9:0] tx_shift;

always @(posedge clk)
begin

    if(rst)
    begin

        tx <= 1'b1;
        tx_busy <= 1'b0;

        baud_counter <= 13'd0;
        bit_index <= 4'd0;

        tx_shift <= 10'b1111111111;

    end

    else
    begin

        ////////////////////////////////////////////
        // Start Transmission
        ////////////////////////////////////////////

        if(tx_start && !tx_busy)
        begin

            tx_busy <= 1'b1;

            tx_shift <= {
                1'b1,      // Stop Bit
                tx_data,   // Data Bits
                1'b0       // Start Bit
            };

            baud_counter <= 13'd0;
            bit_index <= 4'd0;

        end

        ////////////////////////////////////////////
        // Transmitting
        ////////////////////////////////////////////

        else if(tx_busy)
        begin

            if(baud_counter >= CLKS_PER_BIT-1)
            begin

                baud_counter <= 13'd0;

                tx <= tx_shift[0];

                tx_shift <= {
                    1'b1,
                    tx_shift[9:1]
                };

                if(bit_index >= 4'd9)
                begin

                    tx_busy <= 1'b0;
                    tx <= 1'b1;

                end

                bit_index <= bit_index + 1'b1;

            end

            else
            begin

                baud_counter <= baud_counter + 1'b1;

            end

        end

        ////////////////////////////////////////////
        // Idle
        ////////////////////////////////////////////

        else
        begin

            tx <= 1'b1;

        end

    end

end

endmodule
