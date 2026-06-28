`timescale 1ns / 1ps

module keypad_decoder(

    input clk,
    input rst,

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

    output reg [3:0] key_code,
    output reg key_valid

);

reg key0_d,key1_d,key2_d,key3_d,key4_d,key5_d,key6_d,key7_d;
reg key8_d,key9_d,keyA_d,keyB_d,keyC_d,keyD_d,keyE_d,keyF_d;

always @(posedge clk)
begin

    if(rst)
    begin
        key_code  <= 4'd0;
        key_valid <= 1'b0;

        key0_d <= 1'b0;
        key1_d <= 1'b0;
        key2_d <= 1'b0;
        key3_d <= 1'b0;
        key4_d <= 1'b0;
        key5_d <= 1'b0;
        key6_d <= 1'b0;
        key7_d <= 1'b0;
        key8_d <= 1'b0;
        key9_d <= 1'b0;
        keyA_d <= 1'b0;
        keyB_d <= 1'b0;
        keyC_d <= 1'b0;
        keyD_d <= 1'b0;
        keyE_d <= 1'b0;
        keyF_d <= 1'b0;
    end

    else
    begin

        key_valid <= 1'b0;

        if(key0 && !key0_d)
        begin
            key_code <= 4'd0;
            key_valid <= 1'b1;
        end
        else if(key1 && !key1_d)
        begin
            key_code <= 4'd1;
            key_valid <= 1'b1;
        end
        else if(key2 && !key2_d)
        begin
            key_code <= 4'd2;
            key_valid <= 1'b1;
        end
        else if(key3 && !key3_d)
        begin
            key_code <= 4'd3;
            key_valid <= 1'b1;
        end
        else if(key4 && !key4_d)
        begin
            key_code <= 4'd4;
            key_valid <= 1'b1;
        end
        else if(key5 && !key5_d)
        begin
            key_code <= 4'd5;
            key_valid <= 1'b1;
        end
        else if(key6 && !key6_d)
        begin
            key_code <= 4'd6;
            key_valid <= 1'b1;
        end
        else if(key7 && !key7_d)
        begin
            key_code <= 4'd7;
            key_valid <= 1'b1;
        end
        else if(key8 && !key8_d)
        begin
            key_code <= 4'd8;
            key_valid <= 1'b1;
        end
        else if(key9 && !key9_d)
        begin
            key_code <= 4'd9;
            key_valid <= 1'b1;
        end
        else if(keyA && !keyA_d)
        begin
            key_code <= 4'd10;
            key_valid <= 1'b1;
        end
        else if(keyB && !keyB_d)
        begin
            key_code <= 4'd11;
            key_valid <= 1'b1;
        end
        else if(keyC && !keyC_d)
        begin
            key_code <= 4'd12;
            key_valid <= 1'b1;
        end
        else if(keyD && !keyD_d)
        begin
            key_code <= 4'd13;
            key_valid <= 1'b1;
        end
        else if(keyE && !keyE_d)
        begin
            key_code <= 4'd14;
            key_valid <= 1'b1;
        end
        else if(keyF && !keyF_d)
        begin
            key_code <= 4'd15;
            key_valid <= 1'b1;
        end

        key0_d <= key0;
        key1_d <= key1;
        key2_d <= key2;
        key3_d <= key3;
        key4_d <= key4;
        key5_d <= key5;
        key6_d <= key6;
        key7_d <= key7;
        key8_d <= key8;
        key9_d <= key9;
        keyA_d <= keyA;
        keyB_d <= keyB;
        keyC_d <= keyC;
        keyD_d <= keyD;
        keyE_d <= keyE;
        keyF_d <= keyF;

    end

end

endmodule
