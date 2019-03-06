#Daniel Shevchyk
#CSC 35 Project
#Brief and overview of program(Please read):
# I am aware of a multitude of faults in this code. Unnecssary ammount of registers used, funky
# while/if loops, etc. There is also some code thats not being used because I couldn't
# find the source of error. For example, the Hp bar is not activated because my counter for the currenty
# IMPORTANT: My dash checker that supposed to determine when the individual has guessed the whole word is
# also acting up. If you guess all the correct letters and then press enter, you will enter the end stage.

.data
	greeting:
		.ascii "Welcome to Mystery Word!\n\0"

	greeting2:
		.ascii "Player 1, enter a word: \0"

	threehealth:
		.ascii "\nHealth : |XXX| \n\0"

	twohealth:
		.ascii "\nHealth : |XX-| \n\0"

	onehealth:
		.ascii "\nHealth : |X--| \n\0"

	zerohealth:
		.ascii "\n Health : |---| \n\0"

	gameover:
		.ascii "Game Over! \n\0"
	
	wordrun:
		.ascii "Your secret word: \0"
	
	guess:
		.ascii "\n BUG:If all letters Guessed Correct, enter nothing to finish \n Guess a letter: \0 "
	
	congrats:
		
		.ascii "Congrats! You guessed the secret word! \n\0" 	
	nohealth:
	
		.ascii "You ran out HP! You've Died! Type a.out to play again. \n\0"
	cm:
		.ascii "You guessed \0"
	cmtwo:
		.ascii " times! If it took you more than 5 guesses, You lost XD. Type a.out to play again! \n\0"
inputbuffer:

	.space 40

buffertwo:

	.space 40
bufferthree:

	.space 40

.text

.global _start

_start:
	call ClearScreen	#clear screen
	

	mov $greeting, %rax
	call PrintCString
	mov $greeting2, %rax
	call PrintCString
	mov $inputbuffer, %rax
	mov $40, %rbx
	call ScanCString
	mov %rax, %rdx	
	call LengthCString
	mov %rax, %rcx
	mov $0, %rdi
	mov $0, %r15		#Current Health State - Default 0 (Full HP)
	mov $0, %r13		#dashcheck counter 

	call ClearScreen
loop:
	cmp $40, %rdi
	je end
	
	mov inputbuffer(%rdi), %al
	mov %al, buffertwo(%rdi)
	
	add $1, %rdi
	jmp loop

dashloop: 

	movb $45, (%rax,%rdi)	#moves dash ascii into base rax and index rdi	
	add $1, %rdi		#adds to index
	
	cmp %rcx, %rdi		#comparing index to length
	jl dashloop		#looping dash placement
	jmp mempush	

dashlooptwo:
	
	

	mov $wordrun, %rax	#Your Secret Word:
	call PrintCString
	mov %r10, %rax		#move dashed word
	call PrintCString	#print dashed word

	cmp $0, %r15
	jg hopone
		
	mov $threehealth, %rax	#default three hp bar
	call PrintCString
	jmp hophop
hopone:
	cmp $1, %r15		#two hp
	jg hoptwo

	mov $twohealth, %rax
	call PrintCString
	jmp hophop
hoptwo:
	cmp $2, %r15		#one hp
	jg hopthree

	mov $onehealth, %rax
	call PrintCString
	jmp hophop
hopthree:
	
	cmp $3, %r15		#no hp - dead
	jne hophop
	mov $zerohealth, %rax
	call PrintCString	
	jmp dead
hophop:

	mov $guess, %rax	
	call PrintCString
	
	call ScanChar
	mov %al, %bl
				
	mov $0, %rdi		#index set to 0
	jmp guessloop


end: 				#sets index for dashes in for the mystery word.
	mov $0, %rdi
	mov $buffertwo, %rax
	mov %rdx, %r14
	mov $inputbuffer, %r11
	jmp dashloop

mempush:
	mov %rax, %r10 		# Dashed word into r10
	jmp dashlooptwo	

guessloop:
	movb (%rdx, %rdi), %cl
	cmp %bl, %cl
	je correct
	
	jne wrong
	
correct:			#guessed letter correct loop
	
	movb %bl, (%r10,%rdi)
	
	add $1, %rdi
	cmp %rcx, %rdi
	jl guessloop
	mov $0, %rdi
	jmp dashcheck
				#update of dashed line aka, current status of dashed line after guess
	
	je completeguess
	jmp dashlooptwo

dashcheck:			#checks for remaining dashes (Kinda doesnt work, not sure why)
	
	movb (%r10, %rdi), %dl
	cmp $45, %dl
	je tick	
	jmp dashchecktwo

tick:
	add $1, %r13

dashchecktwo:

	add $1, %rdi
	cmp %rcx, %r13
	je completeguess
	cmp %rcx, %rdi
	je dashlooptwo
	jl dashcheck
	

wrong:
	add $1, %rdi 		#move 1 index
	cmp %rcx, %rdi
	jl guessloop
	mov $buffertwo, %rax
	mov %rax, %r10 
	add $1, %r12		#counts failed guesses
	jmp dashlooptwo

completeguess:			#End - Win
	call ClearScreen
	mov $congrats, %rax	
	call PrintCString
	mov $cm, %rax
	call PrintCString
	mov %r12, %rax
	call PrintInt
	mov $cmtwo, %rax
	call PrintCString
	
	call EndProgram

dead:				#End - Dead

	mov $nohealth, %rax
	call PrintCString
	
	
	
	call EndProgram
