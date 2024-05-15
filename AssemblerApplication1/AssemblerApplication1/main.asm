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

main:
	rcall	LCD_clear
	DISPLAY2 str0, str1
	WAIT_MS 2000
	rcall start
	CB0 b0,2, safe ; call subroutine safe if PD1 pressed
	CB0 b0,1, games ; call subroutine games if PD0 pressed
	CB0 b0,1, trivia
	CB0 b0,2, dance
	rjmp main

start:
	DISPLAY2 str2, str3
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
	WAIT_MS 2000
	in b0, PIND
	out PORTB, b0
	cpi b0, 0xfd
	breq PC+3
	cpi b0, 0xfb
	brne PC+2
	ret
	rjmp games

trivia:
	DISPLAY1 strivia
	WAIT_MS 2000
	rjmp start

dance:
	DISPLAY1 strbutton
	WAIT_MS 2000
	rjmp start


safe:
	DISPLAY1 str6
	rjmp end


end:
	DISPLAY2 str10, str11
	rjmp end




