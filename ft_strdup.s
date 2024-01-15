section .data
	error db "Hi, There's an error here!",10,0

section .text
	global ft_strdup
	extern ft_strlen
	extern ft_strcpy
	extern malloc
	extern __errno_location

ft_strdup:
	call ft_strlen
	mov rcx, rax
	inc rcx
	inc rcx
	inc rcx
	inc rcx
	inc rcx
	inc rcx
	inc rcx
	inc rcx
	mov rbx, rdi
	xor rax, rax
	xor rdi, rdi
	mov rdi, rcx
	call malloc wrt ..plt
	cmp rax, 0
	jl _malloc_error
	mov rdi, rbx
	mov rsi, rax
	call ft_strcpy
	ret

_malloc_error:
	mov rax, -1
	ret
