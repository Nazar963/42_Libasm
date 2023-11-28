section .data
	str1 db "Hello am the first string.",0
	str2 db "11 hi am a 22 33 44 a string of 123321 numbers.",0
	error db "Hi, There's an error here!",10,0
	format db "%s",10,0 ;? Format for the printf call

section .text
	global main
	global ft_strdup
	extern ft_strlen
	extern ft_strcpy
	extern printf
	extern malloc
	extern __errno_location

main:
	mov rdi, str1
	call ft_strdup
	;* printf rax
	mov rsi, rax
	mov rdi, format
	xor rax, rax
	call printf wrt ..plt

	mov rdi, str2
	call ft_strdup
	;* printf rax
	mov rsi, rax
	mov rdi, format
	xor rax, rax
	call printf wrt ..plt

	mov rax, 60
	xor rdi, rdi
	syscall

ft_strdup:
	call ft_strlen
	mov rcx, rax ;? Store the length of the string to be copied in rcx
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

_syscallError:
	mov rbx, rax
	call __errno_location wrt ..plt
	neg rbx
	mov [rax], rbx
	ret