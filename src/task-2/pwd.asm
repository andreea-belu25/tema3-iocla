section .data
	; declare global vars here
	back db "..", 0
	curr db ".", 0
	slash db "/", 0

section .text
	global pwd
	extern strcmp
	extern strcat
	extern strrchr

;;	void pwd(char **directories, int n, char *output)
;	Adauga in parametrul output path-ul rezultat din
;	parcurgerea celor n foldere din directories

pwd:
	push ebp
	mov ebp, esp
	pusha

	mov eax, [ebp + 8] ; directories
	mov ebx, [ebp + 12] ; n
	mov edx, [ebp + 16] ; output

	xor ecx, ecx
	jmp first_special_case

first_special_case:
	; verific daca string-ul curent e ".."
	pusha
	
	push dword [eax + 4 * ecx]
	push dword back
	call strcmp 
	add esp, 8

	cmp al, 0
	je previous_directory
	jmp second_special_case 

previous_directory:
	popa

	push eax
	push ebx
	push ecx
	push edx
	push esi
	push edi

	; caut "/" in edx 
	push dword '/'
	push dword edx
	call strrchr
	add esp, 8
	
	cmp eax, 0
	; nu exista "/" in edx => nu ma pot muta la folderul anterior
	jne remove_directory
	
	jmp next_step_special_case_remove

remove_directory:
	; sterg directorul anterior punand 0 la pozitia gasita
	pop edi
	pop esi
	pop edx
	pop ecx
	pop ebx 

	xor edi, edi
	mov edi, eax

	xor esi, esi
	mov esi, edx
	mov [edi], byte 0

	pop eax

	jmp next_step

second_special_case:
	; verific daca directorul curent e "."
	popa

	pusha
	push dword[eax + 4 * ecx]
	push dword curr
	call strcmp
	add esp, 8

	cmp al, 0
	je next_step_special_case

	jmp third_case

third_case:
	; daca am trecut de primele doua cazuri, concatenez
	; / si directorul curent la output
	popa
	
	pusha

	push dword slash
	push dword edx
	call strcat 
	add esp, 8

	popa

	pusha

	push dword [eax + 4 * ecx]
	push dword edx
	call strcat 
	add esp, 8

	popa

	jmp next_step

; am creat label-uri diferite pentru a inainta
; la urmatorul director pentru ca am caz in care
; nu dau push la nimic, caz in care salvez pe stiva 
; doar anumite registre si caz in care folosesc pusha
next_step_special_case:
	popa

	inc ecx
	cmp ecx, ebx
	je end

	jmp first_special_case

next_step_special_case_remove:
	pop edi
	pop esi
	pop edx
	pop ecx
	pop ebx 
	pop eax

	inc ecx
	cmp ecx, ebx
	je end

	jmp first_special_case

next_step:
	inc ecx
	cmp ecx, ebx
	je end

	jmp first_special_case

end:
	; adaug / la sfarsitul output-ului
	pusha
	push dword slash
	push dword edx
	call strcat
	add esp, 8
	popa

	popa
	leave
	ret