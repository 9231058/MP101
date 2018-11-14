;
; EPWrite.asm
;
; Created: 4/11/2018 5:54:52 AM
; Author : parham
;

.eseg
	ename: .byte 6

.cseg
.org 0x000
	rjmp start ; Reset vector

	start:	
		ldi r16, LOW(ename)
		dec r16
		out EEARL, r16
		ldi r16, LOW(ename)
		out EEARH, r16

		; convert word address into byte address
		ldi ZL, LOW(cname<<1)
		ldi ZH, HIGH(cname<<1)		
	loop:
		; wait for write enable
		sbic EECR, EEWE
		rjmp loop

		; increase address
		in r16, EEARL
		inc r16
		out EEARL, r16

		lpm
		out EEDR, r0
		inc ZL

		sbi EECR, EEMWE
		sbi EECR, EEWE
		rjmp loop

	cname: .db "Parham"