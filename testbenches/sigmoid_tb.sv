`timescale 1ns/1ps

module sigmoid_tb();
	// Tipos de dados: entradas como registradores e saidas como wires
	// entradas
  	reg [15:0]x_tb;
	// saidas
  	wire [15:0]y_tb;
	
	// variaveis para armazenar resultados
	shortreal generated_results [65536:0];
	shortreal expected_results [65536:0];
	reg [16:0] i;

	// variaveis da convercao para real
	reg [3:0] inteira;
	reg [11:0] fracionaria;
	int j, expo;
	shortreal converted, temp, temp2;

	// variaveis do calculo de valor exato e erro
	// a variavel "passo" gera entradas para sigmoide
	shortreal passo;
	int k;
	shortreal rmse_temp, RMSE, erro_absoluto, max_error;
	
	// modulo de teste
	sigmoid sigmoid_DUT (
		.x(x_tb),
    	.y(y_tb)
	);
	
	// estimulos
  	initial begin

		// convertendo para real os valores gerados pelo Design Under Test (DUT) e salvando
		fork

			// gerando todos os valores de teste para o DUT
			for (i = 17'b0000000000000000; i <= 17'b1111111111111111; i = i+1) begin

				// injetar sinal no DUT
				x_tb = i[15:0];

				$display("x_tb: %b", x_tb);

				#20

				// exibir saida do DUT
				$display("y_tb: %b", y_tb);
				
				// converter resultado de saida do DUT para decimal e salva em um vetor
				
				temp=0;
				expo = 1;

				// converter parte inteira extraindo parte correspondente
				inteira = y_tb[15:12];

				// converter parte fracionaria
				fracionaria = y_tb[11:0];
				//$display("fracionaria: %b", fracionaria);

				// da esquerda para a direita, ver se o bit eh 1, se sim, calcular 2^(posição do bit) e armazenar
				// se proximo bit eh 1, calcular novamente e somar ao resultado ja armazenado
				for (j = 11; j >= 0; j--) begin
					if (fracionaria[j] == 1)
						temp += shortreal'(1)/(2**(expo));
						expo ++;
						//$display("temp: %f", temp);
				end

				// somar parte inteira e fracionaria
				converted = inteira + temp;
				// guarda valor convertido em um vetor
				generated_results[i] = converted;
				$display("generated_results[%d]: %f", i, generated_results[i]);
			end
		join
		$stop;

		// calculando valor preciso e guardando em expected_results
		fork
			passo = -7.0;
			// com passo = 0.0002138 sao necessarias 65536 iteracoes para varer o intervalo [-7,+7]
			for (k=0; k <= 65536; k ++) begin
				expected_results[k] = 1.0/(1.0+(2.718**(-passo)));
				$display("expected_results[%d]: %f", k, expected_results[k]);
				passo += 0.0002138;
			end
			$stop;
		join

		// calcular as diferencas entre valor gerado e valor esperado
		fork
			// calculando para o primeiro intervalo
			j = 0;
			max_error = 0;
			for (k = 32768; k <= 65536; k++) begin
				temp = expected_results[k];
				temp2 = generated_results[j];

				erro_absoluto += (((temp2 - temp) / temp) < 0) ? -((temp2 - temp) / temp) : ((temp2 - temp) / temp);

				$display("erro_absoluto: %f", erro_absoluto);

				rmse_temp += ((temp - temp2)**2);

				//$display("rmse_temp: %f", rmse_temp);
				
				// calculando o erro maximo
				if ((temp2 - temp) > max_error)
					max_error = (temp2 - temp);

				j++;
			end

			// calculando para o segundo intervalo
			j = 65536;
			for (k = 32768; k >= 0; k--) begin
				temp = expected_results[k];
				temp2 = generated_results[j];

				erro_absoluto += (((temp - temp2)) < 0) ? -(temp - temp2) : (temp - temp2);

				$display("erro_absoluto: %f", erro_absoluto);

				rmse_temp += ((temp - temp2)**2);

				//$display("rmse_temp: %f", rmse_temp);
				
				// calculando o erro maximo
				if ((temp2 - temp) > max_error)
					max_error = (temp2 - temp);
				
				j--;
			end

			rmse_temp /= 65536;
			// calcular a raiz do erro medio
			RMSE = rmse_temp**0.5;
			$display("RMSE: %f", RMSE);

			// exibindo tambem o erro absoluto
			erro_absoluto /= 65536;
			$display("Erro absoluto: %f", erro_absoluto);
			
			// exibindo o erro maximo
			$display("Max_error: %f", max_error);
		join
	end

endmodule