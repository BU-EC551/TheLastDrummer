`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:28:19 04/27/2015
// Design Name:   main
// Module Name:   X:/Desktop/study material/ec551/project/lcd1/test_main.v
// Project Name:  lcd1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: main
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_main;

	// Inputs
	reg Clk;
	reg rst;
	reg interrupt;
	reg DOUT;
	reg busy;

	// Outputs
	wire [7:0] data_RED;
	wire [7:0] data_BLUE;
	wire [7:0] data_GREEN;
	wire TP_DCLK;
	wire TP_CS;
	wire DISP;
	wire TFT_en;
	wire DE_clk;
	wire clk_lcd;
	wire backlight;
	wire busybit;
	wire i;
	wire vga_h_sync;
	wire vga_v_sync;
	wire vga_R;
	wire vga_G;
	wire vga_B;
	wire DIN;
	wire Dclk_en;
	wire [3:0]count;

	// Instantiate the Unit Under Test (UUT)
	main uut (
		.Clk(Clk), 
		.rst(rst), 
		.interrupt(interrupt), 
		.DOUT(DOUT), 
		.busy(busy), 
		.data_RED(data_RED), 
		.data_BLUE(data_BLUE), 
		.data_GREEN(data_GREEN), 
		.TP_DCLK(TP_DCLK), 
		.TP_CS(TP_CS), 
		.DISP(DISP), 
		.TFT_en(TFT_en), 
		.DE_clk(DE_clk), 
		.clk_lcd(clk_lcd), 
		.backlight(backlight), 
		.busybit(busybit), 
		.i(i), 
		.vga_h_sync(vga_h_sync), 
		.vga_v_sync(vga_v_sync), 
		.vga_R(vga_R), 
		.vga_G(vga_G), 
		.vga_B(vga_B), 
		.DIN(DIN), 
		.Dclk_en(Dclk_en),
		.count(count) 
	);

	initial begin
		// Initialize Inputs
		Clk = 0;
		rst = 0;
		interrupt = 0;
		DOUT = 1;
		busy = 0;
forever
#10 Clk = ~Clk;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

