.MODEL SMALL
.STACK 100H

.DATA
    MSG1 DB '===== CONTADOR DEL 1 AL 10 =====',0DH,0AH,0DH,0AH,'$'

.CODE
MAIN PROC
    ; Inicializar
    MOV AX, @DATA
    MOV DS, AX
    
    ; Mostrar titulo
    LEA DX, MSG1
    MOV AH, 09H
    INT 21H
    
    ; Inicializar contador
    MOV CX, 10         ; 10 iteraciones
    MOV BL, 1          ; Empezar en 1
    
BUCLE:
    ; Verificar si es menor a 10 (un solo digito)
    CMP BL, 10
    JL UN_DIGITO       ; Si es menor a 10, mostrar un digito
    
    ; Si es 10, mostrar dos digitos
    MOV DL, '1'        ; Primer digito (decena)
    MOV AH, 02H
    INT 21H
    
    MOV DL, '0'        ; Segundo digito (unidad)
    MOV AH, 02H
    INT 21H
    JMP SALTO_LINEA
    
UN_DIGITO:
    ; Mostrar numero de un digito
    MOV DL, BL
    ADD DL, 30H        ; Convertir a ASCII
    MOV AH, 02H
    INT 21H
    
SALTO_LINEA:
    ; Salto de linea
    MOV DL, 0DH        ; Retorno de carro
    MOV AH, 02H
    INT 21H
    MOV DL, 0AH        ; Nueva linea
    MOV AH, 02H
    INT 21H
    
    ; Incrementar numero
    INC BL
    
    ; Repetir mientras CX > 0
    LOOP BUCLE
    
    ; Terminar programa
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN