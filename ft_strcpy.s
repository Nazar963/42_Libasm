section .data
	error db "Hi, There's an error here!",10,0

section .text
	global ft_strcpy
	extern __errno_location

ft_strcpy:
	cmp rdi, 0
	je _error_handle
	cmp byte [rdi], 0
	je _error_handle
	xor rbx, rbx

_ft_strcpy_loop:
	movzx rax, byte [rdi + rbx]
	mov [rsi + rbx], al
	test al, al
	jz end
	inc rbx
	jmp _ft_strcpy_loop

end:
	xor rax, rax
	mov [rsi + rbx], al

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

	xor rax, rax
	ret

_syscallError:
	mov rbx, rax
	call __errno_location wrt ..plt
	neg rbx
	mov [rax], rbx
	ret