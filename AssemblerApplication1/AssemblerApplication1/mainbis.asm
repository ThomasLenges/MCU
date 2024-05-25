.include "definitions.asm"
.include "macros.asm"
.include "m128def.inc"

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

.org OVF0addr
	jmp overflow0

	; === interrupt service routines ===

isr_ext_int0:
	_LDI	wr1, 0x01		; detect row 1
	_LDI	mask, 0b00000001
	rjmp	column_detect

isr_ext_int1:
	_LDI	wr1, 0x02		; detect row 2
	_LDI	mask, 0b00000010
	rjmp	column_detect

isr_ext_int2:		
	_LDI	wr1, 0x04		; detect row 3 (LSB 0100)
	_LDI	mask, 0b00000100
	rjmp	column_detect

isr_ext_int3:
	_LDI	wr1, 0x08		; detect row 4 (LSB 1000)
	_LDI	mask, 0b00001000
	rjmp	column_detect


column_detect:
    OUTI    KPDO,0xff       ; bit4-7 driven high
col7: ; X2: 369#
	WAIT_MS KPD_DELAY
	OUTI KPDO,0x7f ; check column 7
	WAIT_MS KPD_DELAY
	in w,KPDI
	and w,mask
	tst w
	brne col6
	_LDI wr0,0x40 ; (MSB 0100)
	rjmp isr_return

col6: ; X1: ABCD
	WAIT_MS KPD_DELAY
	OUTI KPDO,0xbf ; check column 6
	WAIT_MS KPD_DELAY
	in w,KPDI
	and w,mask
	tst w
	brne col5
	_LDI wr0,0x80 ; (MSB 1000)
	rjmp isr_return

col5: ; X3: 2580
	WAIT_MS KPD_DELAY
	OUTI KPDO,0xdf ; check column 5
	WAIT_MS KPD_DELAY
	in w,KPDI
	and w,mask
	tst w
	brne col4
	_LDI wr0,0x20
	rjmp isr_return

col4: ; X4: 147*
	WAIT_MS KPD_DELAY
	OUTI KPDO,0xef ; check column 4
	WAIT_MS KPD_DELAY
	in w,KPDI
	and w,mask
	tst w
	brne isr_return
	_LDI wr0,0x10
 
isr_return:
	ldi _w,10 ; sound feedback of key pressed acknowledge
beep01:    
    _LDI    wr2,0xff
	ldi a0, re2
	ldi b0, 30 ; 2.5ms*30=75ms
	call sound
	WAIT_MS 200
	OUTI	KPDO,0x0f
    reti

overflow0:
	OUTI TCCR0, 0
	reti

.include "kpd4x4bis.asm"
.include "lcd.asm"
.include "string.asm"
.include "subroutines.asm"
.include "printf.asm"
.include "songs.asm"
.include "sound.asm"
.include "wire1.asm"		; include Dallas 1-wire(R) routines
.include "wire1_temp2.asm"


reset:
	LDSP	RAMEND	
	rcall LCD_init
	ldi r16, 0xff
	out DDRB, r16
	ldi r16, 0x00
	out DDRD, r16
	sbi		DDRE,SPEAKER	; enable sound
	jmp main

main:
	call	LCD_clear
	DISPLAY2 str0, str1
	;MENU_SONG
	


main_loop:
	rcall start
	CB1 b0,1, safe
	CB1 b0,0, games
	CB1 b0,0, trivia
	CB1 b0,1, lava
	CB1 b0,2, dance

	jmp main_loop

start:
	DISPLAY2 str2, str3
	call reset_kpd
	call check_reset
	mov b0, a0
	cpi b0, 0x81
	breq PC+3
	cpi b0, 0x82
	brne PC+2
	ret
	jmp main_loop

safe:
	DISPLAY1 str6
	_LDI c1, 0
	CA LCD_pos, $40
	PRINTF LCD
.db	"      ****      ",0
	call reset_kpd
	call check_reset
	COMPARE clue1answer, a0
	brtc PC+2
	inc c1
	CA LCD_pos, $40
	PRINTF LCD
.db	"      ",FSTR,b,0
	CA LCD_pos, $47 
	call reset_kpd
	call check_reset
	COMPARE clue2answer, a0
	brtc PC+2
	inc c1
	PRINTF LCD
.db	FSTR,b,0
	CA LCD_pos, $48
	call reset_kpd
	call check_reset
	COMPARE clue3answer1, a0
	brtc PC+2
	inc c1
	PRINTF LCD
.db	FSTR,b,0
	CA LCD_pos, $49
	call reset_kpd
	call check_reset
	COMPARE clue3answer2, a0
	brtc PC+2
	inc c1
	PRINTF LCD
