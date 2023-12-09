section .data
	format db "%lld",10,0 ;? Format for the printf call
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
	mov rcx, rax

	mov qword [rcx], 5
	mov qword [rcx + 8], 0

	; mov rsi, rcx
	; mov rdi, format2
	; xor rax, rax
	; call printf wrt ..plt

	; mov rsi, [rcx]
	; mov rdi, format
	; xor rax, rax
	; call printf wrt ..plt

	; mov rsi, [rax + 8]
	; mov rdi, format2
	; xor rax, rax
	; call printf wrt ..plt
; 	mov rsi, 10
; 	call ft_list_push_front
; 	mov rbx, rax
; 	mov rcx, [rax + 8]
; 	;* printf rax


; 	mov rsi, rcx
; 	mov rdi, format2
; 	xor rax, rax
; 	call printf wrt ..plt

; 	mov rsi, [rcx]
; 	mov rdi, format
; 	xor rax, rax
; 	call printf wrt ..plt

; 	mov rsi, [rcx + 8]
; 	mov rdi, format2
; 	xor rax, rax
; 	call printf wrt ..plt

; 	mov rax, 60
; 	xor rdi, rdi
; 	syscall

; ft_list_push_front:
; 	mov rbx, rdi

; 	mov rdi, 16
; 	call malloc wrt ..plt
; 	cmp rax, 0
; 	jl _malloc_error

; 	mov rcx, rax
; 	mov rdi, rbx

; 	mov [rcx], rsi
; 	mov qword [rcx + 8], rdi
; 	mov rax, rcx
; 	ret

_malloc_error:
	mov rax, -1
	ret