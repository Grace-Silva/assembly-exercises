.MODEL SMALL
.STACK 100H

.DATA
    MSG1 DB '===== CONVERSOR DECIMAL A BINARIO =====',0DH,0AH,'$'
    MSG2 DB 0DH,0AH,'Ingrese numero (0-9): $'
    MSG3 DB 0DH,0AH,'En binario: $'
    BINARIO DB '00000000$'  ; 8 bits inicializados en 0

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    ; Mostrar titulo
    LEA DX, MSG1
    MOV AH, 09H
    INT 21H
    
    ; Pedir numero
    LEA DX, MSG2
    MOV AH, 09H
    INT 21H
    
    ; Leer numero
    MOV AH, 01H
    INT 21H
    SUB AL, 30H        ; Convertir ASCII a numero
    
    ; Convertir a binario
    MOV BL, AL         ; Guardar numero en BL
    MOV CX, 8          ; 8 bits
    LEA SI, BINARIO    ; Apuntar al string de salida
    ADD SI, 7          ; Empezar desde el final (bit menos significativo)
    
CONVERTIR:
    MOV AL, BL         ; Copiar numero
    AND AL, 01H        ; Obtener bit menos significativo
    ADD AL, 30H        ; Convertir a ASCII ('0' o '1')
    MOV [SI], AL       ; Guardar en el string
    
    SHR BL, 1          ; Desplazar derecha (siguiente bit)
    DEC SI             ; Mover al siguiente caracter (hacia la izquierda)
    
    LOOP CONVERTIR
    
    ; Mostrar resultado
    LEA DX, MSG3
    MOV AH, 09H
    INT 21H
    
    LEA DX, BINARIO
    MOV AH, 09H
    INT 21H
    
    ; Salto de linea final
    MOV DL, 0DH
    MOV AH, 02H
    INT 21H
    MOV DL, 0AH
    MOV AH, 02H
    INT 21H
    
    ; Terminar
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN