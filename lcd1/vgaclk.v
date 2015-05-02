`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:48:45 04/25/2015 
// Design Name: 
// Module Name:    vgaclk 
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
module vgaclk(   input clk,
    output reg pixel_clk
 
    );


reg [1:0] count;


always @(posedge clk)
begin
count <= count + 1'b1;
if (count > 2'b10)
pixel_clk <= 1;
else
pixel_clk <= 0;
end

endmodule