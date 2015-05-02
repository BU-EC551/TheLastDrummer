`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:53:15 04/22/2015 
// Design Name: 
// Module Name:    startclk 
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
module startclk(input clk,output reg startclk
    );




reg [12:0] count;
initial begin

count =0; end

always@(posedge clk)
begin

		if(count >=13'b1000000000000)
		startclk = 1;
		else startclk=0;
		count = count + 1'b1;			
		

end



endmodule
/*integer count;

always@(posedge clk)
begin
count = count + 1;
if(count <4194304)
startclk = 0;
else if(count>=4194304 && count<8388608)
	  startclk = 1;
	  else
	  count =0;
			

end
endmodule*/
