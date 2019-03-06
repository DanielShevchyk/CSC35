.data

mssg1:
	.ascii "Guess a number from 1 to 99\n\0"
runtime:
	.ascii "Guess: \n\0"
mssg2:
	.ascii "Lower\n\0"
mssg3:
	.ascii "Higher\n\0"
finish:
	.ascii "Correct! It took you a total of \0"
finish2:
	.ascii " guesses! \n\0"





.text
.global _start

_start:

	mov $100, %rax
	mov $1 , %rcx
	call Random
	mov %rax, %rbx
	mov $mssg1, %rax
	call PrintCString
	
run:
	mov $runtime, %rax
	call PrintCString
	call ScanInt
	cmp %rax, %rbx
	je correct
	add $1 , %rcx
	cmp %rax, %rbx
	jg higher
	cmp %rax, %rbx
	jl lower

correct:
	mov $finish, %rax
	call PrintCString
	mov %rcx, %rax
	call PrintInt
	mov $finish2, %rax
	call PrintCString
	call EndProgram 
	
higher:
	mov $mssg3, %rax
	call PrintCString
	jmp run
lower:
	mov $mssg2, %rax
	call PrintCString
	jmp run

	
