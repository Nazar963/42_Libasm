section .data
	text1 db "Hello, World", 10, 0
	text2 db "a", 10, 0
	text3 db "blah blah blah blah", 10, 0
	error db "Hi, There's an error here!",10,0

section .text
	global main
	global ft_write
	extern ft_strlen
	extern __errno_location

main:
	mov rdi, text1
	call ft_strlen
	mov rdi, 1
	mov rsi, text1
	mov rdx, rax
	call ft_write

	mov rdi, text2
	call ft_strlen
	mov rdi, 1
	mov rsi, text2
	mov rdx, rax
	call ft_write

	mov rdi, text3
	call ft_strlen
	mov rdi, 1
	mov rsi, text3
	mov rdx, rax
	call ft_write

	mov rax, 60
	xor rdi, rdi
	syscall

ft_write:
	cmp rsi, 0
	je _error_handle
	cmp byte [rsi], 0
	je _error_handle

	call _ft_write_loop
	ret

_ft_write_loop:
	mov rax, 1
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