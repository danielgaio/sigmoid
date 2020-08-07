module sigmoid_tb();
	// data types: inputs as registers and outputs as wires
	reg x;
	wire y;
	
	// test module
	sigtest test_circuit (
		.x(x),
		.y(y)
	);
	
	// stimulus
	
	
endmodule
