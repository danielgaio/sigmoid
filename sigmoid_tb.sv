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
	reg [16:0] i;

	// variáveis da converção para real
	reg [3:0] inteira;
	reg [11:0] fracionaria;
	int j, expo;
	shortreal converted, temp, temp2;

	// variáveis do calculo de valor exato e erro
	// a variavel "passo" gera entradas para sigmoide
	shortreal passo;
	int k;
	shortreal rmse_temp, RMSE, erro_absoluto, max_error;
	
	// test module
	sigmoid sigmoid_DUT (
		.x(x_tb),
    	.y(y_tb)
	);
	
	// stimulus
  	initial begin

/*
		// sessão para fazer testes com valores especificos
		fork
			//x_tb = 16'b1000_101110000101; //-7.28
			//x_tb = 16'b1011_100111101100; //-4.38
			//x_tb = 16'b1101_010011001101; -2.7
			//x_tb = 16'b1111_110001111011; //-0.22
			//x_tb = 16'b0000_101110000101; 0.72
			//x_tb = 16'b0001_101100110011; 1.7
			//x_tb = 16'b0101_000000000000; 5
			//x_tb = 16'b0111_001100110011; //7.2
			x_tb = 16'b1111_011111101110; // [-0.75, -0.5]
			#20
			$display("y_tb: %b", y_tb);
		join
*/

		// Convertendo p real os valores gerados pelo DUT e salvando
		fork

			// gerando todos os valores de teste para o DUT
			for (i = 17'b0000000000000000; i <= 17'b1111111111111111; i = i+1) begin

				// injeta sinal no DUT
				x_tb = i[15:0];

				$display("x_tb: %b", x_tb);

				#20

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
				//$display("fracionaria: %b", fracionaria);

				// da esquerda para a direita, ver se o bit é 1, se sim, calcular 2^(posição do bit) e armazenar
				// se próximo bit é 1, calcular e somar ao resultado armazenado
				for (j = 11; j >= 0; j--) begin
					if (fracionaria[j] == 1)
						temp += shortreal'(1)/(2**(expo));
						expo ++;
						//$display("temp: %f", temp);
				end

				// somar parte inteira e fracionária
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
			// com passo = 0.0002138 são necessárias 65536 iterações para varer [-7,+7]
			for (k=0; k <= 65536; k ++) begin
				expected_results[k] = 1.0/(1.0+(2.718**(-passo)));
				$display("expected_results[%d]: %f", k, expected_results[k]);
				passo += 0.0002138;
			end
			$stop;
		join

		// calcular as diferenças entre valor gerado e valor esperado
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

			// exibindo também o erro absoluto
			erro_absoluto /= 65536;
			$display("Erro absoluto: %f", erro_absoluto);
			
			// exibindo o erro maximo
			$display("Max_error: %f", max_error);
		join
	end

endmodule