.db	FSTR,b,0
	WAIT_MS 1000
	_CPI c1, 4
	breq correctpass
incorrectpass:
	DISPLAY2 strpassincorr, strpassincorrbis
	LOSER_SONG
	jmp main_loop
correctpass:
	DISPLAY1 strpasscorr
	VICTORY_SONG
	jmp end

games:
page1:
	DISPLAY2 strgame1, strgame2
	call reset_kpd
	call check_reset
	mov b0, a0
	cpi b0, 0x81 ; A
	brne PC+2
	ret
	cpi b0, 0x82 ; B
	brne PC+2
	ret
	cpi b0, 0x84 ; C
	brne PC+2
	ret
	cpi b0, 0x48 ; check if # key pressed
	brne page1
page2:
	DISPLAY1 strgame3
	call reset_kpd
	call check_reset
	mov b0, a0
	cpi b0, 0x81 ; A
	brne PC+2
	ret
	cpi b0, 0x82 ; B
	brne PC+2
	ret
	cpi b0, 0x84 ; C
	brne PC+2
	ret
	cpi b0, 0x48 ; check if # key pressed
	brne page2
	jmp games


trivia:
	DISPLAY2 strwelcome, strivia
	WAIT_MS 2000
	DISPLAY2 strivia2, strivia3
	WAIT_MS 2000
	_LDI c1, 0x00
	QUESTION striviaQ1, striviaQ12, strivia1A, strivia1B, strivia1C, strivia1D
	COMPARE answer1, b0
	brtc PC+2
	inc c1
	PRINT_SCORE c1
	WAIT_MS 2000
	QUESTION striviaQ2, striviaQ22, strivia2A, strivia2B, strivia2C, strivia2D
	COMPARE answer2, b0
	brtc PC+2
	inc c1
	PRINT_SCORE c1
	WAIT_MS 2000
	QUESTION striviaQ3, striviaQ32, strivia3A, strivia3B, strivia3C, strivia3D
	COMPARE answer3, b0
	brtc PC+2
	inc c1
	PRINT_SCORE c1
	WAIT_MS 2000
	QUESTION striviaQ4, striviaQ42, strivia4A, strivia4B, strivia4C, strivia4D
	COMPARE answer4, b0
	brtc PC+2
	inc c1
	PRINT_SCORE c1
	WAIT_MS 2000
	QUESTION striviaQ5, striviaQ52, strivia5A, strivia5B, strivia5C, strivia5D
	COMPARE answer5, b0
	brtc PC+2
	inc c1
	PRINT_SCORE c1
	WAIT_MS 2000
	QUESTION striviaQ6, striviaQ62, strivia6A, strivia6B, strivia6C, strivia6D
	COMPARE answer6, b0
	brtc PC+2
	inc c1
	PRINT_SCORE c1
	WAIT_MS 2000
	QUESTION striviaQ7, striviaQ72, strivia7A, strivia7B, strivia7C, strivia7D
	COMPARE answer7, b0
	brtc PC+2
	inc c1
	PRINT_SCORE c1
	WAIT_MS 2000
	QUESTION striviaQ8, striviaQ82, strivia8A, strivia8B, strivia8C, strivia8D
	COMPARE answer8, b0
	brtc PC+2
	inc c1
	PRINT_SCORE c1
	WAIT_MS 2000
	QUESTION striviaQ9, striviaQ92, strivia9A, strivia9B, strivia9C, strivia9D
	COMPARE answer9, b0
	brtc PC+2
	inc c1
	PRINT_SCORE c1
	WAIT_MS 2000
	QUESTION striviaQ10, striviaQ102, strivia10A, strivia10B, strivia10C, strivia10D
	COMPARE answer10, b0
	brtc PC+2
	inc c1
	PRINT_SCORE c1
	WAIT_MS 2000
	ldi w, 0x05
	cp c1, w
	brsh trivia_won
	jmp trivia_lost
trivia_won:
    DISPLAY2 strwin1, strwin2
	CELEBRATE_song
	DISPLAY2 strclue1a, strclue1b
	WAIT_MS 4000
	jmp main_loop
trivia_lost:
	DISPLAY2 strlose1, strlose2
	LOSE_SONG
	jmp main_loop

lava:
	DISPLAY2 strwelcome, strlava
	WAIT_MS 2000
	DISPLAY1 strlava2
	WAIT_MS 2000
	; start counter of game wins
	_LDI c1, 0x00
	DISPLAY1 strlava3
	WAIT_MS 2000
 ; add at least 0.5C
	call reset_wire
	sub b0, d0 ;compare final value with intial one
	sbc b1, d1
	ldi a0, 0x08 ; 0x0008 = +0.5 degree. Goal to reach
	ldi a1, 0x00
	cp b0, a0
	cpc b1, a1
	brmi PC+2
	jmp win1
	jmp lost1
