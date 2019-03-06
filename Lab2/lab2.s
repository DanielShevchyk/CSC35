.data
Message:
	.ascii "Getting A F	: 10 points\n\0"
Message2:
	.ascii "Making a Mess   : 5 points\n\0"
Message3:
	.ascii "Being on time   : -10 points\n\0"
Question1:
	.ascii "How many F's did you get?\n\0"
Question2:
	.ascii "How many messes did you make?\n\0"
Question3:
	.ascii "How many times were you on time?\n\0"
Result1:
	.ascii "You got \0"
Result2:
	.ascii " madlad points!\n\0"

.text
.global _start

_start:
	mov $Message, %rax
	call PrintCString

	mov $Message2, %rax
	call PrintCString

	mov $Message3, %rax
	call PrintCString

	mov $Question1, %rax
	call PrintCString

	call ScanInt
	imul $10, %rax
	mov %rax, %rbx

	mov $Question2, %rax
	call PrintCString

	call ScanInt
	imul $5, %rax
	mov %rax, %rcx

	mov $Question3, %rax
	call PrintCString

	call ScanInt
	imul $-10, %rax
	mov %rax, %rdx

	mov $Result1, %rax
	call PrintCString

	add %rcx, %rbx
	add %rdx, %rbx
	mov %rbx, %rax
	call PrintInt

	mov $Result2, %rax
	call PrintCString

	call EndProgram


