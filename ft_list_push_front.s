section .data
	format db "%d",10,0 ;? Format for the printf call

section .text
	global main
	global ft_atoi_base
	extern ft_strlen
	extern __errno_location
	extern printf
	extern malloc

;? 4 is the data size 4 bytes for int
;? 8 is the next pointer 8 bytes are 64 bit a whole register

main:
	mov rdi, 13
	call malloc wrt ..plt
	cmp rax, 0
	jl _malloc_error
	mov rdi, rax
	mov qword [rdi], 5
	mov qword [rdi + 4], 0
	mov rsi, 10
	call ft_list_push_front
	mov rbx, rax
	;* printf rax
	mov rsi, rbx
	mov rdi, format
	xor rax, rax
	call printf wrt ..plt

	mov rsi, [rbx]
	mov rdi, format
	xor rax, rax
	call printf wrt ..plt

	mov rsi, [rbx + 4]
	mov rdi, format
	xor rax, rax
	call printf wrt ..plt

	mov rsi, [rbx + 8]
	mov rdi, format
	xor rax, rax
	call printf wrt ..plt
	mov rsi, [rbx + 4 + 8]
	mov rdi, format
	xor rax, rax
	call printf wrt ..plt

	mov rax, 60
	xor rdi, rdi
	syscall

ft_list_push_front:
	mov rbx, rdi
	mov rdi, 13
	call malloc wrt ..plt
	cmp rax, 0
	jl _malloc_error
	mov rcx, rax
	mov rdi, rbx

	mov qword [rcx], rsi
	mov qword [rcx + 4], rdi
	mov rax, rcx
	ret

_malloc_error:
	mov rax, -1
	ret