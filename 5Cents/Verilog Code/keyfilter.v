`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:12:37 04/30/2015 
// Design Name: 
// Module Name:    keyfilter 
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
module keyfilter(input TP_DCLK,input [3:0]key,output reg[3:0]pianokey
    );
reg [8:0]count;
reg [3:0]temp;
reg [8:0] dif_cur ;
initial begin
count =0;
dif_cur=0;
pianokey=0;
end

always@(negedge TP_DCLK)
begin
if(count==0)begin temp = key; count=count+1'b1;end
else
begin
dif_cur = temp - key;
if(count<63)count=count+1'b1; //for 50 cycles
else begin count = 0;  end
end                                                                                                                                                                                                          
end

always@(negedge TP_DCLK)
begin
if(count==62 & dif_cur==0)
	pianokey = key; 
else if(count==62)pianokey=0;
end 

endmodule

