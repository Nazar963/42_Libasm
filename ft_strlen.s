section .data
	text1 db "Hello, World!",10,0
	text2 db "What's your name?",10,0
	text3 db 0
	text4 db "",0
	error db "Hi, There's an error here!",10,0
	format db "%ld",10,0 ;? Format for the printf call

section .text
	global main
	global ft_strlen
	extern printf ;? To be able to use printf

main:
	mov rdi, text1
	call ft_strlen
	;* printf rax
	mov rsi, rax
	mov rdi, format
	xor rax, rax
	call printf wrt ..plt

	mov rdi, text2
	call ft_strlen
	;* printf rax
	mov rsi, rax
	mov rdi, format
	xor rax, rax
	call printf wrt ..plt

	mov rdi, text3
	call ft_strlen
	;* printf rax
	mov rsi, rax
	mov rdi, format
	xor rax, rax
	call printf wrt ..plt

	mov rdi, text4
	call ft_strlen
	;* printf rax
	mov rsi, rax
	mov rdi, format
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

	xor rax, rax
	ret
