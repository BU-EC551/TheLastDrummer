#include "msp430g2553.h"
unsigned int res[4] = {0,0,0,0}; //for holding the conversion results
void main (void)
{

  //code for connecting to AP

  //reading voltage
  WDTCTL = WDTPW + WDTHOLD;                 // Stop WDT
  ADC10CTL1 = INCH_4 + CONSEQ_3;            // A4/A3/A2/A1/A0, once multi channel
  ADC10CTL0 = SREF_0 + ADC10SHT_3 + MSC + ADC10ON + ADC10IE; //2.5 reference voltage
  ADC10AE0 = 0x1E;                          // P2.0,1,2,3,4 ADC option select
  ADC10DTC1 = 0x4;                         // 5 conversions
  P1DIR |= 0xE1;                            // Set P1.0 output
  P1OUT = 0x00;
  for (;;)
  {
                             // Set P1.0 LED on
    ADC10CTL0 &= ~ENC;
    while (ADC10CTL1 & BUSY);               // Wait if ADC10 core is active
    ADC10SA = (int)res;                        // Data buffer start
    ADC10CTL0 |= ENC + ADC10SC;             // Sampling and conversion ready
    __bis_SR_register(CPUOFF + GIE);        // LPM0, ADC10_ISR will force exit
                             // Clear P1.0 LED off
   if(res[0]>990) P1OUT |= 0x01;
    else P1OUT &= ~0x01;
    if(res[1]>1000) P1OUT |= 0x20;
        else P1OUT &= ~0x20;
    if(res[2]>1022) P1OUT |= 0x40;
        else P1OUT &= ~0x40;
    if(res[3]>1022) P1OUT |= 0x80;
        else P1OUT &= ~0x80;

    //P1OUT |= 0xE1;
  }

}

#pragma vector=ADC10_VECTOR
__interrupt void ADC10_ISR(void)
{
    //code from reading from res and sending it to AP
  __bic_SR_register_on_exit(CPUOFF);        // Clear CPUOFF bit from 0(SR)
}
