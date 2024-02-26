extern array_idx_2      ;; int array_idx_2
 
section .text
    global inorder_intruders
 
;   struct node {
;       int value;
;       struct node *left;
;       struct node *right;
;   } __attribute__((packed));
 
;;  inorder_intruders(struct node *node, struct node *parent, int *array)
;       functia va parcurge in inordine arborele binar de cautare, salvand
;       valorile nodurilor care nu respecta proprietatea de arbore binar
;       de cautare: |node->value > node->left->value, daca node->left exista
;                   |node->value < node->right->value, daca node->right exista
;
;    @params:
;        node   -> nodul actual din arborele de cautare;
;        parent -> tatal/parintele nodului actual din arborele de cautare;
;        array  -> adresa vectorului unde se vor salva valorile din noduri;
 
; ATENTIE: DOAR in frunze pot aparea valori gresite!
;          vectorul array este INDEXAT DE LA 0!
;          Cititi SI fisierul README.md din cadrul directorului pentru exemple,
;          explicatii mai detaliate!
 
; HINT: folositi variabila importata array_idx_2 pentru a retine pozitia
;       urmatorului element ce va fi salvat in vectorul array.
;       Este garantat ca aceasta variabila va fi setata pe 0 la fiecare
;       test al functiei inorder_intruders.  
 
inorder_intruders:
    push ebp
    mov ebp, esp
    pusha
    
    ; verific daca sunt sub arbore
    mov eax, [ebp + 8] ; nodul curent
    cmp eax, 0
    je end
 
apel_stang:
    ; apel pentru subarborele stang
    push dword [ebp + 16] ; array-ul de valori
    push dword [ebp + 8] ; nod curent = parinte
    push dword [eax + 4] ; subarbore stang
    call inorder_intruders
    add esp, 12
 
current_node:
    mov ebx, [ebp + 12]
    cmp ebx, 0 ; verific daca nodul curent are parinte
    je apel_drept

    mov eax, [ebp + 8] ; nodul curent
    mov edi, [eax + 4] ; fiu stang
    mov esi, [eax + 8] ; fiu drept

    ; verific daca e frunza
    cmp edi, 0
    jne apel_drept
    cmp esi, 0
    jne apel_drept

left_son:
    mov ebx, [ebp + 12] ; parinte
    mov edi, [ebx + 4] ; fiul stang al parintelui
    mov esi, [ebp + 8] ; nod curent
    ; verific daca nodul curent e fiul stang al parintelui
    cmp esi, edi
    jne right_son ; daca nu e => verific fiul drept
    
    mov eax, [ebx]
    ; verific cum e informatia din nodul stang fata de radacina
    cmp [esi], eax
    jl apel_drept
 
    ; pun valoarea in array
    mov ecx, [ebp + 16]
    mov edi, dword [array_idx_2]
    inc dword [array_idx_2]
    mov eax, [esi]
    mov [ecx + 4 * edi], eax
    jmp apel_drept

right_son:
    ; verific cum e informatia din nodul drept fata de radacina
    mov eax, [ebx]
    cmp [esi], eax
    jg apel_drept
 
    ; pun valoarea in array
    mov ecx, [ebp + 16]
    mov edi, dword [array_idx_2]
    inc dword [array_idx_2]
    mov eax, [esi]
    mov [ecx + 4 * edi], eax
 
apel_drept:
    ; apel pentru subarborele drept
    mov eax, [ebp + 8]
    push dword [ebp + 16] ; array-ul de valori
    push dword [ebp + 8] ; nod curent = parinte
    push dword [eax + 8] ; subarbore drept
    call inorder_intruders
    add esp, 12
 
end:
    popa
    leave
    ret