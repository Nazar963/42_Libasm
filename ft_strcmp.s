section .data
	error db "Hi, There's an error here!",10,0

section .text
	global ft_strcmp
	extern __errno_location ;? To get the errno pointer and set it

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