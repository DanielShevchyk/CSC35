.data
Message:
	.ascii "This is a greeting. Hello.\n\0"

Message1:
	.ascii "My name is Daniel Shevchyk\n\0"

Message2:
	.ascii "Time is merely a perception of decay and spacial expansion\n\0"

Message3:
	.ascii "I will graduate in \0"

Message4:
	.ascii " from Sacramento State!\n\0"


.text
.global _start

_start:
	mov $Message, %rax
	call PrintCString
	mov $Message1, %rax
	call PrintCString
	mov $Message2, %rax
	call PrintCString
	mov $Message3, %rax
	call PrintCString
	mov $2019, %rax
	call PrintInt
	mov $Message4, %rax
	call PrintCString

	call EndProgram

