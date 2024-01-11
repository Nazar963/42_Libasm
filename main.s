section .data
	format_i db "%ld",10,0
	format_s db "%s",10,0
	;? -------------------------------- ft_strlen ------------------------------- */
	loco1 db "Hello, World!",10,0
	loco2 db "What's your name?",10,0
	loco3 db 0
	loco4 db "",0

	; ;? -------------------------------- ft_strcpy ------------------------------- */
	; str1 db "Hello its me",10,0
	; str2 db "what you said 123!$%&",10,0
	; str3 db "where what which yes no what",10,0
	; str4 db "",0
	; str5 db 0

	; ;? -------------------------------- ft_strcmp ------------------------------- */
	; test1 db "Hi its me",0
	; test11 db "Ho its me",0
	; test2 db "lorem ipsum",0
	; test22 db "lorem ipsum",0
	; test3 db "a",0
	; test33 db "a",0
	; test4 db "abc",0
	; test44 db "abd",0
	; test5 db "123456789",0
	; test55 db "1231y23",0

	; ;? -------------------------------- ft_write -------------------------------- */
	; ex1 db "Hello, World", 10, 0
	; ex2 db "a", 10, 0
	; ex3 db "blah blah blah blah", 10, 0

	; ;? -------------------------------- ft_strdup ------------------------------- */
	; case1 db "Hello am the first string.",0
	; case2 db "11 hi am a 22 33 44 a string of 123321 numbers.",0

; section .bss
; 	; buff resb 50
; 	; input resb 20

section .text
	global main
	extern printf
	extern ft_strlen
	; extern ft_strcpy

main:
;* -------------------------------------------------------------------------- */
;*                                  ft_strlen                                 */
;* -------------------------------------------------------------------------- */
	mov rdi, loco1
	call ft_strlen
	;* printf rax
	mov rsi, rax
	mov rdi, format_i
	xor rax, rax
	call printf wrt ..plt

	mov rdi, loco2
	call ft_strlen
	;* printf rax
	mov rsi, rax
	mov rdi, format_i
	xor rax, rax
	call printf wrt ..plt

	mov rdi, loco3
	call ft_strlen
	;* printf rax
	mov rsi, rax
	mov rdi, format_i
	xor rax, rax
	call printf wrt ..plt

	mov rdi, loco4
	call ft_strlen
	;* printf rax
	mov rsi, rax
	mov rdi, format_i
	xor rax, rax
	call printf wrt ..plt
	mov rax, 60
	xor rdi, rdi
	syscall

;* -------------------------------------------------------------------------- */
;*                                  ft_strcpy                                 */
;* -------------------------------------------------------------------------- */
; 	mov rdi, str1
; 	mov rsi, buff
; 	call ft_strcpy
; 	;* printf rax
; 	mov rsi, rax
; 	mov rdi, format
; 	xor rax, rax
; 	call printf wrt ..plt

; 	mov rdi, str2
; 	mov rsi, buff
; 	call ft_strcpy
; 	;* printf rax
; 	mov rsi, rax
; 	mov rdi, format
; 	xor rax, rax
; 	call printf wrt ..plt

; 	mov rdi, str3
; 	mov rsi, buff
; 	call ft_strcpy
; 	;* printf rax
; 	mov rsi, rax
; 	mov rdi, format
; 	xor rax, rax
; 	call printf wrt ..plt

; 	mov rdi, str4
; 	mov rsi, buff
; 	call ft_strcpy
; 	;* printf rax
; 	mov rsi, rax
; 	mov rdi, format
; 	xor rax, rax
; 	call printf wrt ..plt

; 	mov rdi, str5
; 	mov rsi, buff
; 	call ft_strcpy
; 	;* printf rax
; 	mov rsi, rax
; 	mov rdi, format
; 	xor rax, rax
; 	call printf wrt ..plt

; ;* -------------------------------------------------------------------------- */
; ;*                                  ft_strcmp                                 */
; ;* -------------------------------------------------------------------------- */
; 	mov rdi, test1
; 	mov rsi, test11
; 	call ft_strcmp
; 	;* printf rax
; 	mov rsi, rax
; 	mov rdi, format
; 	xor rax, rax
; 	call printf wrt ..plt

; 	mov rdi, test2
; 	mov rsi, test22
; 	call ft_strcmp
; 	;* printf rax
; 	mov rsi, rax
; 	mov rdi, format
; 	xor rax, rax
; 	call printf wrt ..plt

; 	mov rdi, test3
; 	mov rsi, test33
; 	call ft_strcmp
; 	;* printf rax
; 	mov rsi, rax
; 	mov rdi, format
; 	xor rax, rax
; 	call printf wrt ..plt

; 	mov rdi, test4
; 	mov rsi, test44
; 	call ft_strcmp
; 	;* printf rax
; 	mov rsi, rax
; 	mov rdi, format
; 	xor rax, rax
; 	call printf wrt ..plt

; 	mov rdi, test5
; 	mov rsi, test55
; 	call ft_strcmp
; 	;* printf rax
; 	mov rsi, rax
; 	mov rdi, format
; 	xor rax, rax
; 	call printf wrt ..plt

; ;* -------------------------------------------------------------------------- */
; ;*                                  ft_write                                  */
; ;* -------------------------------------------------------------------------- */
; 	mov rdi, ex1
; 	call ft_strlen
; 	mov rdi, 1
; 	mov rsi, ex1
; 	mov rdx, rax
; 	call ft_write

; 	mov rdi, ex2
; 	call ft_strlen
; 	mov rdi, 1
; 	mov rsi, ex2
; 	mov rdx, rax
; 	call ft_write

; 	mov rdi, ex3
; 	call ft_strlen
; 	mov rdi, 1
; 	mov rsi, ex3
; 	mov rdx, rax
; 	call ft_write

; ;* -------------------------------------------------------------------------- */
; ;*                                   ft_read                                  */
; ;* -------------------------------------------------------------------------- */
; 	mov rdi, 0 ;* Fd to be passed
; 	mov rsi, input ;* Buffer where it should store the bytes read
; 	mov rdx, 20 ;* The count of which the read should read
; 	call ft_read
; 	;* printf rax
; 	mov rsi, rax
; 	mov rdi, format
; 	xor rax, rax
; 	call printf wrt ..plt

;TODO-------
; ft_strlen
; ft_strcpy
; ft_strcmp
; ft_write
; ft_read
; ft_strdup 