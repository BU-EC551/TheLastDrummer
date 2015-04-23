`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:25:54 04/22/2015
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

	// Outputs
	wire [7:0] data_RED;
	wire [7:0] data_BLUE;
	wire [7:0] data_GREEN;
	wire DISP;
	wire TFT_en;
	wire DE_clk;
	wire clk_lcd;
	wire startclk;
	wire backlight;
	wire de_en,disp_en,led_en,rgb_en,pixel_en,flagh,flagv;
	wire [9:0]hcount_reg;
	wire[8:0]Vcount_reg;
	// Instantiate the Unit Under Test (UUT)
	main uut (
		.Clk(Clk), 
		.rst(rst), 
		.data_RED(data_RED), 
		.data_BLUE(data_BLUE), 
		.data_GREEN(data_GREEN), 
		.DISP(DISP), 
		.TFT_en(TFT_en), 
		.DE_clk(DE_clk), 
		.clk_lcd(clk_lcd), 
		.startclk(startclk),
		.backlight(backlight),
		.de_en(de_en),
		.disp_en(disp_en),
		.led_en(led_en),
		.rgb_en(rgb_en),
		.pixel_en(pixel_en),
		.flagh(flagh),
		.flagv(flagv),
		.hcount_reg(hcount_reg),
		.Vcount_reg(Vcount_reg)
	);

	initial begin

		Clk = 0;
		rst = 0;
		
		 forever
		begin
		 #10 Clk=  ~Clk;
	
			end

     end   
		// Add stimulus here

	
      
endmodule

