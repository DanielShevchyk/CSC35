.data

	messageStart: .ascii  "I'M MR. MEEKSEEKS. LOOK AT ME! \n\0"

	messageEnd: .ascii "? OOOOOOOO WEEEEEEE CAAANNNN DOOOOO!\n\0"

Task:
	.space 40

.text

.global _start

_start:
	mov $messageStart, %rax
	call PrintCString
	mov $Task, %rbx
	call ScanCString
	mov %rax, %rcx
	call LengthCString
	mov %rax, %rdx
	mov $0, %rdi
loop:
	cmp %rdi, %rdx
	je terminal
	movb (%rcx, %rdi), %al
	cmp $96, %al
	jg bigger
	add $1, %rdi
	jmp loop
bigger:
	sub $32, %al
	movb %al, (%rcx, %rdi)
	add $1, %rdi
	jmp loop
terminal:
	mov %rcx, %rax
	call PrintCString
	mov $messageEnd, %rax
	call PrintCString
	call EndProgram	
