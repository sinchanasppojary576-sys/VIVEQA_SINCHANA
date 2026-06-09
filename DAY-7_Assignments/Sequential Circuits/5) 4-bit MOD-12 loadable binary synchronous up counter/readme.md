# 4-Bit MOD-12 Loadable Binary Synchronous Up Counter

## Aim
To design and verify a 4-bit MOD-12 loadable binary synchronous up counter using Verilog HDL.

## Inputs
- clk : Clock
- rst : Reset
- ld  : Load control
- din : 4-bit load input

## Output
- count : 4-bit counter output

## Operation

- rst = 1 → count = 0
- ld = 1 → count = din
- ld = 0 → counter increments
- After reaching 11, counter returns to 0

## Count Sequence

0 → 1 → 2 → 3 → 4 → 5 → 6 → 7 → 8 → 9 → 10 → 11 → 0
