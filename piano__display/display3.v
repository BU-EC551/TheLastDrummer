`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:55:20 04/21/2015 
// Design Name: 
// Module Name:    display 
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

module display3(offset,rgb_en,clk_lcd, flagv, flagh, data_RED, data_BLUE, data_GREEN, hcount_reg,Vcount_reg);
				
input clk_lcd,flagh, flagv,rgb_en; 
input  [9:0] hcount_reg,offset;
input [8:0]Vcount_reg;
output reg  data_RED, data_BLUE;
output reg  data_GREEN;
reg  RED, BLUE;
reg  GREEN; 
wire Data_out;


initial
begin
data_RED<=0; 
data_BLUE<=0; 
data_GREEN<=0; 

end




// AND between flagh y flagv
assign Data_out=(flagh&flagv);



always @(posedge clk_lcd)
begin
if(Data_out)
if(hcount_reg>=(0+offset) && hcount_reg<(58+offset))begin
		if(Vcount_reg>=0 && Vcount_reg<272)
		begin
		RED<=1; 
		BLUE<=1; 
		GREEN<=1;
		end
     end

else begin
RED<=0; 
BLUE<=0; 
GREEN<=0;
end 

end

								
								
//Output sync  
always@(posedge clk_lcd) 
begin 
if(rgb_en)begin
data_RED<=RED; 
data_BLUE<=BLUE; 
data_GREEN<=GREEN; 
end 
end
endmodule
