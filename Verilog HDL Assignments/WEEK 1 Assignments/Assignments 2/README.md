# VIVEQA_VERILOG_HDL_FIRSTWEEK_ASSIGNMENT2

Parameterized Delay Module

Objective

To implement a parameterized delay module in Verilog HDL and analyze FPGA resource utilization for different delay values.

Description

A parameterized shift register is used to generate programmable delays. The parameter M determines the number of delay stages.

The design was synthesized for different values of M to observe how FPGA resources change with increasing delay length.

Parameters Tested

* M = 10
* M = 20
* M = 100

Resource Utilization

Delay (M)	LUTs	LUTRAM	Flip-Flops	I/O
10	      1     	1     	2	         3
20	      1      	1     	2        	 3
100	      4	      4	      2	         3

Observation

The parameter M controls the number of delay stages in the shift register.

As the delay value increases, the size of the shift register increases, resulting in higher FPGA resource utilization. Larger delay values require more LUT and LUTRAM resources.

Result

The parameterized delay module was successfully synthesized and verified for different values of M.

Conclusion

The synthesis results show that FPGA resource utilization increases with increasing delay length. Parameterized designs provide flexibility while allowing analysis of hardware resource requirements.
