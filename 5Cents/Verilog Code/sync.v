

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:54:32 04/21/2015 
// Design Name: 
// Module Name:    sync 
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

module sync(disp_en,de_clk,en_sync,clk_lcd,flagh, flagv, hcount_reg,Vcount_reg,DISP);

input  disp_en,en_sync, clk_lcd,de_clk; 
output reg  flagh, flagv,DISP; 
output reg [9:0] hcount_reg; 
output reg [8:0] Vcount_reg; 
reg  FLAG_H, FLAG_V; 
initial 
begin
hcount_reg<=0;
Vcount_reg<=0;
end
//Horizontal SYNC
always @(posedge clk_lcd)
begin
if(en_sync==0)
hcount_reg<=0;
else
begin
if  ((hcount_reg<479) & (de_clk)) 
hcount_reg<=hcount_reg+1'b1;
else 
hcount_reg<=0;
end
end

always@(posedge clk_lcd)
begin
if((hcount_reg>=0)&(hcount_reg<=479)) 
FLAG_H<=1;
else
FLAG_H<=0;
end


//Vertical SYNC
always@(posedge clk_lcd)
begin
if(en_sync==0)
Vcount_reg<=0;
else
begin
if(hcount_reg==479) 
if (Vcount_reg<271) 
begin
    Vcount_reg<=Vcount_reg+1'b1;
    if(Vcount_reg==271)
    Vcount_reg<=0;
 end
else
Vcount_reg<=0;
end
end

always@(posedge clk_lcd)
begin
if(Vcount_reg<272) 
		FLAG_V<=1;
		else
		FLAG_V<=0;
end

always@(posedge clk_lcd) 
begin

flagh<=FLAG_H; //display area
flagv<=FLAG_V;
end

//signal DISP
always@(posedge clk_lcd)
begin
if (disp_en)
DISP<=1;
else 
DISP<=0; 
end


endmodule

