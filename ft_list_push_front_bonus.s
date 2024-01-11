section .data
	format db "%d",10,0 ;? Format for the printf call
	format2 db "%p",10,0 ;? Format for the printf call

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
	mov rdi, 16
	call malloc wrt ..plt
	cmp rax, 0
	jl _malloc_error

	push rax
	lea rdi, [rsp]

	mov rax, [rsp]
	mov qword [rax], 5
	mov qword [rax + 8], 0
	mov rsi, 10
	call ft_list_push_front
	add rsp, 8
	mov rbx, rax
	mov rcx, [rax + 8]
	;* printf rax
	; push rbx
	; mov rsi, rbx
	; mov rdi, format2
	; xor rax, rax
	; call printf wrt ..plt

	; pop rbx
	; mov rsi, [rbx]
	; mov rdi, format
	; xor rax, rax
	; call printf wrt ..plt

	; mov rsi, [rbx + 8]
	; mov rdi, format2
	; xor rax, rax
	; call printf wrt ..plt

	; push rcx
	; mov rsi, rcx
	; mov rdi, format2
	; xor rax, rax
	; call printf wrt ..plt

	; pop rcx

	; mov rsi, [rcx]
	; mov rdi, format
	; xor rax, rax
	; call printf wrt ..plt

	mov rsi, [rcx + 8]
	mov rdi, format2
	xor rax, rax
	call printf wrt ..plt

	mov rax, 60
	xor rdi, rdi
	syscall

ft_list_push_front:
	mov rdi, [rdi]
	mov rbx, rdi
	mov r12, rsi

	mov rdi, 16
	call malloc wrt ..plt
	cmp rax, 0
	jl _malloc_error

	mov rcx, rax
	mov rdi, rbx

	mov qword [rcx], r12
	mov qword [rcx + 8], rdi
	mov rax, rcx
	ret

_malloc_error:
	mov rax, -1
	ret