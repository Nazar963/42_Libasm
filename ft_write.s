section .text
	global ft_write
	extern ft_strlen
	extern __errno_location

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