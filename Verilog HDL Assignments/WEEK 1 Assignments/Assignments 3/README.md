# VIVEQA_VERILOG_HDL_FIRSTWEEK_ASSIGNMENT3

Negative Edge Detector

Objective

To design and simulate a negative edge detector using Verilog HDL.

Theory

A negative edge detector generates a pulse when the input signal transitions from logic 1 to logic 0.

Transition Detection:

* 0 → 1 : No pulse generated
* 1 → 0 : Pulse generated

Design Method

The previous value of the input signal is stored using a flip-flop.

The current input is compared with the delayed input to detect a falling edge.

Condition for pulse generation:

Pulse = Previous_Input AND NOT(Current_Input)

Simulation

The design was verified using a Verilog testbench.

The waveform shows that a pulse is generated only when the input changes from HIGH to LOW.

Results

* Falling edge successfully detected.
* Pulse generated only during 1 → 0 transition.
* No pulse generated during 0 → 1 transition.

Files Included

* neg_edge_detector.v
* neg_edge_detector_tb.v
* waveform.png
* sythesis_schematic.png
* Elaborated_schematic.png

Conclusion

The negative edge detector was successfully implemented and verified using simulation. The output pulse is generated only during the falling edge of the input signal.
