// --------------------------------------------------------------------------------------------
// Nome do modulo: sigmoid
// Entradas:
// Saidas:
// Descriçao: Implementaçao de funçao sigmoid
// Fonte do codigo: https://github.com/andywag/NeuralHDL/tree/master/tests/sigmoid/design
// --------------------------------------------------------------------------------------------


module sigmoid(x, y);
	input [16:0]x;
	output reg [16:0]y;

	
	always @ (x) begin
		case (x)
			(x < -7):
				y <= 0;
				
			(x == 0):
				y <= 0.5;
				
			(x > 7):
				y <= 1;
			
			default:
				y <= 0;
			
		endcase
	end
	
endmodule