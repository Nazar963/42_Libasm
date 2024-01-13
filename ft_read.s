section .data
	error db "Hi, There's an error here!",10,0

section .text
	global ft_read
	extern __errno_location

ft_read:
	mov rax, 0
	syscall
	cmp rax, 0
	jl _syscallError
	ret

_error_handle:
	mov rax, 1
	mov rdi, 1
	mov rsi, error
	mov rdx, 28
	syscall

	cmp rax, 0
	jl _syscallError

	xor rax, rax
	ret

_syscallError:
	mov rbx, rax
	call __errno_location wrt ..plt
	neg rbx
	mov [rax], rbx

	mov rax, 60
	mov rdi, 1
	syscall


; section .data
; 	error db "Hi, There's an error here!",10,0
; 	format db "%s",0 ;? Format for the printf call

; section .bss
; 	buff resb 20

; section .text
; 	global main
; 	; global ft_read
; 	extern __errno_location
; 	extern printf


; main:
; 	mov rdi, 0 ;* Fd to be passed
; 	mov rsi, buff ;* Buffer where it should store the bytes read
; 	mov rdx, 20 ;* The count of which the read should read
; 	call ft_read
; 	;* printf rax
; 	mov rsi, buff
; 	mov rdi, format
; 	xor rax, rax
; 	call printf wrt ..plt

; 	mov rax, 60
; 	xor rdi, rdi
; 	syscall


; ft_read:
; 	mov rax, 0
; 	syscall
; 	cmp rax, 0
; 	jl _syscallError
; 	; ;* printf rax
; 	; mov rsi, buff
; 	; mov rdi, format
; 	; xor rax, rax
; 	; call printf wrt ..plt
; 	ret

; _error_handle:
; 	mov rax, 1
; 	mov rdi, 1
; 	mov rsi, error
; 	mov rdx, 28
; 	syscall

; 	cmp rax, 0
; 	jl _syscallError

; 	xor rax, rax
; 	ret

; _syscallError:
; 	mov rbx, rax
; 	call __errno_location wrt ..plt
; 	neg rbx
; 	mov [rax], rbx

; 	mov rax, 60
; 	mov rdi, 1
; 	syscall