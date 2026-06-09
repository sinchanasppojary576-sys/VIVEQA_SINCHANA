# 8x3 Priority Encoder

## Objective
Design and verify an 8x3 Priority Encoder using Structural Modeling in Verilog HDL.

## Tools Used
- Vivado Design Suite
- Verilog HDL
- Artix-7 FPGA

## Files Included
- priority_encoder_8x3.v
- priority_encoder_8x3_tb.v
- priority_encoder_waveform.png
- priority_encoder_schematic.png

## Description
An 8x3 Priority Encoder converts eight input lines into a 3-bit binary code. If multiple inputs are HIGH simultaneously, the highest-priority input is encoded.

Priority Order:
d7 > d6 > d5 > d4 > d3 > d2 > d1 > d0

## Result
The 8x3 Priority Encoder was successfully designed, simulated, and verified in Vivado.