win1:
	DISPLAY1 strlavawin1
	CORRECT_SONG
	inc c1
	jmp task2
lost1:
	DISPLAY1 strlavalost
	INCORRECT_SONG
	jmp task2
task2:
	DISPLAY1 strlava4
	WAIT_MS 2000
 ; add at least 0.5-1C
	call reset_wire
	sub b0, d0 ;compare final value with intial one
	sbc b1, d1
	ldi a0, 0x08 ; 0x0008 = +0.5 degree. Goal to reach
	ldi a1, 0x00
	cp b0, a0
	cpc b1, a1
	brmi lost2a
	ldi a0, 0x10 ; 0x0008 = +0.5 degree. Goal to reach
	ldi a1, 0x00
	sub b0, a0
	sbc b1, a1
	brmi PC+2
	jmp lost2b
win2:
	call LCD_clear
	DISPLAY1 strlavawin1
	CORRECT_SONG
	inc c1
	jmp task3
lost2a:
	DISPLAY1 strlavalost
	INCORRECT_SONG
	jmp task3
lost2b:
	DISPLAY1 strlavahot
	INCORRECT_SONG
	jmp task3
task3:
	DISPLAY1 strlava5
	WAIT_MS 2000
 ; add at least 1C
	call reset_wire
	sub b0, d0 ;compare final value with intial one
	sbc b1, d1
	ldi a0, 0x10 ; 0x0010 = +1 degree. Goal to reach
	ldi a1, 0x00
	cp b0, a0
	cpc b1, a1
	brmi lost3
win3:
	DISPLAY1 strlavawin1
	CORRECT_SONG
	inc c1
	jmp end_game
lost3:
	DISPLAY1 strlavalost
	INCORRECT_SONG
	jmp end_game
end_game:
	ldi w, 0x02
	cp c1, w
	brsh lava_won
	jmp lava_lost
lava_won:
    DISPLAY2 strlavawin1, strlavawin2
	CELEBRATE_song
	DISPLAY2 strclue2a, strclue2b
	WAIT_MS 4000
	jmp main_loop
lava_lost:
	DISPLAY2 strlose1, strlose2
	LOSE_SONG
	jmp main_loop


dance:
sequence1:
	DISPLAY2 strwelcome, strdance
	WAIT_MS 2000
	DISPLAY2 strdance2, strdance3
	WAIT_MS 2000
	DISPLAY2 strdance4, strdance5
	WAIT_MS 2000
	DISPLAY2 strdance_game1, strdance_
	WAIT_MS 2000
	call LCD_clear
	PRINTF LCD
.db	"****************",0
	CA LCD_pos, $40
	PRINTF LCD
.db	"****************",0
	_LDI c1, 0 ; counter for each game
	_LDI c2, 0 ; overall counter
	call reset_kpd
	call check_reset
	COMPARE game1answer1, a0
	brtc PC+2
	inc c1
	CA LCD_pos, $40
	PRINTF LCD
.db	"******",FSTR,b,"********",0
	CA LCD_pos, $47 
	call reset_kpd
	call check_reset
	COMPARE game1answer2, a0
	brtc PC+2
	inc c1
	PRINTF LCD
.db	FSTR,b,0
	CA LCD_pos, $48 
	call reset_kpd
	call check_reset
	COMPARE game1answer3, a0
	brtc PC+2
	inc c1
	PRINTF LCD
.db	FSTR,b,0
	WAIT_MS 2000
	_CPI c1, 3
	brne lose_1
	jmp win_1
lose_1:
	DISPLAY1 strfalse
	WAIT_MS 2000
	jmp sequence2
win_1:
	DISPLAY1 strcorrect
	WAIT_MS 2000
	inc c2
	jmp sequence2
sequence2:
	_LDI c1, 0 ; counter for each game
	DISPLAY2 strdance4, strdance5
	WAIT_MS 2000
	DISPLAY2 strdance_game2, strdance_
	WAIT_MS 2000
	call LCD_clear
	PRINTF LCD
.db	"****************",0
	CA LCD_pos, $40
	PRINTF LCD
.db	"****************",0
	call reset_kpd
	call check_reset
	COMPARE game2answer1, a0
	brtc PC+2
	inc c1
	CA LCD_pos, $40
	PRINTF LCD
.db	"*****",FSTR,b,"*********",0
	CA LCD_pos, $46
	call reset_kpd
	call check_reset
	COMPARE game2answer2, a0
	brtc PC+2
	inc c1
	PRINTF LCD
