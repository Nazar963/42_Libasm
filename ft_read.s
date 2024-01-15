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
