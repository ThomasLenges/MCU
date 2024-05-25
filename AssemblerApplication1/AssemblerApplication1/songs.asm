;.include "notes.asm"

.macro CELEBRATE_song
; 1e tonalité
	ldi a0, do2
	ldi b0, 65
	call sound
	WAIT_MS 4
	ldi a0, so
	ldi b0, 65
	call sound
	WAIT_MS 4
	ldi a0, do2
	ldi b0, 65
	call sound
	WAIT_MS 4
	ldi a0, mi2
	ldi b0, 65
	call sound
	WAIT_MS 4
	ldi a0, so2
	ldi b0, 65
	call sound
	WAIT_MS 4
	ldi a0, do3
	ldi b0, 65
	call sound
	WAIT_MS 4
	ldi a0, mi3
	ldi b0, 170
	call sound
	ldi a0, do3
	ldi b0, 170
	call sound
	WAIT_MS 50
; 2e tonalité
	ldi a0, dom2
	ldi b0, 65
	call sound
	WAIT_MS 4
	ldi a0, som
	ldi b0, 65
	call sound
	WAIT_MS 4
	ldi a0, dom2
	ldi b0, 65
	call sound
	WAIT_MS 4
	ldi a0, fa2
	ldi b0, 65
	call sound
	WAIT_MS 4
	ldi a0, som3
	ldi b0, 65
	call sound
	WAIT_MS 4
	ldi a0, dom3
	ldi b0, 65
	call sound
	WAIT_MS 4
	ldi a0, fa3
	ldi b0, 170
	call sound
	ldi a0, dom3
	ldi b0, 170
	call sound
	WAIT_MS 50
; 3e tonalité
	ldi a0, rem2
	ldi b0, 65
	call sound
	WAIT_MS 4
	ldi a0, lam
	ldi b0, 65
	call sound
	WAIT_MS 4
	ldi a0, rem2
	ldi b0, 65
	call sound
	WAIT_MS 4
	ldi a0, so2
	ldi b0, 65
	call sound
	WAIT_MS 4
	ldi a0, lam2
	ldi b0, 65
	call sound
	WAIT_MS 4
	ldi a0, rem3
	ldi b0, 170
	call sound
	ldi a0, fa3
	ldi b0, 200
	call sound
.endmacro

.macro LOSE_SONG
	ldi a0, si2
	ldi b0, 70
	call sound
	WAIT_MS 60

	ldi a0, fa3
	ldi b0, 70
	call sound
	WAIT_MS 90

	ldi a0, fa3
	ldi b0, 70
	call sound
	WAIT_MS 90

	ldi a0, fa3
	ldi b0, 70
	call sound
	WAIT_MS 90

	ldi a0, fa3
	ldi b0, 70
	call sound
	WAIT_MS 4
	ldi a0, mi3
	ldi b0, 70
	call sound
	WAIT_MS 4
	ldi a0, re3
	ldi b0, 70
	call sound
	WAIT_MS 4
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
    WAIT_MS 150
	
    ldi a0, mi2
    ldi b0, 90
    call sound
    WAIT_MS 80 
	
    ldi a0, do2
    ldi b0, 70
    call sound
    WAIT_MS 50 
	
    ldi a0, mi2
    ldi b0, 75
    call sound
    WAIT_MS 120
	
    ldi a0, so2
    ldi b0, 90
    call sound
    WAIT_MS 350 
	
    ldi a0, so
    ldi b0, 75
    call sound
    WAIT_MS 200 
	
	;2e part
    ldi a0, do2
    ldi b0, 75
    call sound
    WAIT_MS 200
	
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
    WAIT_MS 20

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
    WAIT_MS 30

	ldi a0, mi2
    ldi b0, 75
    call sound
    WAIT_MS 150

	ldi a0, re2
    ldi b0, 75
    call sound
    WAIT_MS 300
	
	ldi a0, so2
    ldi b0, 75
    call sound
    WAIT_MS	4
    
	ldi a0, fam2
    ldi b0, 75
    call sound
    WAIT_MS	4

	ldi a0, fa2
    ldi b0, 75
    call sound
    WAIT_MS 4

	ldi a0, mi2
    ldi b0, 75
    call sound
    WAIT_MS 150
	
	ldi a0, la
    ldi b0, 80
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
    ldi b0, 90
    call sound
    WAIT_MS 150

	ldi a0, re2
    ldi b0, 90
    call sound
    WAIT_MS 150

	ldi a0, do2
    ldi b0, 90
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
	ldi b0, 75
	call sound
	ldi a0, la2
	ldi b0, 75
	call sound
	ldi a0, dom3
	ldi b0,75
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

