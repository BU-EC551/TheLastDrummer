
module music_temp(sysclk, speaker);
input sysclk;
output reg speaker;


reg clk;
parameter [3:0] N = 4'd4;

reg [3:0] pos_cnt;
reg [3:0] neg_cnt;
//reg [19:0] counter;
//reg [17:0] counter1;
//reg [18:0] counter2;
//reg [19:0] counter3;
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
always @(posedge clk) tone <= tone+31'd1;

wire [7:0] fullnote;
music_ROM ROM(.clk(clk), .address(tone[29:22]), .note(fullnote));

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

always @(posedge clk) if(tone[30]==0 && fullnote!=0 && counter_note==0 && counter_octave==0) speaker <= ~speaker;
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
	 1: begin quotient=1; remainder3to2=1; end
	 2: begin quotient=2; remainder3to2=2; end
	 3: begin quotient=0; remainder3to2=0; end
	 4: begin quotient=1; remainder3to2=1; end
	 5: begin quotient=2; remainder3to2=2; end
	 6: begin quotient=0; remainder3to2=0; end
	 7: begin quotient=1; remainder3to2=1; end
	 8: begin quotient=2; remainder3to2=2; end
	 9: begin quotient=0; remainder3to2=0; end
	10: begin quotient=1; remainder3to2=1; end
	11: begin quotient=2; remainder3to2=2; end
	12: begin quotient=0; remainder3to2=0; end
	13: begin quotient=1; remainder3to2=1; end
	14: begin quotient=2; remainder3to2=2; end
	15: begin quotient=0; remainder3to2=0; end
endcase
assign remain[1:0] = numer[1:0];// the first 2 bits are copied through
assign remain[3:2] = remainder3to2;// and the last 2 bits come from the case statement
endmodule
/////////////////////////////////////////////////////



module music_ROM(
	input clk,
	input [7:0] address,
	output reg [7:0] note
);

