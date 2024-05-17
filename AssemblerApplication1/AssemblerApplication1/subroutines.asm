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


/*
putdec:
	mov u, a0
	ldi a0, '0'-1
	ldi w, 100
_putdec2:
	inc a0
	sub u, w
	brsh _putdec2
	add u,w
	rcall LCD_putc

	ldi a0, '0'-1
	ldi w, 10
_putdec1:
	inc a0
	sub u, w
	brsh _putdec1
	add u, w
	rcall LCD_putc
	ldi a0, '0'
	add a0, u
	rcall LCD_putc
	ldi a0, '0'
	add a0, u
	rcall LCD_putc
	ret
*/
