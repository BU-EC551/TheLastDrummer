`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:35:10 03/25/2015 
// Design Name: 
// Module Name:    pwm 
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
module pwm(clk, speaker);
input clk;
output reg speaker;

reg [23:0] counter = 0;
reg [9:0] hz =0 ;
always @(posedge clk) 
begin
	if(counter==16777215) counter = 0; 
	else counter = counter+1;
case (counter[23])
	1'b 1:	begin if (hz==1023) hz =0; else hz = hz+1; end
	1'b 0:  hz = hz;	
		
endcase
 if(counter[23]==0) speaker = 0 ;
 else speaker = 1;
end
endmodule
