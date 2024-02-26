global get_words
global compare_func
global sort
global cmp

section .data
    separatori db " .,", 0 ; sir de separatori pentru strtok

section .text
    extern strtok
    extern strlen
    extern stdin
    extern strcmp
    extern qsort

;; sort(char **words, int number_of_words, int size)
;  functia va trebui sa apeleze qsort pentru soratrea cuvintelor 
;  dupa lungime si apoi lexicografix
; qsort (const void *a, const void *b, int(*cmp)(const void *a, const void *b))
; cmp fct de comparatie

cmp:
    ; functia de comparare pentru qsort
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi

    xor ecx, ecx
    mov ecx, [ebp + 8] ; pointer primul elem

    xor edx, edx
    mov edx, [ebp + 12] ; pointer al doilea elem

find_length_a:
    ; determin lungimea primei valori cu strlen
    push eax
    push ebx
    push ecx
    push edx
    push edi
    push esi
    

    xor eax, eax
    push dword [ecx]
    call strlen
    add esp, 4
    
    pop esi
    xor esi, esi
    mov esi, eax ; in esi retin lung lui a

    pop edi
    pop edx
    pop ecx
    pop ebx
    pop eax
    
find_length_b:
    ; determin lung celei de-a doua valori cu strlen
    push eax
    push ebx
    push ecx
    push edx
    push esi
    push edi

    xor eax, eax
    push dword [edx]
    call strlen
    add esp, 4

    pop edi
    xor edi, edi
    mov edi, eax ; in edi retin lung lui b

    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax

make_the_difference:
    ; fac difrenta dintre cele doua lungimi
    xor eax, eax
    mov eax, esi
    sub eax, edi

    cmp eax, 0
    ; daca au aceeasi lungime => le sortez lexicografic
    je sort_lexico
    jmp end_cmp    

sort_lexico:
    ; sortare lexicografica a cuvintelor cu strcmp
    xor eax, eax
    push dword [edx]
    push dword [ecx]
    call strcmp
    add esp, 8
   
end_cmp:
    pop edi
    pop esi
    pop ebx
    leave
    ret

sort:
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8] ; words
    mov ebx, [ebp + 12] ; number_of_words
    mov edx, [ebp + 16] ; size
    ; push pe stiva la parametrii de care am nevoie pentru qsort
    push cmp
    push edx
    push ebx
    push eax
    call qsort
    add esp, 16; patru parametrii

end_sort:
    popa
    leave
    ret

;; get_words(char *s, char **words, int number_of_words)
;  separa stringul s in cuvinte si salveaza cuvintele in words
;  number_of_words reprezinta numarul de cuvinte

get_words:
    push ebp
    mov ebp, esp
    pusha

    mov ecx, [ebp + 8] ; s
    mov ebx, [ebp + 12] ; words
    mov edx, [ebp + 16] ; number_of_words

    push ebx
    push ecx
    push edx
    push esi
    push edi

    ; determin primul cuvant gasit, folosindu-ma de separatori
    ; si strtok
    push separatori
    push ecx
    call strtok
    add esp, 8
    
    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx

    xor esi, esi
    jmp put_the_value

go_to_loop:
    ; determin urmatorul cuvant de la NULL si il salvez
    push ebx
    push ecx
    push edx
    push esi
    push edi

    push separatori
    push dword 0
    call strtok
    add esp, 8

    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx

    jmp put_the_value

next_step:
    ; ma mut la urmatorul cuvant din string
    inc esi

    cmp esi, edx
    je end_get_words
    jmp go_to_loop

put_the_value:
    ; salvez fiecare cuvant gasit
    mov [ebx + 4 * esi], eax
    jmp next_step

end_get_words:
    popa
    leave
    ret
