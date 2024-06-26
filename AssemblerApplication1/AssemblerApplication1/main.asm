/*
 * main.asm
 *
 *  Created: 30/04/2024 10:55:24
 *   Author: renuka
 */ 
 
.include "m128def.inc"
.include "definitions.asm"	
.include "macros.asm"
; ========================================================== keypad =========================================================
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
.cseg
.org 0
	jmp reset
	jmp	isr_ext_int0	; external interrupt INT0
	jmp	isr_ext_int1	; external interrupt INT1
	jmp isr_ext_int2
	jmp isr_ext_int3

; ============================================================================================================================

 reset:
	LDSP	RAMEND	
   ;rcall	all initializations
	rcall LCD_init
	ldi r16, 0xff
	out DDRB, r16
	ldi r16, 0x00
	out DDRD, r16

	rjmp	main

.include "kpd4x4.asm"
.include "printf.asm"
.include "string.asm"
.include "lcd.asm"
.include "display.asm"
.include "subroutines.asm"

main:
	rcall	LCD_clear
	DISPLAY2 str0, str1
	WAIT_MS 2000

main_loop:
	rcall start
	/*
	CB0 b0,2, safe ; call subroutine safe if PD1 pressed
	CB0 b0,1, games ; call subroutine games if PD0 pressed
	CB0 b0,1, trivia
	CB0 b0,2, dance
	*/
	CB1 b0,1, safe
	CB1 b0,0, games
	CB1 b0,0, trivia
	CB1 b0,1, dance
	jmp main_loop

start:
	DISPLAY2 str2, str3
	;WAIT_MS 2000
	;call check_button
	;in b0, PIND ; b0=r22
	call reset_kpd
	call check_reset
	mov b0, a0
	;out PORTB, b0
	cpi b0, 0x81
	breq PC+3
	cpi b0, 0x82
	brne PC+2
	ret
	jmp start

games:
	DISPLAY2 str4, str5
	/*
	call check_button
	WAIT_MS 1000
	;in b0, PIND
	;out PORTB, b0
	cpi b0, 0xfd
	breq PC+3
	cpi b0, 0xfb
	brne PC+2
	ret
	jmp games
	*/
	call reset_kpd
	call check_reset
	mov b0, a0
	cpi b0, 0x81
	breq PC+3
	cpi b0, 0x82
	brne PC+2
	ret
	jmp games

trivia:
	DISPLAY2 strwelcome, strivia
	;rcall check_button
	WAIT_MS 2000
	DISPLAY2 strivia2, strivia3
	WAIT_MS 2000
	ldi b1, 0x00
	QUESTION striviaQ1, striviaQ12, strivia1A, strivia1B, strivia1C, strivia1D
	COMPARE answer1
	brtc PC+2
	inc b1
	PRINT_SCORE b1
	WAIT_MS 2000
	QUESTION striviaQ2, striviaQ22, strivia2A, strivia2B, strivia2C, strivia2D
	COMPARE answer2
	brtc PC+2
	inc b1
	PRINT_SCORE b1
	WAIT_MS 2000
	QUESTION striviaQ3, striviaQ32, strivia3A, strivia3B, strivia3C, strivia3D
	COMPARE answer3
	brtc PC+2
	inc b1
	PRINT_SCORE b1
	WAIT_MS 2000
	QUESTION striviaQ4, striviaQ42, strivia4A, strivia4B, strivia4C, strivia4D
	COMPARE answer4
	brtc PC+2
	inc b1
	PRINT_SCORE b1
	WAIT_MS 2000
	QUESTION striviaQ5, striviaQ52, strivia5A, strivia5B, strivia5C, strivia5D
	COMPARE answer5
	brtc PC+2
	inc b1
	PRINT_SCORE b1
	WAIT_MS 2000
	QUESTION striviaQ6, striviaQ62, strivia6A, strivia6B, strivia6C, strivia6D
	COMPARE answer6
	brtc PC+2
	inc b1
	PRINT_SCORE b1
	WAIT_MS 2000
	QUESTION striviaQ7, striviaQ72, strivia7A, strivia7B, strivia7C, strivia7D
	COMPARE answer7
	brtc PC+2
	inc b1
	PRINT_SCORE b1
	WAIT_MS 2000
	QUESTION striviaQ8, striviaQ82, strivia8A, strivia8B, strivia8C, strivia8D
	COMPARE answer8
	brtc PC+2
	inc b1
	PRINT_SCORE b1
	WAIT_MS 2000
	QUESTION striviaQ9, striviaQ92, strivia9A, strivia9B, strivia9C, strivia9D
	COMPARE answer9
	brtc PC+2
	inc b1
	PRINT_SCORE b1
	WAIT_MS 2000
	QUESTION striviaQ10, striviaQ102, strivia10A, strivia10B, strivia10C, strivia10D
	COMPARE answer10
	brtc PC+2
	inc b1
	PRINT_SCORE b1
	WAIT_MS 2000
	ldi w, 0x05
	cp b1, w
	brsh trivia_won
	jmp trivia_lost
trivia_won:
    DISPLAY2 strwin1, strwin2
	WAIT_MS 2000
	DISPLAY2 strclue1a, strclue1b
	WAIT_MS 4000
	jmp main_loop
trivia_lost:
	DISPLAY2 strlose1, strlose2
	WAIT_MS 2000
	jmp main_loop

dance:
	DISPLAY2 strwelcome, strbutton
	;call check_button
	WAIT_MS 2000
	jmp main_loop


safe:
	DISPLAY1 str6
	;call reset_kpd
	jmp end


end:
	;call check_button
	DISPLAY2 str10, str11
	jmp end


check_reset:
	;in b0, PIND
	_CPI c0, 0x18 ; check if * key pressed
	;sbrs b0, 7 ; Check if PIND7 is pressed
	brne PC+2
	jmp reset
	ret