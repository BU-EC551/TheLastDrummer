`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:16:03 04/21/2015 
// Design Name: 
// Module Name:    clkdivled 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module clkdivled(input clk,led_en,
    output reg clk_out
    
    );

reg [10:0] count;

always@(posedge clk)

begin
if(led_en)begin
		count = count + 1'b1;
		if(count >11'b10000000000)
			clk_out = 1;
		else
		   clk_out = 0;
			
end
end

endmodule
