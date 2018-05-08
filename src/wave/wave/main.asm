;
; wave.asm
;
; Created: 1/2/2016 11:40:33 PM
; Author : Parham Alvani
;


.org $0000
reset_label:
	jmp reset_isr
.org $0012
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
	; PB3 (OC0) --> output
	ldi r16, (1<<PB3)
	out DDRB, r16
	; Enabling timer counter 0 fast PWM with 256 prescaling
	; OC0 inverting mode
	ldi r16, $ff
	out OCR0, r16
	ldi r16, (1<<CS02) | (0<<CS01) | (0<<CS00) | (1<<WGM01) | (1<<WGM00) | (1<<COM00) | (1<<COM01) 
	out TCCR0, r16

	sei
	jmp start

tov0_isr:
	in r16, OCR0
	cpi r16, 0
	breq tov0_isr_reset
tov0_isr_dec:
	subi r16, $0f
	jmp tov0_isr_store
tov0_isr_reset:
	ldi r16, $ff
tov0_isr_store:
	out OCR0, r16
	reti

start:
	rjmp start