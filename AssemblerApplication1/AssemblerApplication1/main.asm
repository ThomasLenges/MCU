/*
 * main.asm
 *
 *  Created: 30/04/2024 10:55:24
 *   Author: renuka
 */ 

.include "m128def.inc"
.include "definitions.asm"	
.include "macros.asm"

 reset:
	LDSP	RAMEND	
   ;rcall	all initializations
	rcall LCD_init
	ldi r16, 0xff
	out DDRB, r16
	ldi r16, 0x00
	out DDRD, r16

	rjmp	main

.include "printf.asm"
.include "string.asm"
.include "lcd.asm"
.include "display.asm"
.include "subroutines.asm"

.macro QUESTION ; question: str0, str1 answer: str2, str3, str4, str5
question_start:
	DISPLAY2 @0, @1 ; display question
	WAIT_MS 2000
	;rjmp check_button
	in b0, PIND
	out PORTB, b0 
	sbrs b0, 4
	rjmp question_end
	sbrs b0, 3
	rjmp question_end
	sbrs b0, 2
	rjmp question_end
	sbrs b0, 1
	rjmp question_end
	DISPLAY2 @2, @3
	;rjmp check_button
	in b0, PIND
	out PORTB, b0 
	sbrs b0, 4
	rjmp question_end
	sbrs b0, 3
	rjmp question_end
	sbrs b0, 2
	rjmp question_end
	sbrs b0, 1
	rjmp question_end
	WAIT_MS 2000
	;rjmp check_button
	in b0, PIND
	out PORTB, b0 
	sbrs b0, 4
	rjmp question_end
	sbrs b0, 3
	rjmp question_end
	sbrs b0, 2
	rjmp question_end
	sbrs b0, 1
	rjmp question_end
	DISPLAY2 @4, @5
	WAIT_MS 2000
	;rjmp check_button
	in b0, PIND
	out PORTB, b0 
	sbrs b0, 4
	rjmp question_end
	sbrs b0, 3
	rjmp question_end
	sbrs b0, 2
	rjmp question_end
	sbrs b0, 1
	rjmp question_end
	rjmp question_start
question_end:
.endmacro

.macro COMPARE
	ldi zl, low(2*@0)
	ldi zh, high(2*@0)
	lpm
	cp b0, r0
	brne PC+2
	set
.endmacro

.macro PRINT_SCORE
	rcall LCD_clear
	brts PC+2
	rjmp incorrect
correct:
	DISPLAY1 strcorrect
	rjmp score
incorrect:
	DISPLAY1 strfalse
score:
	CLR4 a3, a2, a1, a0
	mov a0, @0
	PRINTF LCD
.db "Score: ",FDEC,a,0
.endmacro

main:
	rcall	LCD_clear
	DISPLAY2 str0, str1
	WAIT_MS 2000

main_loop:
	rcall start
	CB0 b0,2, safe ; call subroutine safe if PD1 pressed
	CB0 b0,1, games ; call subroutine games if PD0 pressed
	CB0 b0,1, trivia
	CB0 b0,2, dance
	rjmp main_loop

start:
	DISPLAY2 str2, str3
	rcall check_button
	in b0, PIND ; b0=r22
	out PORTB, b0
	cpi b0, 0xfd
	breq PC+3
	cpi b0, 0xfb
	brne PC+2
	ret
	rjmp start

games:
	DISPLAY2 str4, str5
	rcall check_button
	WAIT_MS 1000
	in b0, PIND
	out PORTB, b0
	cpi b0, 0xfd
	breq PC+3
	cpi b0, 0xfb
	brne PC+2
	ret
	rjmp games

trivia:
	DISPLAY2 strwelcome, strivia
	rcall check_button
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
	;rjmp main_loop
	rjmp trivia

dance:
	DISPLAY2 strwelcome, strbutton
	rcall check_button
	WAIT_MS 2000
	rjmp main_loop


safe:
	DISPLAY1 str6
	rjmp end


end:
	rcall check_button
	DISPLAY2 str10, str11
	rjmp end


check_button:
	in b0, PIND
	sbrs b0, 7 ; Check if PIND7 is pressed
	rjmp reset
	ret


