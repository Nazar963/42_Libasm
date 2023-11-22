section .data
	text1 db "Hi its me",0
	text11 db "Ho its me",0
	text2 db "lorem ipsum",0
	text22 db "lorem ipsum",0
	text3 db "a",0
	text33 db "a",0
	text4 db "abc",0
	text44 db "abd",0
	text5 db "123456789",0
	text55 db "1231y23",0
	error db "Hi, There's an error here!",10,0
	; format db "%ld",10,0 ;? Format for the printf call

section .text
	global main
	global ft_strcmp
	extern __errno_location ;? To get the errno pointer and set it
	; extern printf ;? To be able to use printf

main:
	mov rdi, text1
	mov rsi, text11
	call ft_strcmp
	;* printf rax
	; mov rsi, rax
	; mov rdi, format
	; xor rax, rax
	; call printf wrt ..plt

	mov rdi, text2
	mov rsi, text22
	call ft_strcmp
	;* printf rax
	; mov rsi, rax
	; mov rdi, format
	; xor rax, rax
	; call printf wrt ..plt

	mov rdi, text3
	mov rsi, text33
	call ft_strcmp
	;* printf rax
	; mov rsi, rax
	; mov rdi, format
	; xor rax, rax
	; call printf wrt ..plt

	mov rdi, text4
	mov rsi, text44
	call ft_strcmp
	;* printf rax
	; mov rsi, rax
	; mov rdi, format
	; xor rax, rax
	; call printf wrt ..plt

	mov rdi, text5
	mov rsi, text55
	call ft_strcmp
	;* printf rax
	; mov rsi, rax
	; mov rdi, format
	; xor rax, rax
	; call printf wrt ..plt

	mov rax, 60
	xor rdi, rdi
	syscall

ft_strcmp:
	cmp rdi, 0
	je _error_handle
	cmp byte [rdi], 0
	je _error_handle

	cmp rsi, 0
	je _error_handle
	cmp byte [rsi], 0
	je _error_handle

	xor rcx, rcx

_ft_strcmp_loop:
	mov al, byte [rdi + rcx]
	mov bl, byte [rsi + rcx]
	cmp al, bl
	jne _ft_strcmp_done
	test al, al
	je _ft_strcmp_done
	test bl, bl
	je _ft_strcmp_done
	inc rcx
	jmp _ft_strcmp_loop

_ft_strcmp_done:
	sub al, bl
	movsx rax, al
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