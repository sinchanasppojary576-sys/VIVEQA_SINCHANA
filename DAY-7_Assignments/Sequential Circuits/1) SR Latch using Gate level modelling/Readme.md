# SR Latch using Gate Level Modelling

## Aim
To design and verify an SR Latch using NOR gates in Verilog HDL.


## Description
The SR Latch is a basic sequential circuit used to store one bit of information. It is implemented using cross-coupled NOR gates.

## Truth Table

| S | R | Q(next) |
|---|---|---------|
| 0 | 0 | Hold |
| 0 | 1 | Reset |
| 1 | 0 | Set |
| 1 | 1 | Invalid |
