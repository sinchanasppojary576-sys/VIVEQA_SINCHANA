# T Flip-Flop using D Flip-Flop

## Aim
To design and verify a T Flip-Flop using a D Flip-Flop in Verilog HDL.

## Working

The T Flip-Flop is implemented using a D Flip-Flop with:

D = T XOR Q

When T = 0, the output holds its state.
When T = 1, the output toggles on every positive clock edge.

## Truth Table

| T | Q(next) |
|---|---------|
| 0 | Q |
| 1 | ~Q |
