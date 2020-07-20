// --------------------------------------------------------------------------------------------
// Nome do modulo: sigmoid
// Entradas:
// Saidas:
// Descriçao: Implementaçao de funçao sigmoid
// --------------------------------------------------------------------------------------------


module sigmoid(x, y);
	input signed [7:0]x;
	output reg signed [7:0]y;
	
	always @ (x) begin
		case (x)
		
			8'b1001_0000 : y <= 0;					// if x == -7 then y = 0
			8'b0000_0000 : y <= 8'b0000_1000;	// if x == 0 then y = 0.5
			8'b0111_0000 : y <= 8'b0001_0000;	// if x == 7 then y = 1
			
		endcase
	end
		

endmodule
