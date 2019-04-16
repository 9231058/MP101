;
; ports.asm
;
; Created: 5/8/2018 10:10:56 PM
; Author : parham
;


.org 0x0000
jmp start

start:
	; pulled-up input
	ldi r16, (0 << PORTD0)
	out PORTD, r16

	nop

	; high ouput
	ldi r16, (1 << PORTD0)
	out PORTD, r16
	ldi r16, (1 << PD0)
	out DDRD, r16

loop:
	rjmp loop    