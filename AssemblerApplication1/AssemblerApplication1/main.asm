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
	ldi		a1, 0x00
	bst		a1, 0
	rjmp	main
	
.include "string.asm"
.include "subroutines.asm"
.include "lcd.asm"

main:
	DISPLAY2 str0, str1 ; WELCOME TO MICROCONTROLLER PARTY
	WAIT_MS 2000

	LCD_CLEAR

    ; Display the menu options
    DISPLAY2 str2, str3  ; Display "1. CHOOSE PLAYERS" and "2. PLAY GAME"
    LCD_SET_CURSOR 0, 1  ; Move cursor to the second line
    DISPLAY str4         ; Display "3. OPEN SAFE"
	

