`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:56:53 04/21/2015 
// Design Name: 
// Module Name:    main 
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
module main(input Clk,rst,output [7:0]data_RED,output [7:0]data_BLUE,output  [7:0]data_GREEN,
output DISP,TFT_en,DE_clk,clk_lcd,startclk,backlight/*,de_en,disp_en,led_en,rgb_en,pixel_en,flagh,flagv,
output [9:0]hcount_reg,output[8:0]Vcount_reg*/
  );
parameter [9:0]offset1 = 0;
parameter [9:0]offset2 = 60; 
parameter [9:0]offset3 = 120; 
parameter [9:0]offset4 = 180;
parameter [9:0]offset5 = 240;
parameter [9:0]offset6 = 300; 
parameter [9:0]offset7 = 360; 
parameter [9:0]offset8 = 420;
parameter [9:0]offset11 = 0;
parameter [9:0]offset12 = 80; 
parameter [9:0]offset13 = 140; 
parameter [9:0]offset14 = 180;
parameter [9:0]offset15 = 260;
parameter [9:0]offset16 = 320; 
parameter [9:0]offset17 = 380; 
parameter [9:0]offset18 = 420;
wire colorr,colorr1,colorr2,colorb,colorb1,colorb2,colorc,colorc1,colorc2;
wire de_en,disp_en,led_en,rgb_en,pixel_en,en_sync;
wire [9:0]hcount_reg;
wire [8:0]Vcount_reg;
wire  data_RED1, data_BLUE1, data_GREEN1,data_RED2, data_BLUE2, data_GREEN2,data_RED3, data_BLUE3, data_GREEN3,data_RED4, data_BLUE4, data_GREEN4,data_RED5, data_BLUE5, data_GREEN5, data_RED6, data_BLUE6, data_GREEN6,data_RED7, data_BLUE7
, data_GREEN7,data_RED8, data_BLUE8, data_GREEN8,data_RED12, data_BLUE12, data_GREEN12,data_RED13, data_BLUE13, data_GREEN13,data_RED14, data_BLUE14, data_GREEN14,data_RED15, data_BLUE15, data_GREEN15, data_RED16, data_BLUE16, data_GREEN16,data_RED17, data_BLUE17
, data_GREEN17,data_RED18, data_BLUE18, data_GREEN18,data_RED11, data_BLUE11, data_GREEN11;


assign colorr=data_RED1 ||data_RED2 ||data_RED3 ||data_RED4 ||data_RED5||data_RED6 ||data_RED7 ||data_RED8;
assign colorb=data_BLUE1 ||data_BLUE2 ||data_BLUE3 ||data_BLUE4 ||data_BLUE5||data_BLUE6 ||data_BLUE7 ||data_BLUE8;
assign colorc=data_GREEN1 ||data_GREEN2 ||data_GREEN3 ||data_GREEN4 ||data_GREEN5||data_GREEN6 ||data_GREEN7 ||data_GREEN8;
assign colorr1=data_RED11 ||data_RED12 ||data_RED13 ||data_RED14 ||data_RED15||data_RED16 ||data_RED17 ||data_RED18;
assign colorb1=data_BLUE11 ||data_BLUE12 ||data_BLUE13 ||data_BLUE14 ||data_BLUE15||data_BLUE16 ||data_BLUE17 ||data_BLUE18;
assign colorc1=data_GREEN11 ||data_GREEN12 ||data_GREEN13 ||data_GREEN14 ||data_GREEN15||data_GREEN16 ||data_GREEN17 ||data_GREEN18;
assign colorr2=colorr||colorr1;
assign colorb2=colorb||colorb1;
assign colorc2=colorc||colorc1;
assign data_RED = {8{colorr2}};
assign data_BLUE = {8{colorb2}};
assign data_GREEN = {8{colorc2}};

clkdivled c2(Clk,led_en,backlight); //Enable backlight 43 khz
clkdiv9 c1(pixel_en,Clk,clk_lcd);//9Mhz pixel clk
DE de2(de_en,clk_lcd,DE_clk);//DE clk for hsync and vsync
sync s1(disp_en,DE_clk,en_sync,clk_lcd,flagh, flagv, hcount_reg,Vcount_reg,DISP);

display d1(offset1,rgb_en,clk_lcd, flagv, flagh, data_RED1, data_BLUE1, data_GREEN1, hcount_reg,Vcount_reg);
display d2(offset2,rgb_en,clk_lcd, flagv, flagh, data_RED2, data_BLUE2, data_GREEN2, hcount_reg,Vcount_reg);
display d3(offset3,rgb_en,clk_lcd, flagv, flagh,data_RED3, data_BLUE3, data_GREEN3, hcount_reg,Vcount_reg);
display d4(offset4,rgb_en,clk_lcd, flagv, flagh, data_RED4, data_BLUE4, data_GREEN4, hcount_reg,Vcount_reg);
display d5(offset5,rgb_en,clk_lcd, flagv, flagh,data_RED5, data_BLUE5, data_GREEN5, hcount_reg,Vcount_reg);
display d6(offset6,rgb_en,clk_lcd, flagv, flagh, data_RED6, data_BLUE6, data_GREEN6, hcount_reg,Vcount_reg);
display d7(offset7,rgb_en,clk_lcd, flagv, flagh, data_RED7, data_BLUE7, data_GREEN7, hcount_reg,Vcount_reg);
display d8(offset8,rgb_en,clk_lcd, flagv, flagh,data_RED8, data_BLUE8, data_GREEN8, hcount_reg,Vcount_reg);
display1 d11(offset11,rgb_en,clk_lcd, flagv, flagh, data_RED11, data_BLUE11, data_GREEN11, hcount_reg,Vcount_reg);
display2 d12(offset12,rgb_en,clk_lcd, flagv, flagh, data_RED12, data_BLUE12, data_GREEN12, hcount_reg,Vcount_reg);
display1 d13(offset13,rgb_en,clk_lcd, flagv, flagh, data_RED13, data_BLUE13, data_GREEN13, hcount_reg,Vcount_reg);
display1 d14(offset14,rgb_en,clk_lcd, flagv, flagh, data_RED14, data_BLUE14, data_GREEN14, hcount_reg,Vcount_reg);
display2 d15(offset15,rgb_en,clk_lcd, flagv, flagh, data_RED15, data_BLUE15, data_GREEN15, hcount_reg,Vcount_reg);
display2 d16(offset16,rgb_en,clk_lcd, flagv, flagh, data_RED16, data_BLUE16, data_GREEN16, hcount_reg,Vcount_reg);
display1 d17(offset17,rgb_en,clk_lcd, flagv, flagh, data_RED17, data_BLUE17, data_GREEN17, hcount_reg,Vcount_reg);
display3 d18(offset18,rgb_en,clk_lcd, flagv, flagh, data_RED18, data_BLUE18, data_GREEN18, hcount_reg,Vcount_reg);

startclk sc1(Clk,startclk);
controlunit cu1(startclk,rst,TFT_en,de_en,disp_en,led_en,rgb_en,pixel_en,en_sync);

endmodule
