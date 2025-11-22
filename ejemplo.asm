section .data
    newline db 0xA        ; Carácter de nueva línea

section .bss
    digit resb 1          ; Reservar espacio para un dígito

section .text
    global _start

_start:
    mov rcx, 1            ; Contador inicial (primer número)
    
loop_start:
    cmp rcx, 6            ; Comparar si ya llegamos a 6
    je exit               ; Si es igual, salir
    
    ; Convertir número a ASCII
    mov rax, rcx
    add rax, 48           ; Convertir a ASCII (0-9 = 48-57)
    mov [digit], al       ; Guardar el dígito
    
    ; Imprimir el dígito
    mov rax, 1            ; syscall: write
    mov rdi, 1            ; file descriptor: stdout
    mov rsi, digit        ; buffer con el dígito
    mov rdx, 1            ; longitud: 1 byte
    syscall
    
    ; Imprimir nueva línea
    mov rax, 1            ; syscall: write
    mov rdi, 1            ; file descriptor: stdout
    mov rsi, newline      ; buffer con nueva línea
    mov rdx, 1            ; longitud: 1 byte
    syscall
    
    inc rcx               ; Incrementar contador
    jmp loop_start        ; Repetir el ciclo
    
exit:
    mov rax, 60           ; syscall: exit
    xor rdi, rdi          ; código de salida: 0
    syscall