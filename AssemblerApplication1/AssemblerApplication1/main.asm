/*
 * main.asm
 *
 *  Created: 30/04/2024 10:55:24
 *   Author: renuka
 */ 

;.include "m128def.inc"
.include "definitions.asm"	
.include "macros.asm"
;.include "display.asm"
;.include "string.asm"
;.include "subroutines.asm"
;.include "lcd.asm"
;.include "printf.asm"

 reset:
	LDSP	RAMEND	
   ;rcall	all initializations
	rcall LCD_init
	;ldi		a1, 0x00
	;bst		a1, 0
	rjmp	main

.include "lcd.asm"
.include "printf.asm"
main:
	rcall	LCD_home
	rcall	LCD_clear
	PRINTF LCD ; WELCOME TO MICROCONTROLLER PARTY
    .db "hello",0
	WAIT_MS 100
    ; Display the menu options
    ;DISPLAY2 str2, str3  ; Display "1. CHOOSE PLAYERS" and "2. PLAY GAME"
	;WAIT_MS 2000
    ;DISPLAY1 str4         ; Display "3. OPEN SAFE"
	;WAIT_MS 10000
	rjmp main
/*
reset:
	LDSP	RAMEND		; load stack pointer
	OUTI	DDRB,0xff	; make portB output
	rcall	LCD_init	; initialize LCD
	rjmp	main
.include "lcd.asm"
.include "printf.asm"

main:	
	in	a0,PIND		; read switches
	out	PORTB,a0	; write to LED
	com	a0		; invert a0
	
	rcall	LCD_home
	rcall	LCD_clear
	PRINTF	LCD
	; insert your printing command line here
	WAIT_MS	100
	rjmp 	main
*/