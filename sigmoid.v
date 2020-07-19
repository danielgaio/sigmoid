// --------------------------------------------------------------------------------------------
// Nome do modulo: sigmoid
// Entradas:
// Saidas:
// Descriçao: Implementaçao de funçao sigmoid
// Fonte do codigo: https://github.com/andywag/NeuralHDL/tree/master/tests/sigmoid/design
// --------------------------------------------------------------------------------------------


module sigmoid(x, y);
	input signed [31:0]x;
	output reg signed [31:0]y;
	
	always @ (x) begin
		case (x)
		
			-7 : y <= 0;
			0 : y <= 0.5;
			7 : y <= 1;
			
		endcase
	end
		

endmodule
