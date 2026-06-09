# 4-Bit Loadable Binary Synchronous Up-Down Counter

## Aim
To design and verify a 4-bit loadable binary synchronous up-down counter using Verilog HDL.

## Inputs
- clk : Clock
- rst : Reset
- ld  : Load
- ud  : Up/Down Control
- din : 4-bit Parallel Input

## Output
- count : 4-bit Counter Output

## Operation

- rst = 1 → Reset counter
- ld = 1 → Load din into counter
- ud = 1 → Count Up
- ud = 0 → Count Down

## Tools Used
- Verilog HDL
- Vivado Design Suite
- XSim Simulator
- Artix-7 FPGA
