###################################################
# CLOCK (24 MHz)
###################################################

set_property PACKAGE_PIN D13 [get_ports clk_24mhz]
set_property IOSTANDARD LVCMOS33 [get_ports clk_24mhz]

create_clock -name clk24 -period 41.667 [get_ports clk_24mhz]


###################################################
# KEYPAD INPUTS (16 KEYS)
###################################################

set_property PACKAGE_PIN A13 [get_ports key0]
set_property PACKAGE_PIN F5  [get_ports key1]
set_property PACKAGE_PIN E3  [get_ports key2]
set_property PACKAGE_PIN F2  [get_ports key3]

set_property PACKAGE_PIN A12 [get_ports key4]
set_property PACKAGE_PIN D6  [get_ports key5]
set_property PACKAGE_PIN D3  [get_ports key6]
set_property PACKAGE_PIN F3  [get_ports key7]

set_property PACKAGE_PIN A5  [get_ports key8]
set_property PACKAGE_PIN C6  [get_ports key9]
set_property PACKAGE_PIN D4  [get_ports keyA]
set_property PACKAGE_PIN F4  [get_ports keyB]

set_property PACKAGE_PIN B6  [get_ports keyC]
set_property PACKAGE_PIN B5  [get_ports keyD]
set_property PACKAGE_PIN C4  [get_ports keyE]
set_property PACKAGE_PIN E5  [get_ports keyF]

set_property IOSTANDARD LVCMOS33 [get_ports {key0 key1 key2 key3 key4 key5 key6 key7 key8 key9 keyA keyB keyC keyD keyE keyF}]


###################################################
# LED INDICATORS
###################################################

set_property PACKAGE_PIN R2 [get_ports led_green]
set_property IOSTANDARD LVCMOS33 [get_ports led_green]

set_property PACKAGE_PIN N3 [get_ports led_red]
set_property IOSTANDARD LVCMOS33 [get_ports led_red]


###################################################
# BUZZER OUTPUT
###################################################

set_property PACKAGE_PIN K5 [get_ports buzzer]
set_property IOSTANDARD LVCMOS33 [get_ports buzzer]


###################################################
# SERVO PWM OUTPUT
# (PMOD IO0)
###################################################

set_property PACKAGE_PIN F12 [get_ports servo_out]
set_property IOSTANDARD LVCMOS33 [get_ports servo_out]


###################################################
# UART TX → ESP32-C3 / ESP32-CAM RX
# (PMOD IO1)
###################################################

set_property PACKAGE_PIN R3 [get_ports uart_tx_pin]
set_property IOSTANDARD LVCMOS33 [get_ports uart_tx_pin]


###################################################
# UART RX (OPTIONAL)
# (PMOD IO2)
###################################################

set_property PACKAGE_PIN T3 [get_ports uart_rx_pin]
set_property IOSTANDARD LVCMOS33 [get_ports uart_rx_pin]


###################################################
# MAX7219 7-SEG DISPLAY (SPI STYLE)
###################################################

# DIN
set_property PACKAGE_PIN J15 [get_ports seg_din]
set_property IOSTANDARD LVCMOS33 [get_ports seg_din]

# CLK
set_property PACKAGE_PIN H12 [get_ports seg_clk]
set_property IOSTANDARD LVCMOS33 [get_ports seg_clk]

# CS / LOAD
set_property PACKAGE_PIN J16 [get_ports seg_cs]
set_property IOSTANDARD LVCMOS33 [get_ports seg_cs]


###################################################
# OPTIONAL SAFETY (RECOMMENDED)
###################################################

# Pull default UART idle HIGH behavior is handled in RTL,
# but hardware pullups are recommended if board supports:
# set_property PULLUP true [get_ports uart_rx_pin]
