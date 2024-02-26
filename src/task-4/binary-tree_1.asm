extern array_idx_1      ;; int array_idx_1

section .text
    global inorder_parc

;   struct node {
;       int value;
;       struct node *left;
;       struct node *right;
;   } __attribute__((packed));

;;  inorder_parc(struct node *node, int *array);
;       functia va parcurge in inordine arborele binar de cautare, salvand
;       valorile nodurilor in vectorul array.
;    @params:
;        node  -> nodul actual din arborele de cautare;
;        array -> adresa vectorului unde se vor salva valorile din noduri;

; ATENTIE: vectorul array este INDEXAT DE LA 0!
;          Cititi SI fisierul README.md din cadrul directorului pentru exemple,
;          explicatii mai detaliate!
; HINT: folositi variabila importata array_idx_1 pentru a retine pozitia
;       urmatorului element ce va fi salvat in vectorul array.
;       Este garantat ca aceasta variabila va fi setata pe 0 la fiecare
;       test.

inorder_parc:
    ; parcurgere SRD

    push ebp
    mov ebp, esp
    pusha

    ; verific daca am ajuns sub arbore
    
    mov ebx, [ebp + 8]
    cmp ebx, 0
    je end

    ; apel pentru subarborele stang
    ; [ebp + 12] array-ul in care retin valorile nodurilor
    
    push dword [ebp + 12]
    push dword [ebx + 4]
    call inorder_parc
    add esp, 8

    ; punem la poz array_idx_1 in array informatia nodului curent
    
    mov edx, dword [array_idx_1]
    inc dword [array_idx_1] ; pentru urm nod

    mov esi, [ebx] ; nodul curent

    mov ecx, [ebp + 12] ; array-ul de noduri
    
    mov edi, [ecx + 4 * edx] ; unde pun nodul curent in array

    mov edi, esi
    mov [ecx + 4 * edx], edi ; pun nodul curent in array

    ; apel pentru subarborele drept
    
    push dword [ebp + 12]
    push dword [ebx + 8]
    call inorder_parc
    add esp, 8

end:
    popa
    leave
    ret
