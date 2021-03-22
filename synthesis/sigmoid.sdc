# Criando um clock virtual chamado "virtclk"

create_clock -period 22 -name virtclk

# Configurando delay de entrada e de saida

set_input_delay -clock [get_clocks virtclk] -max 5 [all_inputs]

set_output_delay -clock [get_clocks virtclk] -max 5 [all_outputs]