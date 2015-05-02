`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:34:54 04/22/2015
// Design Name:   controlclk
// Module Name:   X:/Desktop/study material/ec551/project/lcd1/test_controlclk.v
// Project Name:  lcd1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: controlclk
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_controlclk;

	// Inputs
	reg Clk;

	// Outputs
	wire clk_out;

	// Instantiate the Unit Under Test (UUT)
	controlclk uut (
		.Clk(Clk), 
		.clk_out(clk_out)
	);

	initial begin
		// Initialize Inputs
		Clk = 0;
forever begin
#10 Clk = ~Clk;end
		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

