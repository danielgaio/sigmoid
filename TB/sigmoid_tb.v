`timescale 1ns/1ns

module sigmoid_tb();
	// data types: inputs as registers and outputs as wires
	reg x_tb;
	reg clk;
	reg [15:0] i;
	reg expected_y;
	
	wire y;
	
	// test module
	sigmoid test_circuit (
		.x(x_tb),
		.y(y)
	);
	
	// guarda dados de teste. 16 bits de largura, 50 elementos
	reg [15:0] testVector[49:0];
	
	// stimulus

	initial
	begin
		// le do txt e guarda em testVector
		$readmemb("TestbenchVector.txt", testVector);
		i = 0;
		x_tb = 0;
	end
	
	// extrai informaçoes de testVector
	always @(posedge clk)
	begin
		{x_tb} = testVector[i]; #10;
	end
	
	always @(negedge clk)
	begin
		if (expected_y !== y) begin
			$display("Saida errada para entrada %b, %b!=%b", x_tb, expected_y, y);
		end
		i = i + 1;
	end
	
	always
	begin
		clk <= 1; #5;
		clk <= 0; #5;
	end
	
endmodule
