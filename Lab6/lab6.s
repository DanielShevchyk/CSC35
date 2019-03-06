.data

hello:
	.ascii "Hello World\n"

message:
	.ascii "My Name Is Daniel Shevchyk\n"

message2:
	.ascii "My NaMe Is JeFf\n"




.text

Task:

.global _start

_start:

        mov $1, %rax
        mov $1, %rdi
        mov $hello, %rsi
        mov $12, %rdx
        syscall
	
	
	mov $1, %rax
        mov $1, %rdi
        mov $message, %rsi
        mov $27, %rdx
        syscall
        

	mov $1, %rax
        mov $1, %rdi
        mov $message2, %rsi
        mov $16, %rdx
        syscall
       
	mov $60, %rax
	mov $0, %rdi
	syscall





