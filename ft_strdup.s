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
	mov rcx, rax ;? Store the length of the string to be copied in rcx
	inc rcx ;? So it holds the length of the string plus 1 for the null char
	inc rcx ;? So it holds the length of the string plus 1 for the null char
	inc rcx ;? So it holds the length of the string plus 1 for the null char
	inc rcx ;? So it holds the length of the string plus 1 for the null char
	inc rcx ;? So it holds the length of the string plus 1 for the null char
	inc rcx ;? So it holds the length of the string plus 1 for the null char
	inc rcx ;? So it holds the length of the string plus 1 for the null char
	inc rcx ;? So it holds the length of the string plus 1 for the null char
	mov rbx, rdi ;? Save the string to be copied in rbx
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
