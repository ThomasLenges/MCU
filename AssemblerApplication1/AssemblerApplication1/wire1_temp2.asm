; file	wire1_temp2.asm		
; purpose Dallas 1-wire(R) temperature sensor interfacing: temperature
; module: M5, input port: PORTB

; === initialization (reset) ===
reset_wire:		
	rcall	wire1_init		; initialize 1-wire(R) interface
	OUTI TCNT0, 0x00
	OUTI TIMSK, (1<<TOIE0)  ; timer0 overflow interrupt enable
	OUTI ASSR, (1<<AS0)
	OUTI TCCR0, 7
	
	sei
	_LDI c3, 1
	rjmp	main_wire

; === main program ===
main_wire:
	rcall	wire1_reset			; send a reset pulse
	CA	wire1_write, skipROM	; skip ROM identification
	CA	wire1_write, convertT	; initiate temp conversion
	WAIT_MS	750					; wait 750 msec
	
	rcall	lcd_home			; place cursor to home position
	rcall	wire1_reset			; send a reset pulse
	CA	wire1_write, skipROM
	CA	wire1_write, readScratchpad	
	rcall	wire1_read			; read temperature LSB
	mov	c0,a0
	rcall	wire1_read			; read temperature MSB
	mov	b1,a0
	mov	b0,c0
	
	call LCD_clear
	CA lcd_pos, $40
	PRINTF	LCD
.db	"temp1=",FFRAC2+FSIGN,b,4,$42,"C ",CR,0
	_CPI c3, 0
	breq out_test
	mov d0, b0
	mov d1, b1
	_LDI c3,0
out_test:
	CA lcd_pos, $0
	PRINTF	LCD
.db	"temp0=",FFRAC2+FSIGN,d,4,$42,"C ",CR,0
	in c0, TCCR0 
	sbrc c0, 0
	jmp main_wire
	ret
