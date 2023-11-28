section .data
	str1 db "Hello its me",10,0
	str2 db "what you said 123!$%&",10,0
	str3 db "where what which yes no what",10,0
	str4 db "",0
	str5 db 0
	error db "Hi, There's an error here!",10,0
	; format db "%s",10,0 ;? Format for the printf call

section .bss
	buff resb 50

section .text
	; global main
	global ft_strcpy
	extern __errno_location
	; extern printf

main:
	mov rdi, str1
	mov rsi, buff
	call ft_strcpy
	;* printf rax
	; mov rsi, rax
	; mov rdi, format
	; xor rax, rax
	; call printf wrt ..plt

	mov rdi, str2
	mov rsi, buff
	call ft_strcpy
	;* printf rax
	; mov rsi, rax
	; mov rdi, format
	; xor rax, rax
	; call printf wrt ..plt

	mov rdi, str3
	mov rsi, buff
	call ft_strcpy
	;* printf rax
	; mov rsi, rax
	; mov rdi, format
	; xor rax, rax
	; call printf wrt ..plt

	mov rdi, str4
	mov rsi, buff
	call ft_strcpy
	;* printf rax
	; mov rsi, rax
	; mov rdi, format
	; xor rax, rax
	; call printf wrt ..plt

	mov rdi, str5
	mov rsi, buff
	call ft_strcpy
	;* printf rax
	; mov rsi, rax
	; mov rdi, format
	; xor rax, rax
	; call printf wrt ..plt

	mov rax, 60
	xor rdi, rdi
	syscall

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