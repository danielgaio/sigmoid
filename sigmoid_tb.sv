`timescale 1ns/1ps

module sigmoid_tb();
	// data types: inputs as registers and outputs as wires
	//inputs
  	reg [15:0]x_tb;
	//outputs
  	wire [15:0]y_tb;
	
	// other variables
	reg unsigned [15:0]generated_results 		[65536:0];
	reg unsigned [15:0]generated_results_deci 	[65536:0];// talvez conv para shortreal
	shortreal	   expected_results 		[65536:0];
	reg unsigned [15:0]i;
	reg unsigned [15:0]j;
	
	// test module
	sigmoid sigmoid_DUT (
		.x(x_tb),
    		.y(y_tb)
	);
	
	// stimulus

	function int to_real(reg [15:0]a);
		// fazer complemento
		shortreal aux;
		$display("a: %b", a);
		aux = a >> 12;				// 2� - divide por 2^12
							// ambos numerador e denominador
							// precisar ser tipo real
		$display("aux shortreal: %d", aux);
    		return aux;
  	endfunction
	
  	// salvando os valores gerados pelo DUT
  	initial begin
//	fork
//		$display("dentro do primeiro initial");
//      		for (i = 16'b0000000000000000; i <= 16'b1111111111111111; i = i+1) begin
//          		$display("x_tb: %b",i);
//			x_tb = i;
//			#10
//          		$display("y_tb: %b", y_tb);
//			generated_results[i] = y_tb;
//			$display("generated_results[%d]: %b", i, generated_results[i]);
//        		// fazer complemento, trazer para decimal pra comparar
//			generated_results_deci[i] = to_real(generated_results[i]);
//			$display("generated_results_deci[%d]: %f", i, generated_results_deci[i]);
//			// to_real e que converte de Q4.12 o tipo real
//  		end
//	join

	fork
		i = 16'b0000000000000000;
		expected_results[0] = 1/(1+(2.718**(-i)));
      		$display("expected_results[0]: %f", expected_results[0]);
		i = 1;
		expected_results[1] = 1/(1+(2.718**(i)));
      		$display("expected_results[1]: %f", expected_results[1]);
	join
	// CONTINUAR ...
	fork
		// Calculando valores precisos
  		//for (i = -'d8, j = 0; i <= 8, j <= 65536; i += 0.1, j++) begin
      			//expected_results[j] = 1/(1+(2.718**(-i)));
      			//$display("expected_results[%d]: %f - i= %f", j, expected_results[j], i);
    		//end
		
	join
	$finish;
   	end

  
  // fazendo contagem de numero de not matches
// 	initial begin
//      for (i = 0000000000000000; i <= 1111111111111111; i = i+1) begin
//        assert_result:
//          assert(generated_results[i] == expected_results[i])
//                else begin
//                  $error("Error - output not match. Count: %d", error_count);
//                end
//      end
//	end
	
	
endmodule
