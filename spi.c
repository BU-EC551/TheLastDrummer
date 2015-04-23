#include "msp430g2553.h"

 /* declarations of functions defined later */
 void init_spi(void);
 void init_wdt(void);
#define BUTTON 0x08
#define RED 0x01
// Global variables and parameters (all volatilel to maintain for debugger)

volatile unsigned char data_to_send = 0;	// current byte to transmit
volatile unsigned long tx_count = 0;		// total number of transmissions
volatile unsigned char data_received= 0; 	// most recent byte received
volatile unsigned long rx_count=0;			// total number received handler calls
volatile unsigned char last_button;
// Try for a fast send.  One transmission every 64 microseconds
// bitrate = 1 bit every 4 microseconds
#define ACTION_INTERVAL 1
#define BIT_RATE_DIVISOR 32

// ===== Watchdog Timer Interrupt Handler ====

volatile unsigned int action_counter=ACTION_INTERVAL;

interrupt void WDT_interval_handler(){
	if (--action_counter==0){
		UCB0TXBUF=data_to_send; // init sending current byte
		unsigned char b;
	  	b= (P1IN & BUTTON);  // read the BUTTON bit
	  	if (last_button && (b==0)){ // has the button bit gone from high to low
	  		++data_to_send;
	  		P1DIR ^= RED;
	  		// toggle both LED's
	  	}
	  	last_button=b;
	  	 // increment byte to send for next time
		++tx_count;
		action_counter=ACTION_INTERVAL;
	}
}
ISR_VECTOR(WDT_interval_handler, ".int10")

void init_wdt(){
	// setup the watchdog timer as an interval timer
	// INTERRUPT NOT YET ENABLED!
  	WDTCTL =(WDTPW +		// (bits 15-8) password
     	                   	// bit 7=0 => watchdog timer on
       	                 	// bit 6=0 => NMI on rising edge (not used here)
                        	// bit 5=0 => RST/NMI pin does a reset (not used here)
           	 WDTTMSEL +     // (bit 4) select interval timer mode
  		     WDTCNTCL  		// (bit 3) clear watchdog timer counter
  		                	// bit 2=0 => SMCLK is the source
  		                	// bits 1-0 = 10=> source/512
 			 );
  	IE1 |= WDTIE; // enable WDT interrupt
 }

//----------------------------------------------------------------

// ======== Receive interrupt Handler for UCB0 ==========

void interrupt spi_rx_handler(){
	data_received=UCB0RXBUF; // copy data to global variable
	++rx_count;				 // increment the counter
	IFG2 &= ~UCB0RXIFG;		 // clear UCB0 RX flag
}
ISR_VECTOR(spi_rx_handler, ".int07")


//Bit positions in P1 for SPI
#define SPI_CLK 0x20
#define SPI_SOMI 0x40
#define SPI_SIMO 0x80

// calculate the lo and hi bytes of the bit rate divisor
#define BRLO (BIT_RATE_DIVISOR &  0xFF)
#define BRHI (BIT_RATE_DIVISOR / 0x100)

void init_spi(){
	UCB0CTL1 = UCSSEL_2+UCSWRST;  		// Reset state machine; SMCLK source;
	UCB0CTL0 = UCCKPH					// Data capture on rising edge
			   							// read data while clock high
										// lsb first, 8 bit mode,
			   +UCMST					// master
			   +UCMODE_0				// 3-pin SPI mode
			   +UCSYNC;					// sync mode (needed for SPI or I2C)
	UCB0BR0=BRLO;						// set divisor for bit rate
	UCB0BR1=BRHI;
	UCB0CTL1 &= ~UCSWRST;				// enable UCB0 (must do this before setting
										//              interrupt enable and flags)
	IFG2 &= ~UCB0RXIFG;					// clear UCB0 RX flag
	IE2 |= UCB0RXIE;					// enable UCB0 RX interrupt
	// Connect I/O pins to UCB0 SPI
	P1SEL |=SPI_CLK+SPI_SOMI+SPI_SIMO;
	P1SEL2|=SPI_CLK+SPI_SOMI+SPI_SIMO;
}


/*
 * The main program just initializes everything and leaves the action to
 * the interrupt handlers!
 */

void main(){

	WDTCTL = WDTPW + WDTHOLD;       // Stop watchdog timer
	BCSCTL1 = CALBC1_8MHZ;			// 8Mhz calibration for clock
  	DCOCTL  = CALDCO_8MHZ;
  	P1DIR &= ~BUTTON;
    P1DIR |= RED;
    P1OUT |= RED;
    P1OUT |= BUTTON;
    P1REN |= BUTTON;
  	init_spi();
  	init_wdt();
 	_bis_SR_register(GIE+LPM0_bits);



}
