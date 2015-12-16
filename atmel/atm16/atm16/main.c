/*
 * atm16.c
 *
 * Created: 11/26/2015 12:54:04 AM
 * Author : Parham Alvani
 */ 

#include <avr/io.h>
#include <stdint.h>
#include <util/delay.h>

int main(void)
{
    /* Set port C direction */
    DDRC = 0x00;
	while (1) 
    {
		PORTA = 0xff;
		_delay_ms(500);
		char c = 0x00;
		c |= PINC;
		_delay_ms(2000);
		PORTA = c;
		_delay_ms(10000);
	}
}

