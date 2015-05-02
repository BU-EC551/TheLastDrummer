#include "msp430g2553.h"
unsigned int res[5] = {0,0,0,0,0}; //for holding the conversion results
void main (void)
{
	char count[5] = {0,0,0,0,0};
  //code for connecting to AP

  //reading voltage
  WDTCTL = WDTPW + WDTHOLD;                 // Stop WDT
  ADC10CTL1 = INCH_5 + CONSEQ_3;            // A4/A3/A2/A1/A0, once multi channel
  ADC10CTL0 = SREF_0 + ADC10SHT_3 + MSC + ADC10ON + ADC10IE; //2.5 reference voltage
  ADC10AE0 = 0x3E;                          // P1.1,2,3,4,5 ADC option select
  ADC10DTC1 = 0x5;                         // 5 conversions
  P1DIR |= 0x41;                            // Set P1.0 output 11100001
  P1OUT &= ~0x41;
  P2DIR |= 0x06;
  P2OUT &= ~0x06;
  for (;;)
  {
	                 // Set P1.0 LED on
    ADC10CTL0 &= ~ENC;
    while (ADC10CTL1 & BUSY);               // Wait if ADC10 core is active
    ADC10SA = (int)res;                        // Data buffer start
    ADC10CTL0 |= ENC + ADC10SC;             // Sampling and conversion ready
    __bis_SR_register(CPUOFF + GIE);        // LPM0, ADC10_ISR will force exit
                             // Clear P1.0 LED off
   if(res[0]==1023) {count[0]++; if(count[0]>2) P1OUT |= 0x01;}
   else {P1OUT &= ~0x01; count[0]=0;}
    if(res[2]>1022) {count[1] ++; if(count[1]>2
    		) P1OUT |= 0x40;}
        else {P1OUT &= ~0x40; count[1]=0;}
    if(res[3]>1022) {count[2] ++; if(count[2]>2) P2OUT |= 0x02;}
    else {P2OUT &= ~0x02; count[2]=0;}
    if(res[1]>1022) {count[3] ++; if(count[3]>10) P2OUT |= 0x04;}
    else {P2OUT &= ~0x04; count[3]=0;}

    //P1OUT |= 0xE1;
  }

}

#pragma vector=ADC10_VECTOR
__interrupt void ADC10_ISR(void)
{
    //code from reading from res and sending it to AP
  __bic_SR_register_on_exit(CPUOFF);        // Clear CPUOFF bit from 0(SR)
}
