;.include "notes.asm"

.macro CELEBRATE_song
; 1e tonalité
	ldi a0, do2
	ldi b0, 80
	call sound

	ldi a0, so
	ldi b0, 60
	call sound

	ldi a0, do2
	ldi b0, 80
	call sound

	ldi a0, mi2
	ldi b0, 60
	call sound

	ldi a0, so2
	ldi b0, 60
	call sound

	ldi a0, do3
	ldi b0, 60
	call sound

	ldi a0, mi3
	ldi b0, 170
	call sound

	ldi a0, do3
	ldi b0, 170
	call sound

; 2e tonalité
	ldi a0, dom2
	ldi b0, 80 
	call sound

	ldi a0, som
	ldi b0, 60
	call sound

	ldi a0, dom2
	ldi b0, 80
	call sound

	ldi a0, fa2
	ldi b0, 60
	call sound

	ldi a0, som3
	ldi b0, 60
	call sound

	ldi a0, dom3
	ldi b0, 60
	call sound

	ldi a0, fa3
	ldi b0, 170
	call sound

	ldi a0, dom3
	ldi b0, 170
	call sound

; 3e tonalité
	ldi a0, rem2
	ldi b0, 80
	call sound

	ldi a0, lam
	ldi b0, 60
	call sound

	ldi a0, rem2
	ldi b0, 80
	call sound

	ldi a0, so2
	ldi b0, 60
	call sound

	ldi a0, lam2
	ldi b0, 60
	call sound

	ldi a0, rem3
	ldi b0, 170
	call sound

	ldi a0, fa3
	ldi b0, 200
	call sound
.endmacro

.macro LOSE_SONG
	ldi a0, si2
	ldi b0, 80
	call sound
	WAIT_MS 60

	ldi a0, fa3
	ldi b0, 90
	call sound
	WAIT_MS 60

	ldi a0, fa3
	ldi b0, 70
	call sound
	WAIT_MS 60

	ldi a0, fa3
	ldi b0, 70
	call sound
	WAIT_MS 60

	ldi a0, fa3
	ldi b0, 70
	call sound

	ldi a0, mi3
	ldi b0, 70
	call sound

	ldi a0, re3
	ldi b0, 70
	call sound

	ldi a0, do3
	ldi b0, 140
	call sound
	WAIT_MS 700

	ldi a0, do3
	ldi b0, 100
	call sound

	ldi a0, so2
	ldi b0, 100
	call sound

	ldi a0, mi2
	ldi b0, 100
	call sound

	ldi a0, lam2
	ldi b0, 100
	call sound

	ldi a0, do3
	ldi b0, 100
	call sound

	ldi a0, lam2
	ldi b0, 100
	call sound

	ldi a0, som2
	ldi b0, 100
	call sound

	ldi a0, lam2
	ldi b0, 100
	call sound

	ldi a0, som2
	ldi b0, 100
	call sound

	ldi a0, so2
	ldi b0, 80
	call sound

	ldi a0, fa2
	ldi b0, 60
	call sound

	ldi a0, so2
	ldi b0, 150
	call sound
.endmacro

.macro MENU_SONG
    ; 1e part
    ldi a0, mi2
    ldi b0, 75
    call sound
    WAIT_MS 60 
    ldi a0, mi2
    ldi b0, 75
    call sound
    WAIT_MS 90
    ldi a0, mi2
    ldi b0, 75
    call sound
    WAIT_MS 60 

    ldi a0, do2
    ldi b0, 70
    call sound
    WAIT_MS 60 

    ldi a0, mi2
    ldi b0, 75
    call sound
    WAIT_MS 60

    ldi a0, so2
    ldi b0, 75
    call sound
    WAIT_MS 300 

    ldi a0, so
    ldi b0, 75
    call sound
    WAIT_MS 150 
	;2e part
    ldi a0, do2
    ldi b0, 75
    call sound
    WAIT_MS 100

    ldi a0, so
    ldi b0, 75
    call sound
    WAIT_MS 100

    ldi a0, mi
    ldi b0, 75
    call sound
    WAIT_MS 100

    ldi a0, la
    ldi b0, 75
    call sound
    WAIT_MS 60 

    ldi a0, si
    ldi b0, 75
    call sound
    WAIT_MS 60

    ldi a0, la
    ldi b0, 75
    call sound
    WAIT_MS 60 

    ldi a0, so
    ldi b0, 75
    call sound
    WAIT_MS 50

    ldi a0, do2
    ldi b0, 75
    call sound
    WAIT_MS 50

	ldi a0, mi2
    ldi b0, 75
    call sound
    WAIT_MS 50

	ldi a0, so2
    ldi b0, 75
    call sound
    WAIT_MS 50

	ldi a0, la2
    ldi b0, 75
    call sound
    WAIT_MS 80

	ldi a0, fa2
    ldi b0, 75
    call sound
    WAIT_MS 50

	ldi a0, so2
    ldi b0, 75
    call sound
    WAIT_MS 60

	ldi a0, mi2
    ldi b0, 75
    call sound
    WAIT_MS 100

	ldi a0, re2
    ldi b0, 75
    call sound
    WAIT_MS 100

	ldi a0, so2
    ldi b0, 75
    call sound
    WAIT_MS 20
    
	ldi a0, fam2
    ldi b0, 75
    call sound
    WAIT_MS 20

	ldi a0, fa2
    ldi b0, 75
    call sound
    WAIT_MS 20

	ldi a0, mi2
    ldi b0, 75
    call sound
    WAIT_MS 80

	ldi a0, la
    ldi b0, 75
    call sound
    WAIT_MS 60

	ldi a0, do2
    ldi b0, 75
    call sound
    WAIT_MS 60

	ldi a0, re2
    ldi b0, 75
    call sound
    WAIT_MS 150

	ldi a0, rem2
    ldi b0, 75
    call sound
    WAIT_MS 150

	ldi a0, re2
    ldi b0, 75
    call sound
    WAIT_MS 150

	ldi a0, do2
    ldi b0, 75
    call sound
    WAIT_MS 100

	ldi a0, do3
    ldi b0, 75
    call sound
    WAIT_MS 80

	ldi a0, do3
    ldi b0, 75
    call sound
    WAIT_MS 50

	ldi a0, do3
    ldi b0, 75
    call sound
    WAIT_MS 50
.endmacro

.macro CORRECT_SONG
	WAIT_MS 500
	ldi a0, dom3
	ldi b0, 5
	call sound
	ldi a0, la2
	call sound
	ldi a0, dom3
	call sound
	ldi a0, la2
	call sound
.endmacro

.macro INCORRECT_SONG
	WAIT_MS 500
	ldi a0, do
	ldi b0, 30
	call sound
	ldi a0, do
	call sound
.endmacro