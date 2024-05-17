;
; AssemblerApplication1.asm
;
; Created: 30/04/2024 10:34:37
; Author : renuka
; File containing all strings to 
; print on LCD screen


.cseg

; Menu of game
str0:
.db "WELCOME TO ", 0
str1:
.db "MCU PARTY", 0
str2:
.db "1. PLAY GAME", 0
str3:
.db "2. OPEN SAFE", 0

; general
strwelcome:
.db "Welcome to",0

strivia:
.db "trivia :)",0

strbutton:
.db "the button :)",0

strcorrect:
.db "Correct!",0

strfalse:
.db "False!",0

; Choose games
str4:
.db "1. TRIVIA QUIZ", 0
str5:
.db "2. BUTTON DANCE", 0

; Open safe
str6:
.db "ENTER PASSCODE", 0
str7:
.db "INCORRECT PASSCODE", 0
str8:
.db "CONGRATULATIONS, ", 0
str9:
.db "YOU WIN THIS GAME !", 0
str10:
.db "THANKS FOR", 0
str11:
.db "PLAYING! :D", 0

; Quiz trivia
; Question 1
striviaQ1:
.db "Who wrote the", 0
striviaQ12:
.db "song 'thriller'?", 0
strivia1A:
.db "A. M. JACKSON", 0
strivia1B:
.db "B. TRACY CHAPMAN", 0
strivia1C:
.db "C. A. SCHMID", 0
strivia1D:
.db "D. CHER", 0
answer1:
.db 0xfd

; Question 2
striviaQ2:
.db "Who plays", 0
striviaQ22:
.db "Hermione?", 0
strivia2A:
.db "A. EMMA WATSON", 0
strivia2B:
.db "B. EMMA STONE", 0
strivia2C:
.db "C. AMY ADAMS", 0
strivia2D:
.db "D. ZOE SALDANA", 0
answer2:
.db 0xfd

; Question 3
striviaQ3:
.db "Which band wrote", 0
striviaQ32:
.db "'hey you' ?", 0
strivia3A:
.db "A. SPICE GIRLS", 0
strivia3B:
.db "B. LED ZEPPLIN", 0
strivia3C:
.db "C. JOURNEY", 0
strivia3D:
.db "D. PINK FLOYD", 0
answer3:
.db 0xef

; Question 4
striviaQ4:
.db "Who wrote 'Air", 0
striviaQ42:
.db "on G string'?", 0
strivia4A:
.db "A. PLAYBOI CARTI", 0
strivia4B:
.db "B. BEETHOVEN", 0
strivia4C:
.db "C. SCHUBERT", 0
strivia4D:
.db "D. J.S. BACH", 0
answer4:
.db 0xef


