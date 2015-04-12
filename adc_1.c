/* 10-16-2012
This is an example of using the ADC to convert a single
analog input. The external input is to ADC10 channel A4.
This example uses a function to start conversion and
a separate function get_result that busy-waits for the result.
*/
#include "msp430g2553.h"
#define ADC_INPUT_BIT_MASK 0x10
#define ADC_INCH INCH_4

/* a simple function to read the single value from the ADC.
 * There are actually a pair of functions:
 * (1) start_conversion(), which initiates a single conversion
 * (2) get_result() which returns a number from 0 t0 1023
 *  	get_result WAITS for a value to be ready.
 */

 /* declarations of functions */
 void init_adc(void);
 void start_conversion(void);
 int get_result(void);

 /* global variable for result (for debugging) */
volatile unsigned int latest_result[100];

 /* basic adc operations */
 void start_conversion(){
 	ADC10CTL0 |= ADC10SC;
 }

unsigned delay_hits=0;	/* counter to estimate the busy wait time */

int get_result(){
 	delay_hits=0;
 	while (ADC10CTL1 & ADC10BUSY) {++delay_hits;}// busy wait for busy flag off

 	return ADC10MEM;
 }

 void init_adc(){
  	ADC10CTL1= ADC_INCH	//input channel bit field
 			  +SHS_0 //use ADC10SC bit to trigger sampling
 			  +ADC10DIV_4 // ADC10 clock/5
 			  +ADC10SSEL_0 // Clock Source=ADC10OSC
 			  +CONSEQ_0; // single channel, single conversion
 			  ;
 	ADC10AE0=ADC_INPUT_BIT_MASK; // enable A4 analog input
 	ADC10CTL0= SREF_0	//reference voltages are Vss and Vcc
 	          +ADC10SHT_3 //64 ADC10 Clocks for sample and hold time (slowest)
 	          +ADC10ON	//turn on ADC10
 	          +ENC		//enable (but not yet start) conversions
 	          ;
 }

 int flag[3] ={0,0,0};
void main(){

	P1DIR |= 0X41;
	P1OUT = 0x00;
	WDTCTL = WDTPW + WDTHOLD;       // Stop watchdog timer
	BCSCTL1 = CALBC1_8MHZ;			// 8Mhz calibration for clock
  	DCOCTL  = CALDCO_8MHZ;
  	unsigned long j = 50000;
  	init_adc();
  	int i = 0;
  	while(1){
  		start_conversion();

  		latest_result[i]=get_result();
  

  		//if(latest_result[i]<0) {latest_result[i] = latest_result[i] +80; flag[0] += 1;}
  		if(latest_result[i]>600 ) { P1OUT ^= 0x01; flag[2] += 1;}
  		else if(latest_result[i]>550) { P1OUT ^= 0x40; flag[1] += 1;}
  	    i++;
  	    j = 50000;
  		if(i>99) i =0;
  	}

}

