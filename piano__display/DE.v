`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:34:08 04/21/2015 
// Design Name: 
// Module Name:    DE 
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
module DE(input de_en,Clk,output reg DE_clk);

	 
reg [9:0]count;
reg [8:0]c;

initial 
begin
count <=10'b0;
c<=9'b0;
end

always@(posedge Clk)
begin
if(de_en)begin


if(c<=9'd15)begin														
								count <= count +1'b1;
							   if(count < 10'd525)
								DE_clk <=0;
								else begin
								count<=10'b0; c<=c+1'b1;DE_clk<=0;end
								end

else begin
      if(c>=9'd16 && c<9'd288)begin														
								count <= count +1'b1;
							   if(count <= 10'd45)
								DE_clk <=0;
								else 
								begin
									if(count<10'd525 && count >= 10'd46)
									DE_clk<=1;
									else begin
									count<=10'b0; c<=c+1'b1;DE_clk<=0;end
								end
								end
		else c<=0;
end

end														
else DE_clk<=0;
end
endmodule
