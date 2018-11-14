;
; wave.asm
;
; Created: 1/2/2016 11:40:33 PM
; Author : Parham Alvani
;


.org $000
reset_label:
	jmp reset_isr
.org $026
tcp0_label:
	jmp tcp0_isr 
reset_isr:
	cli
	ldi r16 , LOW(RAMEND) 
	out SPL , r16 
	ldi r16 , HIGH(RAMEND)
	out SPH , r16
	; Enabling timer counter 0 compare match interrupt
	ldi r16, (1<<OCIE0)
	out TIMSK, r16
	; PB3 --> output
	ldi r16, (1<<PB3)
	out DDRB, r16
	; Enabling timer counter 0 with 1024 prescaling
	; CTC Mode
	ldi r16, $ff
	out OCR0, r16
	ldi r16, (1<<CS02) | (1<<CS00) | (1<<WGM01) | (0<<WGM00) | (1<<COM00) | (0<<COM01) 
	out TCCR0, r16
tcp0_isr:
	cli
	in r16, OCR0
	cpi r16, 0
	breq tcp0_isr_reset
tcp0_isr_dec:
	subi r16, $0f
	jmp tcp0_isr_store
tcp0_isr_reset:
	ldi r16, $ff
tcp0_isr_store:
	out OCR0, r16
	sei
start:
	jmp start