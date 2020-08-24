`timescale 1ns/1ps

module sigmoid_tb();
	// data types: inputs as registers and outputs as wires
	//inputs
  	reg [15:0]x_tb;
	//outputs
  	wire [15:0]y_tb;
	
	// other variables
	//reg [15:0]generated_results [65536:0];
  	reg [15:0]generated_results [5000:0];
	//reg [15:0]expected_results [65536:0];
  	shortreal expected_results [5000:0];
	integer error_count;
	reg [15:0]i;
	
	// test module
	sigmoid sigmoid_DUT (
		.x(x_tb),
    	.y(y_tb)
	);
	
	// stimulus
	
  	// salvando os valores gerados pelo DUT
  	initial begin
      	#10
      for (i = 16'b0000000000000000; i <= 16'b0001001110001000; i = i+1) begin	// 0 -> 5000
          $display("x_tb: %b",i);
			 x_tb = i;
			 #10
          $display("y_tb: %b", y_tb);
			 generated_results[i] = y_tb;
        	// fazer complemento, trazer para decimal pra comparar
  		end
      $stop;
   end
 
  // Calculando valores precisos
  
  initial begin
  	for (i = 16'b0000000000000000; i <= 16'b0001001110001000; i = i+1) begin
      expected_results[i] = 1/(1+(2.718**(-i)));
      $display("expected_results[i]: %b", expected_results[i]);
    end
  end
  
  // fazendo contagem de número de not matches
// 	initial begin
//      for (i = 0000000000000000; i <= 1111111111111111; i = i+1) begin
//        assert_result:
//          assert(generated_results[i] == expected_results[i])
//                else begin
//                    error_count++;
//                  $error("Error - output not match. Count: %d", error_count);
//                end
//      end
//	end
	
	
endmodule
