`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:53:53 04/21/2015 
// Design Name: 
// Module Name:    clkdiv9 
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

module clkdiv9(pixel_en,Clk,clock_lcd);

input Clk,pixel_en;
output reg clock_lcd;
parameter Divisor_DISP = 3;
parameter Bitcnt_DISP = 2;

   
reg [Bitcnt_DISP:0] Cnt_DISP; 


always @ (posedge Clk )
begin 
if (pixel_en==0) 
begin 
clock_lcd<=0; 
Cnt_DISP<=0; 
end 
else 
begin 
if(Cnt_DISP<(Divisor_DISP)) 
begin 
clock_lcd<=1; 
Cnt_DISP<=Cnt_DISP+1'b1; 
end 
else 
begin 
if(Cnt_DISP<((Divisor_DISP)*2)) 
begin 
clock_lcd<=0; 
Cnt_DISP<=Cnt_DISP+1'b1; 
end 
else 
begin 
clock_lcd<=1; 
Cnt_DISP<=1; 
end 
end 
end 
end 


endmodule
