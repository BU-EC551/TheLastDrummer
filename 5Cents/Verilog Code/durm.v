// Music demo verilog file
// Plays a little tune on a speaker
// (c) fpga4fun.com 2003-2014

/////////////////////////////////////////////////////
module music(
	input sysclk,  // tested with 25MHz
	input [3:0]drum,
	output reg [3:0] led,
	output reg speaker,  // connect to a speaker
	output reg gain,
	output reg shutdown
);

reg clk;
parameter [3:0] N = 4'd4;

reg drum1_ack = 1'd0;
reg drum2_ack = 1'd0;
reg drum3_ack = 1'd0;
reg drum4_ack = 1'd0;
reg [10:0]drum1_count;
reg [12:0]drum2_count;
reg [12:0]drum3_count;
reg [13:0]drum4_count;
reg [12:0]correction_count3;
reg [12:0]correction_count4;
reg [3:0] pos_cnt;
reg [3:0] neg_cnt;

//reg [3:0]count_drum1_main=4'd0;

always @ ( posedge sysclk )
begin		
pos_cnt <= (pos_cnt + 1'b1) % N ;
end

always @ (posedge sysclk)
begin
neg_cnt <= (neg_cnt + 1'b1) % N  ;
end

always @( sysclk )
begin
if ( (N%2) == 1'b0)
clk <= ( pos_cnt >= (N/2)) ? 1'b1 : 1'b0;
else
clk <= (( pos_cnt > (N/2)) || ( neg_cnt > (N/2))) ? 1'b1 : 1'b0;
end
 

reg [30:0] tone;
always @(drum) 
begin 
	
	led[0] = drum[0];
	led[1] = drum[1];
	led[2] = drum[2];
	led[3] = drum[3];
	
end

wire [7:0] fullnote;
music_ROM ROM(.clk(clk), .address(tone[29:22]), .note(fullnote) , .drum(drum));


wire [2:0] octave;
wire [3:0] note;
divide_by12 divby12(.numer(fullnote[5:0]), .quotient(octave), .remain(note));

reg [8:0] clkdivider;
always @*
case(note)

	0: clkdivider = 9'd511;//A
	1: clkdivider = 9'd482;// A#/Bb
	2: clkdivider = 9'd455;//B
	3: clkdivider = 9'd430;//C
	4: clkdivider = 9'd405;// C#/Db
	5: clkdivider = 9'd383;//D
	6: clkdivider = 9'd361;// D#/Eb
	7: clkdivider = 9'd341;//E
	8: clkdivider = 9'd322;//F
	9: clkdivider = 9'd303;// F#/Gb
	10: clkdivider = 9'd286;//G
	11: clkdivider = 9'd270;// G#/Ab
	default: clkdivider = 9'd0;// should never happen

endcase

reg [8:0] counter_note;
always @(posedge clk) if(counter_note==0) counter_note <= clkdivider; else counter_note <= counter_note-9'd1;

reg [7:0] counter_octave;
always @(posedge clk)

if(counter_note==0)
begin
	if(counter_octave==0)
	counter_octave <= (octave==0 ? 8'd255 : octave==1 ? 8'd127 : octave==2 ? 8'd63 : octave==3 ? 8'd31 : octave==4 ? 8'd15 : 8'd7);
else
	counter_octave <= counter_octave-8'd1;
	
end

always @(posedge clk)
begin

gain = 1'b1;
shutdown = 1'b1;

if (drum[0] == 1)
	drum1_ack = 1'd1;

if (drum1_count!=11'd2047)
	drum1_count = drum1_count + 1;
	
	else
begin
	drum1_ack = 1'd0;
	drum1_count = 11'd0;
end

	/////////////////// for drum 2 starts here
if (drum[1] == 1)
	drum2_ack = 1'd1;

if (drum2_count!=13'd8191)
	drum2_count = drum2_count + 1;
	
	else
begin
	drum2_ack = 1'd0;
	drum2_count = 13'd0;
end

	////////////////////////  for drum 3 starts here
	if (drum[2] == 1 && correction_count3 == 13'd8191)
	begin
	drum3_ack = 1'd1;
	//correction_count3 = 13'd0;
	end
	else 
	correction_count3 = correction_count3 + 1;
	
if (drum3_count!=13'd8191)
	drum3_count = drum3_count + 1;
	
	else
begin
	drum3_ack = 1'd0;
	drum3_count = 13'd0;
end
	/////////////////////////////	 for drum 4 starts here
	if (drum[3] == 1 && correction_count4 == 13'd8191)
	begin
	drum4_ack = 1'd1;
	//correction_count4 = 13'd0;
	end
	else 
	correction_count4 = correction_count4 + 1;
	
if (drum4_count!=14'd16383)
	drum4_count = drum4_count + 1;
	
	else
begin
	drum4_ack = 1'd0;
	drum4_count = 14'd0;
end
///////////////////////////////////////////////////////////////////
if((counter_octave==0 && counter_note==0) && ((drum1_ack == 1) || (drum2_ack == 1) || (drum3_ack == 1) || 
(drum4_ack == 1)))
	speaker <= ~speaker;
	
end
 
endmodule


/////////////////////////////////////////////////////

module divide_by12(numer, quotient, remain);
input [5:0] numer;
output [2:0] quotient;
output [3:0] remain;

reg [2:0] quotient;
reg [1:0] remainder3to2;
always @(numer[5:2])
case(numer[5:2])
	 0: begin quotient=0; remainder3to2=0; end
	 1: begin quotient=0; remainder3to2=1; end
	 2: begin quotient=0; remainder3to2=2; end
	 3: begin quotient=1; remainder3to2=0; end
	 4: begin quotient=1; remainder3to2=1; end
	 5: begin quotient=1; remainder3to2=2; end
	 6: begin quotient=2; remainder3to2=0; end
	 7: begin quotient=2; remainder3to2=1; end
	 8: begin quotient=2; remainder3to2=2; end
	 9: begin quotient=3; remainder3to2=0; end
	10: begin quotient=3; remainder3to2=1; end
	11: begin quotient=3; remainder3to2=2; end
	12: begin quotient=4; remainder3to2=0; end
	13: begin quotient=4; remainder3to2=1; end
	14: begin quotient=4; remainder3to2=2; end
	15: begin quotient=5; remainder3to2=0; end
endcase

assign remain[1:0] = numer[1:0];// the first 2 bits are copied through
assign remain[3:2] = remainder3to2;// and the last 2 bits come from the case statement
endmodule
/////////////////////////////////////////////////////



module music_ROM(
	input clk,
	input [7:0] address,
	input [3:0]drum,
	output reg [7:0] note
);


reg [3:0]drum_ack = 4'd0;

reg [3:0]drum1_count;
reg [15:0]delay = 16'd 0;
reg [15:0]correction_count3 = 16'd0;
reg [15:0]correction_count4 = 16'd0;
 	
//reg [2:0]count_drum1 = 3'd0;
always @(drum)
begin


		if (drum[0] == 1)
		note <= 8'd 2;
		
 if (drum[1] == 1)
		note <= 8'd 4;
		
 if (drum[2] == 1)
		begin
		correction_count3 = correction_count3 + 1;
		if(correction_count3 == 16'd 65535)
		note <= 8'd 6;
		end	
		
	else if(drum[2] == 0) correction_count3 = 16'd 0;
	
 if (drum[3] == 1)
		begin
		correction_count4 = correction_count4 + 1;
		if(correction_count4 == 16'd 65535)
		note <= 8'd 8;
		end	
		
	else if(drum[3] == 0) correction_count4 = 16'd 0;
	

end		

endmodule

/////////////////////////////////////////////////////
