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

strivia2:
.db "Answer 5/10 co-",0

strivia3:
.db "rrectly to win",0

strclue1a:
.db "1st clue:",0

strclue1b:
.db "SNOW WHITE",0

strwin1:
.db "CONGRATULATIONS",0

strwin2:
.db "YOU WIN",0

strlose1:
.db "YOU LOSE,",0

strlose2:
.db "TRY AGAIN",0

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
.db "A. PLAYBOI CARTI", 0
strivia1B:
.db "B. TRACY CHAPMAN", 0
strivia1C:
.db "C. A. SCHMID", 0
strivia1D:
.db "D. M. JACKSON", 0
answer1:
.db 0xef

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
.db "C. PLAYBOI CARTI", 0
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
.db "A. PLAYBOI CARTI", 0
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

; Question 5
striviaQ5:
.db "Who teaches", 0
striviaQ52:
.db "MCU best?", 0
strivia5A:
.db "A. PLAYBOI CARTI", 0
strivia5B:
.db "B. A. SCHMID", 0
strivia5C:
.db "C. M. ALI", 0
strivia5D:
.db "D. CR 7", 0
answer5:
.db 0xfb

; Question 6
striviaQ6:
.db "Who won the 2022", 0
striviaQ62:
.db "FIFA World Cup?", 0
strivia6A:
.db "A. PLAYBOI CARTI", 0
strivia6B:
.db "B. SWITZERLAND", 0
strivia6C:
.db "C. ARGENTINA", 0
strivia6D:
.db "D. FRANCE", 0
answer6:
.db 0xf7

; Question 7
striviaQ7:
.db "Which dish is", 0
striviaQ72:
.db "not swiss?", 0
strivia7A:
.db "A. PLAYBOI CARTI", 0
strivia7B:
.db "B. RACLETTE", 0
strivia7C:
.db "C. FONDUE", 0
strivia7D:
.db "D. ROESTI", 0
answer7:
.db 0xfd

; Question 8
striviaQ8:
.db "What's the capi-", 0
striviaQ82:
.db "tal of Laos?", 0
strivia8A:
.db "A. LAOS", 0
strivia8B:
.db "B. VIENTIANE", 0
strivia8C:
.db "C. VENICE", 0
strivia8D:
.db "D. PLAYBOI CARTI", 0
answer8:
.db 0xfb

; Question 9
striviaQ9:
.db "What's the best", 0
striviaQ92:
.db "section at EPFL?", 0
strivia9A:
.db "A. LIFE SCIENCES", 0
strivia9B:
.db "B. MICROTECH", 0
strivia9C:
.db "C. ELEC", 0
strivia9D:
.db "D. PLAYBOI CARTI", 0
answer9:
.db 0xf7

; Question 10
striviaQ10:
.db "Who wrote the", 0
striviaQ102:
.db "song 'sky'?", 0
strivia10A:
.db "A. KANYE WEST", 0
strivia10B:
.db "B. PLAYBOI CARTI", 0
strivia10C:
.db "C. A. SCHMID", 0
strivia10D:
.db "D. TAYLOR SWIFT", 0
answer10:
.db 0xfb