.macro VICTORY_SONG
	ldi a0, fa2
	ldi b0, 65
	call sound
	WAIT_MS 4
	ldi a0, fa2
	ldi b0, 65
	call sound
	WAIT_MS 4
	ldi a0, fa2
	ldi b0, 65
	call sound
	WAIT_MS 4
	ldi a0, lam2
	ldi b0, 200
	call sound
	WAIT_MS 50
	ldi a0, re3
	ldi b0, 150
	call sound
	WAIT_MS 50
	
	ldi a0, fa2
	ldi b0, 65
	call sound
	WAIT_MS 4
	ldi a0, fa2
	ldi b0, 65
	call sound
	WAIT_MS 4
	ldi a0, fa2
	ldi b0, 65
	call sound
	WAIT_MS 4
	ldi a0, lam2
	ldi b0, 200
	call sound
	WAIT_MS 50
	ldi a0, re3
	ldi b0, 150
	call sound
	WAIT_MS 50

	ldi a0, lam2
	ldi b0, 65
	call sound
	WAIT_MS 4
	ldi a0, lam2
	ldi b0, 65
	call sound
	WAIT_MS 4
	ldi a0, la2
	ldi b0, 65
	call sound
	WAIT_MS 4
	ldi a0, la2
	ldi b0, 65
	call sound
	WAIT_MS 4
	ldi a0, so2
	ldi b0, 65
	call sound
	WAIT_MS 4
	ldi a0, so2
	ldi b0, 65
	call sound
	WAIT_MS 4
	ldi a0, fa2
	ldi b0, 150
	call sound
	WAIT_MS 50



	ldi a0, fa2
	ldi b0, 65
	call sound
	WAIT_MS 4
	ldi a0, fa2
	ldi b0, 65
	call sound
	WAIT_MS 4
	ldi a0, fa2
	ldi b0, 65
	call sound
	WAIT_MS 4
	ldi a0, la2
	ldi b0, 200
	call sound
	WAIT_MS 50
	ldi a0, do3
	ldi b0, 150
	call sound
	WAIT_MS 50
	
	ldi a0, fa2
	ldi b0, 65
	call sound
	WAIT_MS 4
	ldi a0, fa2
	ldi b0, 65
	call sound
	WAIT_MS 4
	ldi a0, fa2
	ldi b0, 65
	call sound
	WAIT_MS 4
	ldi a0, la2
	ldi b0, 200
	call sound
	WAIT_MS 50
	ldi a0, do3
	ldi b0, 150
	call sound
	WAIT_MS 50

	ldi a0, fa3
	ldi b0, 65
	call sound
	WAIT_MS 4
	ldi a0, fa3
	ldi b0, 65
	call sound
	WAIT_MS 4
	ldi a0, rem3
	ldi b0, 65
	call sound
	WAIT_MS 4
	ldi a0, rem3
	ldi b0, 65
	call sound
	WAIT_MS 4
	ldi a0, re3
	ldi b0, 65
	call sound
	WAIT_MS 4
	ldi a0, re3
	ldi b0, 65
	call sound
	WAIT_MS 4
	ldi a0, do3
	ldi b0, 65
	call sound
	WAIT_MS 4
	ldi a0, do3
	ldi b0, 65
	call sound
	WAIT_MS 4
	ldi a0, lam2
	ldi b0, 150
	call sound
	WAIT_MS 50
.endmacro

.macro LOSER_SONG
	ldi a0, rem
	ldi b0, 250
	call sound
	ldi a0, re
	ldi b0, 250
	call sound
	ldi a0, dom
	ldi b0, 250
	call sound
	ldi a0, do
	ldi b0, 255
	call sound
.endmacro