// Music demo verilog file
// Plays a little tune on a speaker
// (c) fpga4fun.com 2003-2014

/////////////////////////////////////////////////////
module music(
	input sysclk, 
   input [3:0] key,	// tested with 25MHz
	output reg speaker
	
);

reg clk;
parameter [3:0] N = 4'd4;
//reg [10:0] N = 11'd90;


reg [3:0] pos_cnt;
reg [3:0] neg_cnt;

always @ ( posedge sysclk )
begin		
pos_cnt <= (pos_cnt + 1'b1) % N ;
end

always @ (posedge sysclk)
begin
neg_cnt <= (neg_cnt + 1'b1) % N  ;
end

always @(posedge sysclk )
begin
if ( (N%2) == 1'b0)
clk <= ( pos_cnt >= (N/2)) ? 1'b1 : 1'b0;
else
clk <= (( pos_cnt > (N/2)) || ( neg_cnt > (N/2))) ? 1'b1 : 1'b0;
end




wire [3:0]note;
wire [7:0] fullnote;
music_ROM ROM(.clk(clk), /*.address(tone[29:22]),*/.key(key), .note(fullnote));

//module PWM(clk, PWM_in, PWM_out);
//input clk;
//input [7:0] PWM_in;
//reg PWM_out;

/*reg [255:0] PWM_accumulator;
always @(posedge clk) begin 
PWM_accumulator <= PWM_accumulator[254:0] + fullnote;

	//speaker <= ~speaker;
	led = PWM_accumulator[255];
end*/
//endmodule

wire [2:0] octave;
//wire [3:0] note;
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
	default: clkdivider = 9'd254;// should never happen

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
if(fullnote!=0 && counter_octave==0 && counter_note==0 )
	speaker <= ~speaker;
	
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
	//input [7:0] address,
	input [3:0] key,
	output reg [7:0] note
	//input M
);

reg [5:0]count = 6'd 0;

always @(posedge clk)
begin

	case(key)
	 6:note <= 8'd25;
	 1:note <= 8'd26;
	7:note <= 8'd27;
	2:note <= 8'd28;
	8:note <= 8'd29;
	9:note <= 8'd30;
	3:note <= 8'd31;
	10:note <= 8'd32;
	4:note <= 8'd33;
   11:note <= 8'd34;
	5:note <= 8'd35;
	12:note <= 8'd36;
	13:note <= 8'd37;

	default: note <= 8'd0;
endcase 
end
endmodule

