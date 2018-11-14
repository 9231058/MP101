;
; fibonnaci.asm
;
; Created: 3/30/2018 4:50:23 PM
; Updated: 11/14/2018 10:22:00 PM
; Author : parham
;

; reserves addresses in SRAM's data.
.DSEG
.ORG 0x0100

n: .BYTE 10 ; reserves 10 byte in address that is named n

.CSEG
.ORG 0x0000
main:
; stack initiation
	ldi r16, HIGH(RAMEND)
	out SPH, r16
	ldi r16, LOW(RAMEND)
	out SPL, r16
	clr r16 ; r16 = 0

; loads n's address to X register
	ldi XH, HIGH(n)
	ldi XL, LOW(n)
	; check processor status in debug mode to see X register is set to 0x100
	eor r16, r16 ; r16 = 0

; main loop
loop:
	; r16 : fibonacci sequence number e.g. 0 1 2 3
	; r17 : fibonacci value of sequence number that is stored in r16
	call fibonacci
	
	; increases r16 to the next sequence number 
    inc r16
	; stores r17 to address that is stored in X register then increases X
	st X+, r17
    
	; loop again
	rjmp loop

fibonacci:
	tst r16 ; if r16 == 0
	breq fibonacci_0 ; branch if equal (branch if z flag is set)
	dec r16 ; if r16-- == 0 please note that after this instruction r16 is decreased.
	breq fibonacci_1 ; branch if equal (branch if z flag is set)

	; calculates f(r16) or f(n - 1)
	call fibonacci

	; stores the result in stack. please note that fibonnaci function returns the result in r17.
	push r17

	; calculates f(r16 - 1) or f(n - 2)
	dec r16
	call fibonacci

	; restores f(r16) or f(n - 1) to r18
	pop r18

	; r17 = r17 + r18 or f(n) = f(n - 1) + f(n - 2)
	add r17, r18

	; restores r16 value to n
	inc r16
	inc r16

	; return
	ret

fibonacci_1:
	inc r16 ; restores r16 value to n
fibonacci_0:
	ldi r17, 1 ; f(0) = f(1) = 1
	ret