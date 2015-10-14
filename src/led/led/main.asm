;
; led.asm
;
; Created: 1/2/2016 8:39:51 PM
; Author : Parham Alvani
;


.org $000
reset_label:
	jmp reset_isr
.org $004
int1_label:
	jmp int1_isr 
reset_isr:
	cli
	ldi r16 , LOW(RAMEND) 
	out SPL , r16 
	ldi r16 , HIGH(RAMEND)
	out SPH , r16
	; PD0 --> output
	ldi r16, (1<<PD0)
	out DDRD, r16
	; Enable INT1 with low level trigger
	; Enabling with GICR
	in r16, GICR
	ori r16, (1<<INT1)
	out GICR, r16
	; Triggering mode with MCUCR
	in r16, MCUCR
	andi r16, $F3
	out MCUCR, r16
	sei
	jmp start
int1_isr:
	cli
	in r16, PORTD
	ldi r17, (1<<PD0)
	eor r16, r17
	out PORTD, r16
	sei
start:
	jmp start

