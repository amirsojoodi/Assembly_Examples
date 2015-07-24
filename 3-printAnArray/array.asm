%include 'syscalls32.inc'
    section .bss
    section .data
        array dd 1,2,3,4,5
        arraylen equ ($ - array) / 4            ; array length * 4 = number of elements
		stdout equ 0
    section .text
        global _start:
    _start:
        mov     esi, 0                      ; get pointer to array
        mov     edi, arraylen - 1               ; edi = number of array elements
    .PrintArray:
        mov     edx, 1                          ; print 1 byte                 
        mov     ecx, [array + 4]                    ; get current array element
        add     ecx, 48                         ; add 48 to convet to ASCII
        push    ecx                             ; push to stack since we need an address of item to print
        mov     ecx, esp                        ; mov address of char to ecx
        mov     ebx, stdout
        mov     eax, sys_write
        int     80h                             ; now print it
        pop     ecx                             ; balance stack
        add     esi, 4                          ; get next element, 4 because it's an array of dwords
        dec     edi                             ; decrease loop counter
        jns     .PrintArray                     ; if edi ! -1 continue loop
    .PrintLineFeed:
        sub     esp, 4
        mov     byte [esp], 10
        mov     edx, 1
        mov     ecx, esp
        mov     ebx, stdout
        mov     eax, sys_write
        int     80h
        add     esp, 4                          ; not needed since next call is exit, but learn good techniques.
    exit: 
        mov     ebx, 0
        mov     eax, sys_exit
        int 80H
