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

initial begin 
TP_CS =1;
c=4'd11;
x=0;
y=0;
count =4'b0;
DIN=0;
DCLK_en=0;
end

always@(posedge clk)
begin
if(interrupt==0)begin
TP_CS=0;DCLK_en=1;end
//else if(lcdoff==0)DCLK_en =0;


end

always@(negedge TP_DCLK)
begin
count = count+1'b1;
case(count)
1:DIN =1;
2:DIN = x;
3:DIN = 0;
4:DIN = 1;
5:DIN = 0;
6:DIN = 1;
7:DIN = 1;
8:DIN = 0;
9:DIN = 0;
10:;
11:;
12:;
13:;
14:;
15:count=0;
default:count=0;
endcase
x=x+1'b1;
end 



always@(negedge TP_DCLK)
begin
if(busy & TP_CS==0)begin c=4'd11; y=1;lcdoff=1;end
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
15:begin if(x)xaxis ={x12,x11,x10,x9,x8,x7,x6,x5,x4,x3,x2,x1}; 
			else yaxis ={x12,x11,x10,x9,x8,x7,x6,x5,x4,x3,x2,x1};
			y=0;lcdoff=0;end
default: xaxis =12'hfff;
endcase
end
else c=0;
end


always@(xaxis,yaxis)
begin
/////////////////////////black keys///////////////////////////////////////

if(yaxis>=12'h050 & yaxis <=12'h550)begin
if(xaxis >=12'h148 & xaxis <=12'h20b )
key=1;
else if(xaxis >=12'h295 & xaxis <=12'h345 )
	  key = 2;
     else if(xaxis >=12'h4f5 & xaxis <=12'h5b5 )
          key = 3;
          else if(xaxis >=12'h635 & xaxis <=12'h6e5 )
               key = 4;
               else if(xaxis >=12'h765 & xaxis <=12'h7f0 )
						  key = 5;
						  else if(xaxis >=12'h070 & xaxis <=12'h147 )
								 key =6;
								 else if(xaxis >=12'h21b & xaxis <=12'h285 )
										key =7;
										else if(xaxis >=12'h355 & xaxis <=12'h410 )
                                   key = 0;
											  else if(xaxis >=12'h5c5 & xaxis <=12'h625 )
                                        key = 10;
													 else if(xaxis >=12'h420 & xaxis <=12'h4e5 )
                                             key = 0;
															else if(xaxis >=12'h6f5 & xaxis <=12'h755 )
                                                  key = 11;
																  else if(xaxis >=12'h765 & xaxis <=12'h7f0 )
                                                       key = 12;
																		 else if(xaxis==12'h7ff )
                                                             key = 13;
																				 else
																				 key = 0;
end

else
begin
	if(xaxis >=12'h070 & xaxis <=12'h190 )
	key =6;
	else if(xaxis >=12'h1b0 & xaxis <=12'h2d0 )
			key =7;
			else if(xaxis >=12'h2f0 & xaxis <=12'h410 )
               key = 0;
					else if(xaxis >=12'h420 & xaxis <=12'h540 )
                     key = 0;
							else if(xaxis >=12'h550 & xaxis <=12'h670 )
                          key = 10;
									else if(xaxis >=12'h690 & xaxis <=12'h7a0 )
                                 key = 11;
											else if(xaxis >=12'h7b0 & xaxis <=12'h7f0 )
                                       key = 12;
													else if(xaxis ==12'h7ff )
                                             key = 13;
															else key = 0;
end

end
endmodule
