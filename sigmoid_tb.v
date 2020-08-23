`timescale 1ns/1ps

module sigmoid_tb();
	// data types: inputs as registers and outputs as wires
  	reg [15:0]x_tb;
	reg [15:0] i;
	
  	wire [15:0]y_tb;
	
	// test module
	sigmoid sigmoid_dut (
		.x(x_tb),
    	.y(y_tb)
	);
	
	// stimulus
	
  	initial begin
  		for (i = 0000000000000000; i <= 1111111111111111; i = i+1) begin
      		$display("%b",i);
  		end
    end
  
	
	
endmodule
