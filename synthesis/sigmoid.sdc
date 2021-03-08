# Create virtual clocks 

create_clock -period 22 -name virtclk

# Set input and output delay

set_input_delay -clock [get_clocks virtclk] -max 5 [all_inputs]

set_output_delay -clock [get_clocks virtclk] -max 5 [all_outputs]