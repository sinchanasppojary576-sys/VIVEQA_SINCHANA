# 4-Bit Synchronous Loadable Binary Up Counter

## Aim
To design and verify a 4-bit synchronous loadable binary up counter using Verilog HDL.

## Inputs
- clk : Clock
- rst : Reset
- ld  : Load control
- din : 4-bit parallel input

## Output
- count : 4-bit counter output

## Operation

1. rst = 1 → Counter resets to 0000
2. ld = 1 → Counter loads din
3. ld = 0 → Counter increments on every positive edge of clock

## Tools Used
- Verilog HDL
- Vivado Design Suite
- XSim Simulator
- Artix-7 FPGA
