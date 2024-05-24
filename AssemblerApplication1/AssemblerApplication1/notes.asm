 .macro DO
	ldi xl , low(@0)
	ldi xh, high(@0)
loop:
	sbi	PORTE,SPEAKER
	WAIT_US	 15290/@1
	cbi	PORTE,SPEAKER
	WAIT_US	15290/@1
		sbiw xl:xh,1
		brne loop
.endmacro

.macro DOb
	ldi xl , low(@0)
	ldi xh, high(@0)

loop:
	sbi	PORTE,SPEAKER
	WAIT_US	 14432/@1
	cbi	PORTE,SPEAKER
	WAIT_US	14432/@1

	sbiw xl:xh,1
	brne loop
	
.endmacro

.macro RE
	ldi xl , low(@0)
	ldi xh, high(@0)

loop:
	sbi	PORTE,SPEAKER
	WAIT_US	 13622/@1

	cbi	PORTE,SPEAKER
	WAIT_US	13622/@1

	sbiw xl:xh,1
	brne loop
	
.endmacro


.macro REb
	ldi xl , low(@0)
	ldi xh, high(@0)


loop:
	sbi	PORTE,SPEAKER
	WAIT_US	 12857/@1
	cbi	PORTE,SPEAKER
	WAIT_US	12857/@1

	sbiw xl:xh,1
	brne loop
	
.endmacro


.macro MI
	ldi xl , low(@0)
	ldi xh, high(@0)


loop:
	sbi	PORTE,SPEAKER
	WAIT_US	 12136/@1

	cbi	PORTE,SPEAKER
	WAIT_US	12136/@1

	sbiw xl:xh,1
	brne loop
	
.endmacro


.macro FA
	ldi xl , low(@0)
	ldi xh, high(@0)


loop:
	sbi	PORTE,SPEAKER
	WAIT_US	 11455/@1

	cbi	PORTE,SPEAKER
	WAIT_US	11455/@1

	sbiw xl:xh,1
	brne loop
	
.endmacro


.macro FAb
	ldi xl , low(@0)
	ldi xh, high(@0)

loop:
	sbi	PORTE,SPEAKER
	WAIT_US	 10812/@1

	cbi	PORTE,SPEAKER
	WAIT_US	10812/@1

	sbiw xl:xh,1
	brne loop
	
.endmacro


.macro SOL
	ldi xl , low(@0)
	ldi xh, high(@0)


loop:
	sbi	PORTE,SPEAKER
	WAIT_US	 10205/@1

	cbi	PORTE,SPEAKER
	WAIT_US	10205/@1

	sbiw xl:xh,1
	brne loop
.endmacro


.macro SOLb
	ldi xl , low(@0)
	ldi xh, high(@0)

loop:
	sbi	PORTE,SPEAKER
	WAIT_US	 9632/@1

	cbi	PORTE,SPEAKER
	WAIT_US	 9632/@1

	sbiw xl:xh,1
	brne loop
	
.endmacro


.macro LA
	ldi xl , low(@0)
	ldi xh, high(@0)


loop:
	sbi	PORTE,SPEAKER
	WAIT_US	 9091/@1

	cbi	PORTE,SPEAKER
	WAIT_US	9091/@1

	sbiw xl:xh,1
	brne loop
	
.endmacro


.macro LAb
	ldi xl , low(@0)
	ldi xh, high(@0)

loop:
	sbi	PORTE,SPEAKER
	WAIT_US	 8581/@1

	cbi	PORTE,SPEAKER
	WAIT_US	8581/@1

	sbiw xl:xh,1
	brne loop
	
.endmacro


.macro SI
	ldi xl , low(@0)
	ldi xh, high(@0)

loop:
	sbi	PORTE,SPEAKER
	WAIT_US	 8100/@1

	cbi	PORTE,SPEAKER
	WAIT_US	8100/@1

	sbiw xl:xh,1
	brne loop
	
.endmacro


;==========routine d'initialisation=================

init_music :
	sbi	DDRE,SPEAKER
ret












	
