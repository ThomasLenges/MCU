/*
 * subroutines.asm
 *
 *  Created: 30/04/2024 11:21:07
 *   Author: renuka
 */ 

; code from: tp05 puts02.asm
 LCD_putstring:
	lpm
	tst		r0
	breq	done
	mov		a0, r0
	rcall	LCD_putc
	adiw	zl, 1
	rjmp	LCD_putstring
done:ret
