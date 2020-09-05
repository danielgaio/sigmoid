`timescale 1ns/1ps

module sigmoid_tb();
	// data types: inputs as registers and outputs as wires
	//inputs
  	reg [15:0]x_tb;
	//outputs
  	wire [15:0]y_tb;
	
	// other variables
	shortreal generated_results [65536:0];
	shortreal expected_results [65536:0];
	reg [16:0]i;

	// variáveis da converção para real
	reg [3:0] inteira;
	reg [11:0] fracionaria;
	int j, expo;
	shortreal converted, temp;
	
	// test module
	sigmoid sigmoid_DUT (
		.x(x_tb),
    	.y(y_tb)
	);
	
	// stimulus

	/*pronto--
  	// Convertendo p real os valores gerados pelo DUT e salvando
  	initial begin
		fork
			// gerando todos os valores de teste para o DUT
			for (i = 16'b0000000000000000; i <= 16'b1111111111111111; i = i+1) begin
				$display("-");
				$display("x_tb: %b",i);

				// injeta sinal no DUT
				x_tb = i;

				#10

				// Exibe saida do DUT
				$display("y_tb: %b", y_tb);
				
				// converter resultado saida DUT para decimal e salva em um vetor
				
				temp=0;
				expo = 1;

				// converter parte inteira
				// extrai parte corresopndente
				inteira = y_tb[15:12];

				// converter parte fracionaria
				fracionaria = y_tb[11:0];
				$display("fracionaria: %b", fracionaria);

				// da esquerda para a direita, ver se o bit é 1, se sim, calcular 2^(posição do bit) e armazenar
				// se próximo bit é 1, calcular e somar ao resultado armazenado
				for (j = 11; j >= 0; j--) begin
					if (fracionaria[j] == 1)
						temp += shortreal'(1)/(2**(expo));
						expo ++;
						$display("temp: %f", temp);
				end

				// somar parte inteira e fracionária
				converted = inteira + temp;
				// guarda valor convertido em um vetor
				generated_results[i] = converted;
				$display("generated_results[%d]: %f", i, generated_results[i]);
			end
		join
	pronto--*/

	// calculando valor preciso e guardando em expected_results
	// a variavel "passo" gera entradas para sigmoide
	shortreal passo;
	int k;
	initial begin
		fork
			passo = -8.0;
			for (k=0; k <= 250; k ++) begin
				expected_results[k] = 1.0/(1.0+(2.718**(-passo)));
				$display("expected_results[%d]: %f", k, expected_results[k]);
				passo += 0.1;
			end
			$stop;
		join
	end

endmodule
