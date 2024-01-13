section .data
	format_i db "%ld",10,0
	format_s db "%s",10,0
	;? -------------------------------- ft_strlen ------------------------------- */
	loco1 db "Hello, World!",10,0
	loco2 db "What's your name?",10,0
	loco3 db 0
	loco4 db "",0
	;? -------------------------------- ft_strcpy ------------------------------- */
	str1 db "Hello its me",0
	str2 db "what you said 123!$%&",0
	str3 db "where what which yes no what",0
	str4 db "",0
	str5 db 0
	;? -------------------------------- ft_strcmp ------------------------------- */
	test1 db "Hi its me",0
	test11 db "Ho its me",0
	test2 db "lorem ipsum",0
	test22 db "lorem ipsum",0
	test3 db "a",0
	test33 db "a",0
	test4 db "abc",0
	test44 db "abd",0
	test5 db "123456789",0
	test55 db "1231y23",0
	;? -------------------------------- ft_write -------------------------------- */
	ex1 db "Hello, World", 10, 0
	ex2 db "a", 10, 0
	ex3 db "blah blah blah blah", 10, 0
	;? -------------------------------- ft_strdup ------------------------------- */
	case1 db "Hello am the first string.",0
	case2 db "11 hi am a 22 33 44 a string of 123321 numbers.",0
	;? --------------------------------- Divider -------------------------------- */
	divi_strlen db 10,"ft_strlen>>>>>>>>>>>>>>",10,0
	divi_strcpy db 10,"ft_strcpy>>>>>>>>>>>>>>",10,0
	divi_strcmp db 10,"ft_strcmp>>>>>>>>>>>>>>",10,0
	divi_write db 10,"ft_write>>>>>>>>>>>>>>",10,0
	divi_read db 10,"ft_read>>>>>>>>>>>>>>",10,0
	divi_strdup db 10,"ft_strdup>>>>>>>>>>>>>>",10,0

section .bss
	buff resb 50
	read_buff resb 50

section .text
	global main
	extern free
	extern printf
	extern ft_strlen
	extern ft_strcpy
	extern ft_strcmp
	extern ft_write
	extern ft_strdup
	extern ft_read

main:
;! --------------------------------- Divider -------------------------------- */
	mov rsi, divi_strlen
	mov rdi, format_s
	xor rax, rax
	call printf wrt ..plt

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

;! --------------------------------- Divider -------------------------------- */
	mov rsi, divi_strcpy
	mov rdi, format_s
	xor rax, rax
	call printf wrt ..plt

;* -------------------------------------------------------------------------- */
;*                                  ft_strcpy                                 */
;* -------------------------------------------------------------------------- */
	mov rdi, str1
	mov rsi, buff
	call ft_strcpy
	;* printf rax
	mov rsi, rax
	mov rdi, format_s
	xor rax, rax
	call printf wrt ..plt

	mov rdi, str2
	mov rsi, buff
	call ft_strcpy
	;* printf rax
	mov rsi, rax
	mov rdi, format_s
	xor rax, rax
	call printf wrt ..plt

	mov rdi, str3
	mov rsi, buff
	call ft_strcpy
	;* printf rax
	mov rsi, rax
	mov rdi, format_s
	xor rax, rax
	call printf wrt ..plt

	mov rdi, str4
	mov rsi, buff
	call ft_strcpy
	;* printf rax
	mov rsi, rax
	mov rdi, format_s
	xor rax, rax
	call printf wrt ..plt

	mov rdi, str5
	mov rsi, buff
	call ft_strcpy
	;* printf rax
	mov rsi, rax
	mov rdi, format_s
	xor rax, rax
	call printf wrt ..plt

	;! --------------------------------- Divider -------------------------------- */
	mov rsi, divi_strcmp
	mov rdi, format_s
	xor rax, rax
	call printf wrt ..plt

;* -------------------------------------------------------------------------- */
;*                                  ft_strcmp                                 */
;* -------------------------------------------------------------------------- */
	mov rdi, test1
	mov rsi, test11
	call ft_strcmp
	;* printf rax
	mov rsi, rax
	mov rdi, format_i
	xor rax, rax
	call printf wrt ..plt

	mov rdi, test2
	mov rsi, test22
	call ft_strcmp
	;* printf rax
	mov rsi, rax
	mov rdi, format_i
	xor rax, rax
	call printf wrt ..plt

	mov rdi, test3
	mov rsi, test33
	call ft_strcmp
	;* printf rax
	mov rsi, rax
	mov rdi, format_i
	xor rax, rax
	call printf wrt ..plt

	mov rdi, test4
	mov rsi, test44
	call ft_strcmp
	;* printf rax
	mov rsi, rax
	mov rdi, format_i
	xor rax, rax
	call printf wrt ..plt

	mov rdi, test5
	mov rsi, test55
	call ft_strcmp
	;* printf rax
	mov rsi, rax
	mov rdi, format_i
	xor rax, rax
	call printf wrt ..plt

;! --------------------------------- Divider -------------------------------- */
	mov rsi, divi_write
	mov rdi, format_s
	xor rax, rax
	call printf wrt ..plt

;* -------------------------------------------------------------------------- */
;*                                  ft_write                                  */
;* -------------------------------------------------------------------------- */
	mov rdi, ex1
	call ft_strlen
	mov rdi, 1
	mov rsi, ex1
	mov rdx, rax
	call ft_write

	mov rdi, ex2
	call ft_strlen
	mov rdi, 1
	mov rsi, ex2
	mov rdx, rax
	call ft_write

	mov rdi, ex3
	call ft_strlen
	mov rdi, 1
	mov rsi, ex3
	mov rdx, rax
	call ft_write

;! --------------------------------- Divider -------------------------------- */
	mov rsi, divi_strdup
	mov rdi, format_s
	xor rax, rax
	call printf wrt ..plt

;* -------------------------------------------------------------------------- */
;*                                  ft_strdup                                 */
;* -------------------------------------------------------------------------- */
	mov rdi, case1
	call ft_strdup
	;* printf rax
	mov rsi, rax
	mov rdi, format_s
	push rax
	call free wrt ..plt
	xor rax, rax
	call printf wrt ..plt

	mov rdi, case2
	call ft_strdup
	;* printf rax
	mov rsi, rax
	mov rdi, format_s
	push rax
	call free wrt ..plt
	xor rax, rax
	call printf wrt ..plt

;! --------------------------------- Divider -------------------------------- */
	mov rsi, divi_read
	mov rdi, format_s
	xor rax, rax
	call printf wrt ..plt

;* -------------------------------------------------------------------------- */
;*                                   ft_read                                  */
;* -------------------------------------------------------------------------- */
	mov rdi, 0 ;* Fd to be passed
	mov rsi, read_buff ;* Buffer where it should store the bytes read
	mov rdx, 20 ;* The count of which the read should read
	call ft_read
	;* printf rax
	mov rsi, read_buff
	mov rdi, format_s
	xor rax, rax
	call printf wrt ..plt

	mov rax, 60
	xor rdi, rdi
	syscall