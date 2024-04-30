/*
 * display.asm
 *
 *  Created: 30/04/2024 11:39:40
 *   Author: renuka
 */ 

.macro DISPLAY1 

	call LCD_init
	ldi zl, low(2*@0)
	ldi zh, high(2*@0)
	call LCD_putstring

.endmacro

.macro DISPLAY2
	
	call LCD_init
	ldi zl, low(2*@0)
	ldi zh, high(2*@0)
	call LCD_putstring
	ldi zl, low(2*@1)
	ldi zh, high(2*@1)
	ldi a0, 0x40
	call LCD_pos
	call LCD_putstring

.endmacro