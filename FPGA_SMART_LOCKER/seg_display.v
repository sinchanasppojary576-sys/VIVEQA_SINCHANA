`timescale 1ns / 1ps

module seg_display(

    input clk_24mhz,

    input [3:0] d0,
    input [3:0] d1,
    input [3:0] d2,
    input [3:0] d3,

    output reg seg_cs  = 1'b1,
    output reg seg_clk = 1'b0,
    output reg seg_din = 1'b0

);

////////////////////////////////////////////////////
// SPI CLOCK
////////////////////////////////////////////////////

reg [4:0] clk_div = 0;

wire spi_tick = (clk_div == 23);

always @(posedge clk_24mhz)
begin
    if(spi_tick)
        clk_div <= 0;
    else
        clk_div <= clk_div + 1;
end

////////////////////////////////////////////////////
// MAX7219 FSM
////////////////////////////////////////////////////

reg [5:0] state = 0;
reg [15:0] shift_reg = 0;
reg [2:0] cmd = 0;

always @(posedge clk_24mhz)
begin

    if(spi_tick)
    begin

        if(state == 0)
        begin

            seg_cs  <= 0;
            seg_clk <= 0;

            case(cmd)

                3'd0: shift_reg <= 16'h0C01;
                3'd1: shift_reg <= 16'h09FF;
                3'd2: shift_reg <= 16'h0A08;
                3'd3: shift_reg <= 16'h0B03;

                // DISPLAY ORDER
                // Register1 = leftmost
                // Register4 = rightmost

                3'd4: shift_reg <= {8'h01,4'h0,d3};
                3'd5: shift_reg <= {8'h02,4'h0,d2};
                3'd6: shift_reg <= {8'h03,4'h0,d1};
                3'd7: shift_reg <= {8'h04,4'h0,d0};

            endcase

            state <= 1;

        end

        else if(state <= 32)
        begin

            if(state[0])
            begin
                seg_clk <= 0;
                seg_din <= shift_reg[15];
            end

            else
            begin
                seg_clk <= 1;
                shift_reg <= {shift_reg[14:0],1'b0};
            end

            state <= state + 1;

        end

        else
        begin

            seg_cs <= 1;
            seg_clk <= 0;

            if(cmd < 7)
                cmd <= cmd + 1;
            else
                cmd <= 4;

            state <= 0;

        end

    end

end

endmodule
