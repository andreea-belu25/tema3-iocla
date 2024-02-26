section .text
    global inorder_fixing

;   struct node {
;       int value;
;       struct node *left;
;       struct node *right;
;   } __attribute__((packed));

;;  inorder_fixing(struct node *node, struct node *parent)
;       functia va parcurge in inordine arborele binar de cautare, modificand
;       valorile nodurilor care nu respecta proprietatea de arbore binar
;       de cautare: |node->value > node->left->value, daca node->left exista
;                   |node->value < node->right->value, daca node->right exista.
;
;       Unde este nevoie de modificari se va aplica algoritmul:
;           - daca nodul actual este fiul stang, va primi valoare tatalui - 1,
;                altfel spus: node->value = parent->value - 1;
;           - daca nodul actual este fiul drept, va primi valoare tatalui + 1,
;                altfel spus: node->value = parent->value + 1;

;    @params:
;        node   -> nodul actual din arborele de cautare;
;        parent -> tatal/parintele nodului actual din arborele de cautare;

; ATENTIE: DOAR in frunze pot aparea valori gresite! 
;          Cititi SI fisierul README.md din cadrul directorului pentru exemple,
;          explicatii mai detaliate!

node_processing:
    ; [ebp + 8] = nod curent
    ; [ebp + 12] = parinte nod curent
    enter 0, 0 ; <=> push ebp; mov ebp, esp
    pusha

    ; verific daca nodul curent are parinte
    mov eax, [ebp + 12] ; parinte
    cmp eax, 0
    je end_node_processing

    mov ebx, [ebp + 8]
    ; verific daca nodul curent e fiul stang al parintelui
    mov ebx, [ebp + 8] ; nod curent
    mov ecx, [eax + 4] ; fiu stang parinte
    cmp ecx, 0 ; nu are fiu stang
    je check_info_right_son

    mov esi, [ebx]
    mov edi, [ecx]
    cmp esi, edi
    jne check_info_right_son
    
    mov eax, [ebp + 12] ; parinte
    mov esi, [eax] ; valoarea parintelui
    mov edi, [ebx] ; valoarea nodului curent
    ; verific cum e informatia din nodul stang fata de radacina
    cmp edi, esi
    jge modify_left_value
    jmp end_node_processing

modify_left_value:
    mov eax, [ebp + 12] ; parinte
    mov ebx, [ebp + 8]
    mov edi, [eax] ; valoarea parintelui
    dec edi ; valoarea parintelui - 1
    mov [ebx], edi ; mut noua valorea in nodul curent
    jmp end_node_processing

check_info_right_son:
    ; verific informatia din nodul drept
    mov eax, [ebp + 12] ; parinte
    mov esi, [eax] ; valoare parinte
    mov edi, [ebx] ; valoare nod curent
    cmp edi, esi
    jle modify_right_value
    jmp end_node_processing

modify_right_value:
    mov eax, [ebp + 12] ; parinte
    mov ebx, [ebp + 8]
    mov edi, [eax] ; valoare parinte
    inc edi
    mov [ebx], edi ; mut noua valoare in nodul curent

end_node_processing:
    popa
    leave
    ret

inorder_fixing:
    push ebp
    mov ebp, esp
    pusha

    ; [ebp + 8] = node
    ; [ebp + 12] = parent

    ; am ajuns sub arbore
    mov ebx, [ebp + 8]
    cmp ebx, 0
    je end

apel_stang:
    ; apel subarbore stang
    mov ebx, [ebp + 8]
    push dword [ebp + 8]
    push dword [ebx + 4]
    call inorder_fixing
    add esp, 8

current_node:
    mov ebx, [ebp + 8]
    mov edi, [ebx + 4] ; fiu stang
    mov esi, [ebx + 8] ; fiu drept

    ; verific daca nodul curent e frunza
    cmp edi, 0
    jne apel_drept

    cmp esi, 0
    jne apel_drept

    ; apelez fct de mai sus pentru nodul curent
    push dword [ebp + 12] ; parinte nod curent
    push dword [ebp + 8] ; nod curent
    call node_processing
    add esp, 8

apel_drept:
    ; apel subarbore drept
    mov ebx, [ebp + 8]
    push dword [ebp + 8]
    push dword [ebx + 8]
    call inorder_fixing
    add esp, 8

end:
    popa
    leave
    ret
