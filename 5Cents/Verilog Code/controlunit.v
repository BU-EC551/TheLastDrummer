`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:09:53 04/21/2015 
// Design Name: 
// Module Name:    controlunit 
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

module controlunit(lcdoff,clk_out,rst,TFT_en,de_en,disp_en,led_en,rgb_en,pixel_en,en_sync);

input lcdoff,clk_out,rst;
output reg TFT_en,de_en,disp_en,led_en,rgb_en,pixel_en,en_sync;


reg [3:0] S;

parameter idle=0,S1=1,S2=2,S3=3,S4=4,S5=5,S6=6,S7=7;

initial begin
pixel_en=0;en_sync=0;
S=S1;

end


//LCD CONTROL UNIT
always @(negedge clk_out)
begin
if(rst) S=idle;
else begin
case (S)
S1: begin S=S2; TFT_en =1; end
S2: begin S=S3; de_en =1; rgb_en=1;pixel_en=1;en_sync=1; disp_en =1;end
S3: begin S=idle;led_en=1;end
idle:if(lcdoff)
	  begin
		de_en =0; rgb_en=0;pixel_en=0;en_sync=0;disp_en =0;
		S=S4;
		end
		else 
		S=S1;
S4:begin S=S6;TFT_en =0;end
S6:begin S=idle;end
default: S=idle;
endcase
end
end



endmodule
