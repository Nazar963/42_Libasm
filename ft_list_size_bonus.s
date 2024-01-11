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
	cmp rax, 0 ;! ==> it should be test rax, rax and the jz
	jl _malloc_error

	mov rbx, rax
	mov qword [rbx], 5
	mov qword [rbx + 8], 0


	mov rdi, 16
	call malloc wrt ..plt
	cmp rax, 0
	jl _malloc_error

	mov rcx, rax
	mov qword [rcx], 10
	mov qword [rcx + 8], rbx

	xor rax, rax
	mov rdi, rbx
	call ft_list_size
	;* printf rax
	mov rsi, rax
	mov rdi, format
	xor rax, rax
	call printf wrt ..plt


	mov rax, 60
	xor rdi, rdi
	syscall

ft_list_size:
	test rdi, rdi
	jz return
	inc rax
	mov rdi, [rdi + 8]
	jmp ft_list_size


return:
	ret

_malloc_error:
	mov rax, -1
	ret