.db	FSTR,b,0
	CA LCD_pos, $47 
	call reset_kpd
	call check_reset
	COMPARE game2answer3, a0
	brtc PC+2
	inc c1
	PRINTF LCD
.db	FSTR,b,0
	CA LCD_pos, $48 
	call reset_kpd
	call check_reset
	COMPARE game2answer4, a0
	brtc PC+2
	inc c1
	PRINTF LCD
.db	FSTR,b,0
	CA LCD_pos, $49 
	call reset_kpd
	call check_reset
	COMPARE game2answer5, a0
	brtc PC+2
	inc c1
	PRINTF LCD
.db	FSTR,b,0
CA LCD_pos, $4a 
	call reset_kpd
	call check_reset
	COMPARE game2answer6, a0
	brtc PC+2
	inc c1
	PRINTF LCD
.db	FSTR,b,0
	WAIT_MS 2000
	_CPI c1, 6
	brne lose_2
	jmp win_2
lose_2:
	DISPLAY1 strfalse
	WAIT_MS 2000
	jmp sequence3
win_2:
	DISPLAY1 strcorrect
	WAIT_MS 2000
	inc c2
	jmp sequence3
sequence3:
	_LDI c1, 0 ; counter for each game
	DISPLAY2 strdance4, strdance5
	WAIT_MS 2000
	DISPLAY2 strdance_game3, strdance_
	WAIT_MS 2000
	call LCD_clear
	PRINTF LCD
.db	"****************",0
	CA LCD_pos, $40
	PRINTF LCD
.db	"****************",0
	call reset_kpd
	call check_reset
	COMPARE game3answer1, a0
	brtc PC+2
	inc c1
	CA LCD_pos, $40
	PRINTF LCD
.db	"***",FSTR,b,"************",0
	CA LCD_pos, $44
	call reset_kpd
	call check_reset
	COMPARE game3answer2, a0
	brtc PC+2
	inc c1
	PRINTF LCD
.db	FSTR,b,0
	CA LCD_pos, $45 
	call reset_kpd
	call check_reset
	COMPARE game3answer3, a0
	brtc PC+2
	inc c1
	PRINTF LCD
.db	FSTR,b,0
	CA LCD_pos, $46 
	call reset_kpd
	call check_reset
	COMPARE game3answer4, a0
	brtc PC+2
	inc c1
	PRINTF LCD
.db	FSTR,b,0
	CA LCD_pos, $47 
	call reset_kpd
	call check_reset
	COMPARE game3answer5, a0
	brtc PC+2
	inc c1
	PRINTF LCD
.db	FSTR,b,0
	CA LCD_pos, $48
	call reset_kpd
	call check_reset
	COMPARE game3answer6, a0
	brtc PC+2
	inc c1
	PRINTF LCD
.db	FSTR,b,0
	CA LCD_pos, $49 
	call reset_kpd
	call check_reset
	COMPARE game3answer7, a0
	brtc PC+2
	inc c1
	PRINTF LCD
.db	FSTR,b,0
	CA LCD_pos, $4a
	call reset_kpd
	call check_reset
	COMPARE game3answer8, a0
	brtc PC+2
	inc c1
	PRINTF LCD
.db	FSTR,b,0
	CA LCD_pos, $4b
	call reset_kpd
	call check_reset
	COMPARE game3answer9, a0
	brtc PC+2
	inc c1
	PRINTF LCD
.db	FSTR,b,0
	CA LCD_pos, $4c
	call reset_kpd
	call check_reset
	COMPARE game3answer10, a0
	brtc PC+2
	inc c1
	PRINTF LCD
.db	FSTR,b,0
	WAIT_MS 2000
	_CPI c1, 10
	brne lose_3
	jmp win_3
lose_3:
	DISPLAY1 strfalse
	WAIT_MS 2000
	jmp final_keypad
win_3:
	DISPLAY1 strcorrect
	WAIT_MS 2000
	inc c2
	jmp final_keypad
final_keypad:
	_CPI c2, 2
	brsh keypad_won
	jmp keypad_lost
keypad_won:
    DISPLAY2 strwin1, strwin2
	CELEBRATE_song
	DISPLAY2 strclue3, strclue3b
	WAIT_MS 4000
	jmp main_loop
keypad_lost:
	DISPLAY2 strlose1, strlose2
	LOSE_SONG
	jmp main_loop

end:
	DISPLAY2 str10, str11
	WAIT_MS 2000
	DISPLAY2 strcred, strcred2
	WAIT_MS 2000
	jmp reset

check_reset:
	mov c0, a0
	_CPI c0, 0x18 ; check if * key pressed
	brne PC+2
	jmp reset
	ret