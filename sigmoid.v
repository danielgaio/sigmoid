module sigmoid (x, y);
	input signed [15:0]x;
	output reg signed [15:0]y;
	
	reg x_temp;
	
	// Bloco para fazer o complemento de -0.5
	always @ (*) begin
		if (x[15:12] == 4'b1111) begin	// fazer complemento
				// inverter bits de x
				x_temp <= ~x;
				// somar 1
				x_temp <= x_temp + 1;
		end
	end
	
	
	
	always @ (*) begin
		
		if (x == 16'b0000_000000000000)
			y <= 16'b0000_100000000000;
		else if ((x < 16'b1001_100000000000) && (x >= 16'b1001_000000000000))	//if (x < -6.5 && x >= -7)
			y <= 16'b0000_000000000000;
		else if ((x < 16'b1010_000000000000) && (x >= 16'b1001_100000000000))	//if (x < -6 && x >= -6.5)
			y <= 16'b0000_000000000110;
		else if ((x < 16'b1010_100000000000) && (x >= 16'b1010_000000000000))	//if (x < -5.5 && x >= -6)
			y <= 16'b0000_000000001010;
		else if ((x < 16'b1011_000000000000) && (x >= 16'b1010_100000000000))	//if (x < -5 && x >= -5.5)
			y <= 16'b0000_000000010001;
		else if ((x < 16'b1011_100000000000) && (x >= 16'b1011_000000000000))	//if (x < -4.5 && x >= -5)
			y <= 16'b0000_000000011011;
		else if ((x < 16'b1100_000000000000) && (x >= 16'b1011_100000000000))	//if (x < -4 && x >= -4.5)
			y <= 16'b0000_000000101101;
		else if ((x < 16'b1100_100000000000) && (x >= 16'b1100_000000000000))	//if (x < -3.5 && x >= -4)
			y <= 16'b0000_000001001010;
		else if ((x < 16'b1101_000000000000) && (x >= 16'b1100_100000000000))	//if (x < -3 && x >= -3.5)
			y <= 16'b0000_000001111000;
		else if ((x < 16'b1101_100000000000) && (x >= 16'b1101_000000000000))	//if (x < -2.5 && x >= -3)
			y <= 16'b0000_000011000010;
		else if ((x < 16'b1110_000000000000) && (x >= 16'b1101_100000000000))	//if (x < -2 && x >= -2.5)
			y <= 16'b0000_000101000010;
		else if ((x < 16'b1110_100000000000) && (x >= 16'b1110_000000000000))	//if (x < -1.5 && x >= -2)
			y <= 16'b0000_000111101000;
		else if ((x < 16'b1111_000000000000) && (x >= 16'b1110_100000000000))	//if (x < -1 && x >= -1.5)
			y <= 16'b0000_001011101011;	// d
		else if ((x < 16'b1111_100000000000) && (x >= 16'b1111_000000000000))	//if (x < -0.5 && x >= -1)
			y <= 16'b0000_010001001110;	// c
		
		
		
		else if ((x > 16'b0000_000000000000) && (x <= 16'b0000_100000000000))	// if(x > 0 && x <= 0.5)
			y <= 16'b0000_100111110110;
		else if ((x > 16'b0000_100000000000) && (x <= 16'b0001_000000000000))
			y <= 16'b0000_101110110010;
		else if ((x > 16'b0001_000000000000) && (x <= 16'b0001_100000000000))
			y <= 16'b0000_110100010101;
		else if ((x > 16'b0001_100000000000) && (x <= 16'b0010_000000000000))
			y <= 16'b0000_111000011000;
		else if ((x > 16'b0010_000000000000) && (x <= 16'b0010_100000000000))
			y <= 16'b0000_111011001001;
		else if ((x > 16'b0010_100000000000) && (x <= 16'b0011_000000000000))
			y <= 16'b0000_111100111110;
		else if ((x > 16'b0011_000000000000) && (x <= 16'b0011_100000000000))
			y <= 16'b0000_111110001000;
		else if ((x > 16'b0011_100000000000) && (x <= 16'b0100_000000000000))
			y <= 16'b0000_111110110110;
		else if ((x > 16'b0100_000000000000) && (x <= 16'b0100_100000000000))
			y <= 16'b0000_111111010011;
		else if ((x > 16'b0100_100000000000) && (x <= 16'b0101_000000000000))
			y <= 16'b0000_111111100101;
		else if ((x > 16'b0101_000000000000) && (x <= 16'b0101_100000000000))
			y <= 16'b0000_111111101111;
		else if ((x > 16'b0101_100000000000) && (x <= 16'b0110_000000000000))
			y <= 16'b0000_111111110110;
		else if ((x > 16'b0110_000000000000) && (x <= 16'b0110_100000000000))
			y <= 16'b0000_111111111010;
		else if ((x > 16'b0110_100000000000) && (x <= 16'b0111_000000000000))
			y <= 16'b0001_000000000000;
		else if ((x > 16'b0000_000000000000) && (x_temp <= 16'b0000_100000000000))		//if (x > 0 && x <= 0.5) feito o complemento
			y <= 16'b0000_011000001010;
		else if (x < 16'b1001_000000000000)														//if x < -7: y = 0
			y <= 16'b0000_000000000000;
		else																								//if x > +7: y = 1
			y <= 16'b0001_000000000000;
		
	end

endmodule
