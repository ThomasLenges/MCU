
; === initialization and configuration ===

reset_kpd:	
	OUTI	KPDD,0xf0		; bit0-3 pull-up and bits4-7 driven low
	OUTI	KPDO,0x0f		;>(needs the two lines)
	OUTI	DDRB,0xff		; turn on LEDs
	OUTI	EIMSK,0x0f		; enable INT0-INT3
	OUTI	EICRB,0b0		;>at low level
	sbi		DDRE,SPEAKER	; enable sound

	clr		wr0
	clr		wr1
	clr		wr2

	clr		a1				
	clr		a2
	clr		a3
	clr		b1
	clr		b2
	clr		b3

	sei
	jmp	main_kpd				; not useful in this case, kept for modularity

	; === main program ===
main_kpd:

	tst		wr2				; check flag/semaphore
	breq	main_kpd			; branch to main as long as no key pressed
	clr		wr2				; clear wr2 to avoid detecting key pressed once back at beginning of main

	clr		a0
	add		a0, wr1			; col
	add		a0, wr0			; row
	clr b0 ; used to compute offset to LUT
	; offset due to low nibble (row)
	mov c0, a0

	sbrc a0, 1
	subi b0, -4
	sbrc a0, 2
	subi b0, -8
	sbrc a0, 3
	subi b0, -12
	; offset due to high nibble (col)
	sbrc a0, 5
	subi b0, -1
	sbrc a0, 6
	subi b0, -2
	sbrc a0, 7
	subi b0, -3

	mov zl, b0
	clr zh
	subi zl, low(-2*KeySet01)
	sbci zh, high(-2*KeySet01)
	lpm
	mov b0, r0
	ret
		