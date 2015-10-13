;
; led-on-off.asm
;
; Created: 1/2/2016 9:55:17 PM
; Author : Parham Alvani
;



.org $000
reset_label:
	jmp reset_isr
.org $012
tov0_label:
	jmp tov0_isr 
reset_isr:
	cli
	ldi r16 , LOW(RAMEND) 
	out SPL , r16 
	ldi r16 , HIGH(RAMEND)
	out SPH , r16
	; Enabling timer counter 0 overflow interrupt
	ldi r16, (1<<TOIE0)
	out TIMSK, r16
	; PB3 --> output
	ldi r16, (1<<PB3)
	out DDRB, r16
	; Enabling timer counter 0 with 1024 prescaling
	ldi r16, (1<<CS02) | (1<<CS00)
	out TCCR0, r16
tov0_isr:
	cli
	in r16, PORTB
	ldi r17, (1<<PB3)
	eor r16, r17
	out PORTB, r16
	sei
start:
	jmp start