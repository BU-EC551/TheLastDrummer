`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:09:48 04/25/2015 
// Design Name: 
// Module Name:    touchclkdiv 
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
module touchclkdiv(input clk,DCLK_en,output reg TP_DCLK
    );

    


reg [6:0] count;
initial begin

count =0; end

always@(posedge clk)
begin
if(DCLK_en)begin
		if(count >=7'b1000000)
		TP_DCLK = 1;
		else TP_DCLK=0;
		count = count + 1'b1;			
		end
else
TP_DCLK=0;
end



endmodule
