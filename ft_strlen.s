section .data
	error db "Hi, There's an error here!",10,0

section .text
	global ft_strlen
	extern __errno_location ;? To get the errno pointer and set it

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