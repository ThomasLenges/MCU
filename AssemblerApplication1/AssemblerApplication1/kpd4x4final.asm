; file	kpd4x4_S.asm   target ATmega128L-4MHz-STK300		
; purpose keypad 4x4 acquisition and print
;  uses four external interrupts and ports internal pull-up

; solutions based on the methodology presented in EE208-MICRO210_ESP-2024-v1.0.fm
;>alternate solutions also possible
; standalone solution/file; not meeant as a modular solution and thus must be
;>adapted when used in a complex project
; solution based on interrupts detected on each row; not optimal but functional if
;>and external four-input gate is not available

.include "macros.asm"		; include macro definitions
.include "definitions.asm"	; include register/constant definitions

	; === definitions ===
.equ	KPDD = DDRD
.equ	KPDO = PORTD
.equ	KPDI = PIND

.equ	KPD_DELAY = 30	; msec, debouncing keys of keypad

.def	wr0 = r2		; detected row in hex
.def	wr1 = r1		; detected column in hex
.def	mask = r14		; row mask indicating which row has been detected in bin
.def	wr2 = r15		; semaphore: must enter LCD display routine, unary: 0 or other

	; === interrupt vector table ===
.org 0
	jmp reset
	jmp	isr_ext_int0	; external interrupt INT0
	jmp	isr_ext_int1	; external interrupt INT1
	jmp isr_ext_int2
	jmp isr_ext_int3

; TO BE COMPLETED AT THIS LOCATION

	; === interrupt service routines ===
isr_ext_int0:
	INVP	PORTB,0			;;debug
	_LDI	wr1, 0x00		; detect row 1
	_LDI	mask, 0b00000001
	rjmp	column_detect
	; no reti (grouped in isr_return)

isr_ext_int1:
	INVP	PORTB,1	
	_LDI	wr1, 0x01
	_LDI	mask, 0b00000010
	rjmp column_detect

isr_ext_int2:
	INVP	PORTB,2
	_LDI wr1, 0x02
	_LDI mask, 0b00000100
	rjmp column_detect

isr_ext_int3:
	INVP	PORTB,3
	_LDI wr1, 0x03
	_LDI mask, 0b00001000
	rjmp column_detect

; TO BE COMPLETED AT THIS LOCATION

column_detect:

	OUTI	KPDO,0xff	; bit4-7 driven high
col7: ; = X4
	INVP	PORTB,4	
	WAIT_MS	KPD_DELAY
	OUTI	KPDO,0x7f	; check column 7
	WAIT_MS	KPD_DELAY
	in		w,KPDI
	and		w,mask
	tst		w
	brne	col6
	_LDI	wr0,0x00
	;INVP	PORTB,7		;;debug
	rjmp	isr_return
	
col6:
	INVP	PORTB,5
	WAIT_MS	KPD_DELAY
	OUTI	KPDO,0xbf	; check column 6
	WAIT_MS	KPD_DELAY
	in		w,KPDI
	and		w,mask
	tst		w
	brne	col5
	_LDI	wr0,0x10
	;INVP	PORTB,7		;;debug
	rjmp	isr_return

col5:
	INVP	PORTB,6
	WAIT_MS	KPD_DELAY
	OUTI	KPDO,0xdf	; check column 5
	WAIT_MS	KPD_DELAY
	in		w,KPDI
	and		w,mask
	tst		w
	brne	col4
	_LDI	wr0,0x20
	;INVP	PORTB,7		;;debug
	rjmp	isr_return
; TO BE COMPLETED AT THIS LOCATION
	
col4:
	INVP	PORTB,7
	WAIT_MS	KPD_DELAY
	OUTI	KPDO,0xef	; check column 4
	WAIT_MS	KPD_DELAY
	in		w,KPDI
	and		w,mask
	tst		w
	brne	isr_return
	_LDI	wr0,0x30
	;INVP	PORTB,7		;;debug

	err_row0:			; debug purpose and filter residual glitches		
	;INVP	PORTB,0
	rjmp	isr_return
	; no reti (grouped in isr_return)

isr_return:
	INVP	PORTB,7		; visual feedback of key pressed acknowledge
	ldi		_w,10		; sound feedback of key pressed acknowledge
beep01:	
	
	; TO BE COMPLETED AT THIS LOCATION
	
	_LDI	wr2,0xff
	reti
	
.include "lcd.asm"			; include UART routines
.include "printf.asm"		; include formatted printing routines

; === initialization and configuration ===

.org 0x400

reset:	LDSP	RAMEND		; Load Stack Pointer (SP)
	rcall	LCD_init		; initialize UART

	OUTI	KPDD,0xf0		; bit0-3 pull-up and bits4-7 driven low
	OUTI	KPDO,0x0f		;>(needs the two lines)
	OUTI	DDRB,0xff		; turn on LEDs
	OUTI	EIMSK,0x0f		; enable INT0-INT3
	OUTI	EICRB,0b0		;>at low level
	sbi		DDRE,SPEAKER	; enable sound

;	PRINTF LCD
;.db	CR,CR,"hello world"

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
	;jmp	main				; not useful in this case, kept for modularity

	; === main program ===
main:

	tst		wr2				; check flag/semaphore
	breq	main
	clr		wr2	

	clr		a0
	add		a0, wr1
	add		a0, wr0

	; TO BE COMPLETED AT THIS LOCATION		; decoding ascii
	
	
PRINTF LCD
.db	CR,LF,"KPD=",FHEX,a," ascii=",FHEX,b
.db	0
	rjmp	main
	
; code conversion table, character set #1 key to ASCII	
KeySet01:
.db "1234A456B789C*0#D" ; TO BE COMPLETED AT THIS LOCATION