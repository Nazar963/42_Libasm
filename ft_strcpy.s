section .data
	error db "Hi, There's an error here!",10,0

section .text
	global ft_strcpy
	extern __errno_location ;? To get the errno pointer and set it

ft_strcpy:
	cmp rdi, 0
	je _error_handle
	cmp byte [rdi], 0
	je _error_handle
	xor rbx, rbx

_ft_strcpy_loop:
	mov rax, [rdi + rbx]
	mov [rsi + rbx], rax
	inc rbx
	cmp byte [rdi + rbx], 0
	jne _ft_strcpy_loop
	inc rbx
	xor rax, rax
	mov [rsi + rbx], rax

	mov rax, rsi
	ret

_error_handle:
	mov rax, 1
	mov rdi, 1
	mov rsi, error
	mov rdx, 28
	syscall

	cmp rax, 0
	jl _syscallError

	mov rax, 60
	xor rdi, rdi
	syscall
	ret

_syscallError:
	mov rbx, rax
	call __errno_location wrt ..plt
	neg rbx
	mov [rax], rbx
	ret