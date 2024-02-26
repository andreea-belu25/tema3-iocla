section .data
	; declare global vars here
	vowelString db "aeiou", 0
	mesaj db "%d ", 0
 
section .text
	global reverse_vowels
 
;;	void reverse_vowels(char *string)
;	Cauta toate vocalele din string-ul `string` si afiseaza-le
;	in ordine inversa. Consoanele raman nemodificate.
;	Modificare se va face in-place
 
reverse_vowels:
	push ebp
	xor ebp, ebp
	add ebp, esp
	pusha
 
	xor esi, esi
	add esi, dword [ebp + 8] ; salvez adresa string-ului in registrul esi
 
	xor ebx, ebx ; vocala din dreapta
 
	xor ecx, ecx ; vocala din stanga

 
	; determin lungimea string-ului
count_length:
 
	cmp dword [esi], 0 ; caract cu ascii = 0 => NULL terminator
	je reset_esi
 
	inc esi ; urmatorul element
	inc ebx ; contor pentru lungime
	jmp count_length ; continui loop-ul
 
	xor edi, edi
 
reset_esi :
	push dword [ebp + 8]
	pop esi
 

; la fiecare pas vreau sa am pozita vocalei cea mai din stanga
; si pozitia vocalei cea mai din dreapta
 
det_voc_st:
 
	; verific daca litera din stanga e vocala
 
	cmp byte [esi + ecx], 'a'
	je det_voc_dr
 
	cmp byte [esi + ecx], 'e'
	je det_voc_dr
 
	cmp byte [esi + ecx], 'i'
	je det_voc_dr
 
	cmp byte [esi + ecx], 'o'
	je det_voc_dr
 
	cmp byte [esi + ecx], 'u'
	je det_voc_dr
 
	inc ecx
	cmp ecx, ebx
	jle det_voc_st
	jg end
 
det_voc_dr:
 
	; verific daca litera din dreapta e vocala
 
	cmp byte [esi + ebx], 'a'
	je interschimbare
 
	cmp byte [esi + ebx], 'e'
	je interschimbare
 
	cmp byte [esi + ebx], 'i'
	je interschimbare
 
	cmp byte [esi + ebx], 'o'
	je interschimbare
 
	cmp byte [esi + ebx], 'u'
	je interschimbare
 
	dec ebx
	cmp ebx, ecx
	jge det_voc_dr
	jl end
 
interschimbare:
 
	; acum trebuie interschimbate valorile de la adresele
	; esi + ecx si esi + ebx
	xor eax, eax ; esi + ecx
	xor edx, edx ; esi + ebx
	xor edi, edi ; copia valorii lui eax
 
	push esi
	pop eax
	add eax, ecx
 
	push esi
	pop edx
	add edx, ebx
 
	xor edi, edi
	push dword [eax]
	pop edi ; copie a valorii de la eax
 
	and byte [eax], 0 ; fac 0 la valoarea de la adresa eax
 
	; pun la adresa eax valoarea de la adresa edx
	push edx
 
	push dword [edx]
	xor edx, edx
	pop edx
	add byte [eax], dl
 
	; restaurez adresa edx
	pop edx
 
	and byte [edx], 0 ; fac 0 la valoarea de la adresa edx
 
	; pun la adresa edx valoarea de la adresa eax
	; care are copia in edi
 
	push eax
 
	push edi
	pop eax
 
	add byte [edx], al
 
	; restaurez adresa eax
	pop eax
 
continue_loopswap:
	; continui sa caut vocale
	inc ecx
	dec ebx
 
	cmp ecx, ebx
	jle det_voc_st
 
end:
	popa
	xor esp, esp
	add esp, ebp
	pop ebp
	ret