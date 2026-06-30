# ####################################################################

#  Created by Genus(TM) Synthesis Solution 21.10-p002_1 on Sun Jun 28 12:52:47 -03 2026

# ####################################################################

set sdc_version 2.0

set_units -capacitance 1000fF
set_units -time 1000ps

# Set the current design
current_design spi_top

create_clock -name "clk" -period 10.0 -waveform {0.0 5.0} [get_ports clk]
set_clock_gating_check -setup 0.0 
set_input_delay -clock [get_clocks clk] -add_delay 1.0 [get_ports write_en]
set_input_delay -clock [get_clocks clk] -add_delay 1.0 [get_ports read_en]
set_input_delay -clock [get_clocks clk] -add_delay 1.0 [get_ports {addr[2]}]
set_input_delay -clock [get_clocks clk] -add_delay 1.0 [get_ports {addr[1]}]
set_input_delay -clock [get_clocks clk] -add_delay 1.0 [get_ports {addr[0]}]
set_input_delay -clock [get_clocks clk] -add_delay 1.0 [get_ports {write_data[7]}]
set_input_delay -clock [get_clocks clk] -add_delay 1.0 [get_ports {write_data[6]}]
set_input_delay -clock [get_clocks clk] -add_delay 1.0 [get_ports {write_data[5]}]
set_input_delay -clock [get_clocks clk] -add_delay 1.0 [get_ports {write_data[4]}]
set_input_delay -clock [get_clocks clk] -add_delay 1.0 [get_ports {write_data[3]}]
set_input_delay -clock [get_clocks clk] -add_delay 1.0 [get_ports {write_data[2]}]
set_input_delay -clock [get_clocks clk] -add_delay 1.0 [get_ports {write_data[1]}]
set_input_delay -clock [get_clocks clk] -add_delay 1.0 [get_ports {write_data[0]}]
set_input_delay -clock [get_clocks clk] -add_delay 1.0 [get_ports spi_miso]
set_output_delay -clock [get_clocks clk] -add_delay 1.0 [get_ports {read_data[7]}]
set_output_delay -clock [get_clocks clk] -add_delay 1.0 [get_ports {read_data[6]}]
set_output_delay -clock [get_clocks clk] -add_delay 1.0 [get_ports {read_data[5]}]
set_output_delay -clock [get_clocks clk] -add_delay 1.0 [get_ports {read_data[4]}]
set_output_delay -clock [get_clocks clk] -add_delay 1.0 [get_ports {read_data[3]}]
set_output_delay -clock [get_clocks clk] -add_delay 1.0 [get_ports {read_data[2]}]
set_output_delay -clock [get_clocks clk] -add_delay 1.0 [get_ports {read_data[1]}]
set_output_delay -clock [get_clocks clk] -add_delay 1.0 [get_ports {read_data[0]}]
set_output_delay -clock [get_clocks clk] -add_delay 1.0 [get_ports spi_sclk]
set_output_delay -clock [get_clocks clk] -add_delay 1.0 [get_ports spi_mosi]
set_output_delay -clock [get_clocks clk] -add_delay 1.0 [get_ports spi_cs_n]
set_wire_load_mode "enclosed"
