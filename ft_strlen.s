section .data
	text1 db "Hello, World!",10,0
	text2 db "What's your name?",10,0
	format db "%ld",10,0

section .text
	global main
	extern printf

main:
	lea rdi, [rel text1]
	; mov rdi, text1
	call _ft_strlen
	;* printf rax
	mov rsi, rax
	lea rdi, [rel format]
	; mov rdi, format
	xor rax, rax
	call printf

	; mov rdi, text2
	lea rdi, [rel text2]
	call _ft_strlen
	;* printf rax
	mov rsi, rax
	; mov rdi, format
	lea rdi, [rel format]
	xor rax, rax
	call printf

	mov rax, 60
	xor rdi, rdi
	syscall

_ft_strlen:
	xor rcx, rcx

_ft_strlen_loop:
	cmp byte [rdi + rcx], 0
	je _done
	inc rcx
	jmp _ft_strlen_loop

_done:
	mov rax, rcx
	ret