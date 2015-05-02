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
module main(input sw1,Clk,rst,interrupt,DOUT,busy,output [7:0]data_RED,output [7:0]data_BLUE,output  [7:0]data_GREEN,
output TP_DCLK,TP_CS,DISP,TFT_en,DE_clk,clk_lcd,backlight,vga_h_sync,vga_v_sync,vga_R, vga_G, vga_B,DIN,
output [3:0]key,output speaker,gain,shutdown

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
parameter [9:0]offset18 = 450; 

wire colorr,colorr1,colorr2,colorb,colorb1,colorb2,colorc,colorc1,colorc2,lcdoff;
wire de_en,disp_en,led_en,rgb_en,pixel_en,en_sync,startclk,inDisplayArea,pixel_clk,DCLK_en;
wire [9:0]hcount_reg,CounterX;
wire [8:0]Vcount_reg,CounterY;
wire  data_RED1, data_BLUE1, data_GREEN1,data_RED2, data_BLUE2, data_GREEN2,data_RED3, data_BLUE3, data_GREEN3,data_RED4, data_BLUE4, data_GREEN4,data_RED5, data_BLUE5, data_GREEN5, data_RED6, data_BLUE6, data_GREEN6,data_RED7, data_BLUE7
, data_GREEN7,data_RED8, data_BLUE8, data_GREEN8,data_RED12, data_BLUE12, data_GREEN12,data_RED13, data_BLUE13, data_GREEN13,data_RED14, data_BLUE14, data_GREEN14,data_RED15, data_BLUE15, data_GREEN15, data_RED16, data_BLUE16, data_GREEN16,data_RED17, data_BLUE17
, data_GREEN17,data_RED18, data_BLUE18, data_GREEN18,data_RED11, data_BLUE11, data_GREEN11;
wire vga_R1, vga_G1, vga_B1,vga_R2, vga_G2, vga_B2,vga_R3, vga_G3, vga_B3,vga_R4, vga_G4, vga_B4,vga_R5, vga_G5, vga_B5,vga_R6, vga_G6, vga_B6;
wire[11:0]xaxis,yaxis;
assign shutdown = sw1;
assign gain=1;

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
assign vga_R=vga_R1||vga_R2||vga_R3||vga_R4||vga_R5||vga_R6;
assign vga_G=vga_G1||vga_G2||vga_G3||vga_G4||vga_G5||vga_G6;
assign vga_B=vga_B1||vga_B2||vga_B3||vga_B4||vga_B5||vga_B6;

vgaclk vc1(Clk,pixel_clk);//25Mhz clk
touchclkdiv t1(Clk,DCLK_en,TP_DCLK);//touchscreen DCLK ->1.56Mhz
clkdivled c2(Clk,led_en,backlight); //Enable backlight 43 khz
clkdiv9 c1(pixel_en,Clk,clk_lcd);//9Mhz pixel clk
DE de2(de_en,clk_lcd,DE_clk);//DE clk for hsync and vsync
axis a1(busy,interrupt,TP_DCLK,DOUT,Clk,DCLK_en,lcdoff,DIN,TP_CS,key,xaxis,yaxis);

vgasync vs1(vga_h_sync, vga_v_sync, inDisplayArea, CounterX, CounterY,pixel_clk);
vga v6(vga_R1, vga_G1, vga_B1, key,offset18, inDisplayArea, CounterX, CounterY, pixel_clk);
vga v1(vga_R2, vga_G2, vga_B2, xaxis[11:8],offset1, inDisplayArea, CounterX, CounterY, pixel_clk);
vga v2(vga_R3, vga_G3, vga_B3,xaxis[7:4],offset12, inDisplayArea, CounterX, CounterY, pixel_clk);
vga v3(vga_R4, vga_G4, vga_B4, xaxis[3:0],offset4, inDisplayArea, CounterX, CounterY, pixel_clk);
vga v4(vga_R5, vga_G5, vga_B5, yaxis[11:8],offset15, inDisplayArea, CounterX, CounterY, pixel_clk);
vga v5(vga_R6, vga_G6, vga_B6, yaxis[7:4],offset7, inDisplayArea, CounterX, CounterY, pixel_clk);




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
display3 d18(interrupt,rgb_en,clk_lcd, flagv, flagh, data_RED18, data_BLUE18, data_GREEN18, hcount_reg,Vcount_reg);

startclk sc1(Clk,startclk);
controlunit cu1(lcdoff,startclk,rst,TFT_en,de_en,disp_en,led_en,rgb_en,pixel_en,en_sync);
music music1(Clk,key,speaker);
endmodule
