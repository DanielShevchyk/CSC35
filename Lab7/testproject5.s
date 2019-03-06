.data     

title:
    .ascii "Welcome to What’s My Word! \n\0" 

player1Instruct:
    .ascii "\nPlayer 1, enter a word: \0" 
    
player2Instruct:
    .ascii "Player 2, your word is \0" 
    
guessInstruct:
    .ascii "\n\nYour Guess: \0" 
    
wrong:
    .ascii "Sorry, that is wrong.\n\n\0" 
  
guessL12:
    .ascii "Awesome work!\n\0" 
    
guessL34:
    .ascii "Good job!\n\0" 
    
guessL56:
    .ascii "Concentrate next time :D\n\0" 
    
guessL78:
    .ascii "Don't quite your day job.\n\0" 
    
guessL89:
    .ascii "Your guesses are over 9,000!!!!!!!!!!!!!!\n\0" 
    
rawAnswer:
    .space 30
  
hiddenAnswer:
    .space 30
    
guess:
    .space 30
     
outputL12:
    mov $guessL12, %rax
    call PrintCString
    jmp End

outputL34:
    mov $guessL34, %rax
    call PrintCString
    jmp End

outputL56:
    mov $guessL56, %rax
    call PrintCString
    jmp End

outputL78:
    mov $guessL78, %rax
    call PrintCString
    jmp End

outputL89:
    mov $guessL89, %rax
    call PrintCString
    jmp End
    
Nope:
    mov  $wrong, %rax
    call PrintCString           # Print incorrect guess message.
    add  $1, %r14               # Keep track of incorrect guesses.
    jmp Guess
    
verifyGuess:
    add $1, %r13
    cmp $30, %r13
    je  Right
    
    jmp Again
    
#-----------------------------------------------
#               Notes:
# %r15 - Counter for hidden player word loop.
# %r14 - Counter for number of guesses.
# %r13 - Counter for comparing characters in user's answer.
#
#-----------------------------------------------
     
.text                         
.global _start 

_start:
    
                 # Clear the screen.

    mov  $title, %rax              # Print the program title.           
    call PrintCString
    
    mov  $player1Instruct, %rax
    call PrintCString
    
    mov  $rawAnswer, %rax          #Address to write to
    mov  $30, %rbx                 #Max bytes to read (so no buffer overflow)
    call ScanCString
 
                 # Clear the screen.
  
    mov   $0, %r14                 # Set counter of keep track of guesses

    #-----------------------------------------------------------------------------

    # Copy Player 1's Word.

    mov  $0, %rdi                  # rdi = 0;

    While:
      cmp  $30, %rdi               # (rdi < 30) 
      je   Done                    # Leave loop on false

      mov  rawAnswer(%rdi), %al    # Copy[rdi] = Input[rdi];
      mov  %al, hiddenAnswer(%rdi)

      add  $1, %rdi                # rdi++;

      jmp  While
      
    Done:
      
    #-----------------------------------------------------------------------------

    # Hide Player 1's Word.

    mov  $0, %r15
    mov  $hiddenAnswer, %rax
    
    Hide:
      cmp $14, %r15
      jge Hidden

      add  $1, %r15                
      movb $45, hiddenAnswer(%r15)
      add  $1, %r15
      
      jmp Hide
      
    Hidden:
    
    #-----------------------------------------------------------------------------
    
    #Get the User's Guess.
    
    mov $0, %r14
    
    Guess:
      
      mov  $player2Instruct, %rax
      call PrintCString

      mov  $hiddenAnswer, %rax
      call PrintCString

      mov  $guessInstruct, %rax
      call PrintCString
      
      mov $guess, %rax

      call ScanCString

      mov $0, %r13 
      Again:
        mov  guess(%r13), %r12
        mov  rawAnswer(%r13), %r11
        cmp  %r12, %r11
        je   Right

      jmp Nope
      
  Right:
    
  cmp $2, %r14
  jle outputL12
  
  cmp $4, %r14
  jle outputL34
  
  cmp $6, %r14
  jle outputL56
    
  cmp $8, %r14
  jle outputL78
  
  cmp $10, %rax
  jle outputL89

  End:

  call EndProgram