always @(posedge clk)
case(address)
	
	
	0: note <= 8'd24;
	1: note <= 8'd0;
	2: note <= 8'd0;
	3: note <= 8'd25;
	4: note <= 8'd0;
	5: note <= 8'd0;
	6: note <= 8'd26;
	7: note <= 8'd0;
	8: note <= 8'd0;
	9: note <= 8'd27;
	10: note <= 8'd0;
	11: note <= 8'd0;
	12: note <= 8'd28;
	13: note <= 8'd0;
	14: note <= 8'd0;
	15: note <= 8'd29;
	16: note <= 8'd0;
	17: note <= 8'd0;
	18: note <= 8'd30;
	19: note <= 8'd0;
	20: note <= 8'd0;
	21: note <= 8'd31;
	22: note <= 8'd0;
	23: note <= 8'd0;
	24: note <= 8'd32;
	25: note <= 8'd0;
	26: note <= 8'd0;
	27: note <= 8'd33;
	28: note <= 8'd0;
	29: note <= 8'd0;
	30: note <= 8'd34;
	31: note <= 8'd0;
	32: note <= 8'd0;
	33: note <= 8'd35;
	34: note <= 8'd0;
	35: note <= 8'h24;
	36: note <= 8'h25;
	37: note <= 8'h26;
	38: note <= 8'h27;
	39: note <= 8'h28;
	40: note <= 8'h29;
	41: note <= 8'h30;
	42: note <= 8'h31;
	43: note <= 8'h32;
	44: note <= 8'h33;
	45: note <= 8'h34;
	46: note <= 8'h35;
	46: note <= 8'h35;
	47: note <= 8'h34;
	48: note <= 8'h33;
	49: note <= 8'h32;
	50: note <= 8'h31;
	51: note <= 8'h30;
	52: note <= 8'h29;
	53: note <= 8'h28;
	54: note <= 8'h27;
	55: note <= 8'h26;
	56: note <= 8'h25;
	57: note <= 8'h24;
	58: note <= 8'h24;
	59: note <= 8'h35;
	60: note <= 8'h25;
	61: note <= 8'h34;
	62: note <= 8'h26;
	63: note <= 8'h33;
	64: note <= 8'h27;
	65: note <= 8'h32;
	66: note <= 8'h28;
	67: note <= 8'h31;
	68: note <= 8'h29;
	69: note <= 8'h30;
	70: note <= 8'h30;
	

	/*58: note <= 8'h24;
	59: note <= 8'h35;
	60: note <= 8'h25;
	61: note <= 8'h34;
	62: note <= 8'h26;
	63: note <= 8'h33;
	64: note <= 8'h27;
	65: note <= 8'h32;
	66: note <= 8'h28;
	67: note <= 8'h31;
	68: note <= 8'h29;
	69: note <= 8'h30;
	70: note <= 8'h30;

	0: note <= 8'd24;
	1, 2,3,4,5,6,7,8,9: note <= 8'd00;
	
	10: note <= 8'd25; //8'd14;
	11, 12,13,14,15,16,17,18,19: note <= 8'd00;
	
	20: note <= 8'd26; //8'd27;
	21, 22,23,24,25,26,27,28,29: note <= 8'd00;
	
	30: note <= 8'd27; //8'd13;
	31,32,33,34,35,36,37,38,39: note <= 8'd00;
	
	40: note <= 8'd28; //8'd28;
	41, 42,43,44,45,46,47,48,49: note <= 8'd00;
	
	50: note <= 8'd29; //8'd15;
	51, 52,53,54,55,56,57,58,59: note <= 8'd00;
	
	60: note <= 8'd30; //8'd26;
	61,62,63,64,65,66,67,68,69: note <= 8'd00;
	
	70: note <= 8'd31; //8'd92;
	71,72,73,74,75,76,77,78,79: note <= 8'd00;
	
	80: note <= 8'd32; //8'd105;
	81,82,83,84,85,86,87,88,89: note <= 8'd00;
	
	90: note <= 8'd33; //8'd118;
	91, 92,93,94,95,96,97,98,99:note <= 8'd00;
	
	100: note <= 8'd34; //8'd131;
	101, 102,103,104,105,106,107,108,109: note <= 8'd00;
	
	110: note <= 8'd35; //8'd144;
	111,112,113,114,115,116,117,118,119: note <= 8'd00;
	
	
	
	10: note <= 8'h56;
	
	
	11: note <= 8'h45;
	
	
	12: note <= 8'h66;
	
	
	13: note <= 8'h6D;
	
	
	14: note <= 8'h74;
	
	
	15: note <= 8'h20;
	
	
	16: note <= 8'h10;
	
	
	17,18,19: note <= 8'h00;
	
	
	20: note <= 8'h01;
	
	
	21: note <= 8'h00;
	
	
	22: note <= 8'h01;
	
	
	23: note <= 8'h00;
	
	
	24: note <= 8'h44;
	
	
	25: note <= 8'hAC;
	
	
	26,27: note <= 8'h00;
	
	
	28: note <= 8'h88;
	29: note <= 8'h58;
	30: note <= 8'h01;
	31: note <= 8'h00;
	
	32: note <= 8'h02;
	33: note <= 8'h00;
	34: note <= 8'h10;
	35: note <= 8'h00;
	36: note <= 8'h64;
	37: note <= 8'h61;
	38: note <= 8'h74;
	39: note <= 8'h61;
	40: note <= 8'h00;
	41: note <= 8'h72;
	42: note <= 8'h01;
	43,44,45,46,47,48,49: note <= 8'h00;
	50: note <= 8'h16;
	51: note <= 8'h1F;
	52: note <= 8'h1C;
	53: note <= 8'hFE;
	54: note <= 8'h71;
	55: note <= 8'h10;
	56: note <= 8'h9C;
	57: note <= 8'hEA;
	58: note <= 8'h87;
	59: note <= 8'hBC;
	60: note <= 8'h40;
	61: note <= 8'hEF;
	62: note <= 8'h2C;
	63: note <= 8'h21;
	
	64: note <= 8'hFC;
	65: note <= 8'h2D;
	66: note <= 8'hB2;
	67: note <= 8'h4C;
	68: note <= 8'h0B;
	69: note <= 8'h47;
	70: note <= 8'hED;
	71: note <= 8'h37;
	72: note <= 8'h89;
	73: note <= 8'h3E;
	74: note <= 8'hE8;
	75: note <= 8'h11;
	76: note <= 8'h13;
	77: note <= 8'hCB;
	78: note <= 8'h55;
	79: note <= 8'hBB;
	80: note <= 8'hBB;
	81: note <= 8'hB1;
	82: note <= 8'hD9;
	83: note <= 8'hD5;
	84: note <= 8'h8D;
	85: note <= 8'hE7;
	86: note <= 8'hA1;
	87: note <= 8'hBE;
	88: note <= 8'hE7;
	89: note <= 8'hC0;
	90: note <= 8'h7C;
	91: note <= 8'hD4;
	92: note <= 8'hBE;
	93: note <= 8'hE9;
	94: note <= 8'h06;
	95: note <= 8'hEA;
	
	
	96: note <= 8'hA6;
	97: note <= 8'hBE;
	98: note <= 8'hDA;
	99: note <= 8'hCE;
	100: note <= 8'h28;
	101: note <= 8'h05;
	102: note <= 8'hE2;
	103: note <= 8'h06;
	104: note <= 8'hDE;
	105: note <= 8'h03;
	106: note <= 8'h52;
	107: note <= 8'h38;
	108: note <= 8'h56;
	109: note <= 8'h4C;
	110: note <= 8'hFB;
	111: note <= 8'h40;
	112: note <= 8'hB3;
	113: note <= 8'h46;
	114: note <= 8'h5F;
	115: note <= 8'h42;
	116: note <= 8'h46;
	117: note <= 8'h21;
	118: note <= 8'h9C;
	119: note <= 8'hF5;
	120: note <= 8'h39;
	121: note <= 8'hE9;
	122: note <= 8'h7C;
	123: note <= 8'hF3;
	124: note <= 8'hC0;
	125: note <= 8'hEC;
	126: note <= 8'h7C;
	127: note <= 8'h04;
	
	
	128: note <= 8'h64;
	129: note <= 8'h37;
	130: note <= 8'hEE;
	131: note <= 8'h3E;
	
	132: note <= 8'hE5;
	133: note <= 8'h3A;
	134: note <= 8'h0E;
	135: note <= 8'h40;
	136: note <= 8'hFC;
	137: note <= 8'h2E;
	138: note <= 8'hF2;
	139: note <= 8'h0C;
	140: note <= 8'h41;
	141: note <= 8'h07;
	142: note <= 8'h79;
	143: note <= 8'h26;
	144: note <= 8'h99;
	145: note <= 8'h29;
	146: note <= 8'hE0;
	147: note <= 8'h12;
	148: note <= 8'h1A;
	149: note <= 8'h05;
	150: note <= 8'h25;
	151: note <= 8'hDB;
	152: note <= 8'h77;
	153: note <= 8'hBA;
	154: note <= 8'hAA;
	155: note <= 8'hB5;
	156: note <= 8'h59;
	157: note <= 8'hA9;
	158: note <= 8'hC1;
	159: note <= 8'h98;
	
	
	160: note <= 8'hC1;
	161: note <= 8'h8C;
	162: note <= 8'hE0;
	163: note <= 8'h94;
	164: note <= 8'hB8;
	165: note <= 8'hB6;
	166: note <= 8'h05;
	167: note <= 8'hCE;
	168: note <= 8'h72;
	169: note <= 8'hCD;
	170: note <= 8'hEC;
	171: note <= 8'hD4;
	172: note <= 8'h71;
	173: note <= 8'hD9;
	174: note <= 8'h25;
	175: note <= 8'hDA;
	176: note <= 8'h96;
	177: note <= 8'hF0;
	178: note <= 8'hB2;
	179: note <= 8'hF7;
	180: note <= 8'hA8;
	181: note <= 8'h00;
	182: note <= 8'h84;
	183: note <= 8'h11;
	184: note <= 8'h88;
	185: note <= 8'h21;
	186: note <= 8'hFC;
	187: note <= 8'h27;
	188: note <= 8'h8C;
	189: note <= 8'h25;
	190: note <= 8'h05;
	191: note <= 8'h2F;
	192: note <= 8'h00;
	
	
	
	193: note <= 8'd23;
	194, 195, 196, 197: note <= 8'd20;
	198: note <= 8'd25;
	199, 200: note <= 8'd27;
	201: note <= 8'd25;
	202, 203: note <= 8'd22;
	204, 205: note <= 8'd30;
	206, 207: note <= 8'd27;
	208, 209, 210, 211, 212, 213: note <= 8'd25;
	214: note <= 8'd0;
	215: note <= 8'd25;
	216: note <= 8'd27;
	217: note <= 8'd25;
	218: note <= 8'd27;
	219, 220: note <= 8'd25;
	221, 222: note <= 8'd30;
	223, 224, 225, 226, 227, 228, 229, 230: note <= 8'd29;
	231: note <= 8'd23;
	232, 233: note <= 8'd25;
	234: note <= 8'd23;
	235, 236: note <= 8'd20;
	237, 238: note <= 8'd29;
	239, 240: note <= 8'd27;
	241, 242, 243, 244, 245, 246, 247: note <= 8'd25;
*/
	default: note <= 8'd0;
endcase
endmodule
/////////////////////////////////////////////////////
