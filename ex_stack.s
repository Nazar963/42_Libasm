section .text
    global _start

; Function A - Pushes a value onto the stack
functionA:
    push rdi    ; Assume RDI contains the integer to be pushed onto the stack
    call functionB
    ret

; Function B - Pops a value from the stack
functionB:
    pop rax     ; Pops the top of the stack into RAX
    ; Do something with RAX here
    ret

_start:
    mov rdi, 123    ; Load an integer value into RDI
    call functionA
    ; Your code for program termination goes here
    ; For example, a system call to exit if you're on Linux