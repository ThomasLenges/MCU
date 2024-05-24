; file	wire1_temp2.asm		
; purpose Dallas 1-wire(R) temperature sensor interfacing: temperature
; module: M5, input port: PORTB

; === initialization (reset) ===
reset_wire:		
	rcall	wire1_init		; initialize 1-wire(R) interface
	OUTI TIMSK, (1<<TOIE0)  ; timer0 overflow interrupt enable
	OUTI ASSR, (1<<AS0)
	OUTI TCCR0, 7
	sei
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
	mov	a1,a0
	mov	a0,c0

	CA lcd_pos, $40
	PRINTF	LCD
.db	"temp=",FFRAC2+FSIGN,a,4,$42,"C ",CR,0
	in c0, TIMSK 
	sbrc c0, 0
	jmp main_wire
	ret
