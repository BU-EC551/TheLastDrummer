`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:59:34 04/25/2015 
// Design Name: 
// Module Name:    axis 
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
module axis(input busy,interrupt,TP_DCLK,DOUT,clk,output reg DCLK_en,lcdoff,DIN,TP_CS,output reg [3:0]key,
output reg [11:0]xaxis,yaxis

    );

//reg [11:0]xaxis,yaxis;
reg [3:0]c,count;
reg x;
reg y;
reg x12,x11,x10,x9,x8,x7,x6,x5,x4,x3,x2,x1;
reg write;

initial begin 
TP_CS =1;

x=0;y=0;
count =4'b0;
DIN=0;
DCLK_en=0;
write =0;

end

always@(posedge clk)
begin
if(interrupt==0)begin
TP_CS=0;DCLK_en=1;end

end

always@(negedge TP_DCLK)
begin

count = count+1'b1;
case(count)
1:DIN = 1;
2:DIN = x;
3:DIN = 0;
4:DIN = 1;
5:DIN = 0;
6:DIN = 0;
7:DIN = 1;
8:DIN = 0;
9:DIN = 0;
10:;
11:;
12:;
13:;
14:;
15:begin count=0;x=x+1'b1;end
default:count=0;
endcase
end


always@(negedge TP_DCLK)
begin
if(busy)begin c=4'd11; y=1;lcdoff=1;end
if(y)begin
case(c)
11:begin x12 = DOUT; c =c-1'b1;end
10:begin x11 = DOUT; c =c-1'b1;end
9:begin x10 = DOUT; c =c-1'b1;end
8:begin x9 = DOUT; c =c-1'b1;end
7:begin x8 = DOUT; c =c-1'b1;end
6:begin x7 = DOUT; c =c-1'b1;end
5:begin x6 = DOUT; c =c-1'b1;end
4:begin x5 = DOUT; c =c-1'b1;end
3:begin x4 = DOUT; c =c-1'b1;end
2:begin x3 = DOUT; c =c-1'b1;end
1:begin x2 = DOUT; c =c-1'b1;end
0:begin x1 = DOUT; c =c-1'b1;end
15:begin if(write)xaxis ={x12,x11,x10,x9,x8,x7,x6,x5,x4,x3,x2,x1}; 
			else yaxis ={x12,x11,x10,x9,x8,x7,x6,x5,x4,x3,x2,x1};
			y=0;lcdoff=0;write=write+1'b1;end
default: xaxis =12'hfff;
endcase
end
else c=0;
end


always@(xaxis,yaxis)
begin
/////////////////////////black keys///////////////////////////////////////

if(yaxis>=12'h050 & yaxis <=12'h420)begin // 
if(xaxis >=12'h050 & xaxis <=12'h0d0 )
key=6;
else if(xaxis >=12'h0f0 & xaxis <=12'h180 )
	  key = 1;
     else if(xaxis >=12'h190 & xaxis <=12'h1d0 )
          key = 7;
          else if(xaxis >=12'h1e0 & xaxis <=12'h270 )
               key = 2;
               else if(xaxis >=12'h290 & xaxis <=12'h310 )
						  key = 8;
						  else if(xaxis >=12'h320 & xaxis <=12'h3a0 )
								 key =9;
								 else if(xaxis >=12'h3c0 & xaxis <=12'h450 )
										key =3;
										else if(xaxis >=12'h460 & xaxis <=12'h4a0 )
                                   key = 10;
											  else if(xaxis >=12'h4c0 & xaxis <=12'h540 )
                                        key = 4;
													 else if(xaxis >=12'h550 & xaxis <=12'h590 )
                                             key = 11;
															else if(xaxis >=12'h5b0 & xaxis <=12'h630 )
                                                  key = 5;
																  else if(xaxis >=12'h640 & xaxis <=12'h6d0 )
                                                       key = 12;
																		 else if(xaxis >=12'h6e0)
                                                             key = 13;
																				 else
																				 key = 0;
end

else
begin
	if(xaxis >=12'h040 & xaxis <=12'h130 )
	key =6;
	else if(xaxis >=12'h140 & xaxis <=12'h220 )
			key =7;
			else if(xaxis >=12'h230 & xaxis <=12'h300 )
               key = 8;
					else if(xaxis >=12'h320 & xaxis <=12'h400 )
                     key = 9;
							else if(xaxis >=12'h420 & xaxis <=12'h4f0 )
                          key = 10;
									else if(xaxis >=12'h510 & xaxis <=12'h5e0 )
                                 key = 11;
											else if(xaxis >=12'h600 & xaxis <=12'h6d0 )
                                       key = 12;
													else if(xaxis >=12'h6f0 )
                                             key =13;
															else key = 0;
end

end
endmodule
