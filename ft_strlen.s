section .data
	error db "Hi, There's an error here!",10,0
	format_i db "%ld",10,0
	format_s db "%s",10,0
	;? -------------------------------- ft_strlen ------------------------------- */
	loco1 db "Hello, World!",10,0
	loco2 db "What's your name?",10,0
	loco3 db 0
	loco4 db "",0

section .text
	global main
	extern printf
	extern __errno_location ;? To get the errno pointer and set it

main:
	mov rdi, loco1
	call ft_strlen
	;* printf rax
	mov rsi, rax
	mov rdi, format_i
	xor rax, rax
	call printf wrt ..plt

	mov rdi, loco2
	call ft_strlen
	;* printf rax
	mov rsi, rax
	mov rdi, format_i
	xor rax, rax
	call printf wrt ..plt

	mov rdi, loco3
	call ft_strlen
	;* printf rax
	mov rsi, rax
	mov rdi, format_i
	xor rax, rax
	call printf wrt ..plt

	mov rdi, loco4
	call ft_strlen
	;* printf rax
	mov rsi, rax
	mov rdi, format_i
	xor rax, rax
	call printf wrt ..plt
	mov rax, 60
	xor rdi, rdi
	syscall

ft_strlen:
	cmp rdi, 0
	je _error_handle
	cmp byte [rdi], 0
	je _error_handle
	xor rcx, rcx

_ft_strlen_loop:
	cmp byte [rdi + rcx], 0
	je _done
	inc rcx
	jmp _ft_strlen_loop

_done:
	mov rax, rcx
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