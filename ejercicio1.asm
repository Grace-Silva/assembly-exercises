.MODEL SMALL
.STACK 100H

.DATA
    MSG1      DB '===== CALCULADORA SIMPLE =====',0DH,0AH,'$'
    MSG2      DB 0DH,0AH,'Primer numero (0-9): $'
    MSG3      DB 0DH,0AH,'Segundo numero (0-9): $'
    MSG4      DB 0DH,0AH,'Operacion: (+,-,/,*)$'
    MSG5      DB 0DH,0AH,'Resultado: $'
    MSG_ERROR DB 0DH,0AH,'Error: Division por cero$'
    NUM1      DB ?
    NUM2      DB ?
    OP        DB ?

.CODE
MAIN PROC
    ; Inicializar segmento de datos
    MOV AX, @DATA
    MOV DS, AX
    
    ; Mostrar titulo
    LEA DX, MSG1
    MOV AH, 09H
    INT 21H
    
    ; Pedir primer numero
    LEA DX, MSG2
    MOV AH, 09H
    INT 21H
    
    ; Leer primer numero
    MOV AH, 01H
    INT 21H
    SUB AL, 30H          ; Convertir ASCII a numero
    MOV NUM1, AL
    
    ; Pedir segundo numero
    LEA DX, MSG3
    MOV AH, 09H
    INT 21H
    
    ; Leer segundo numero
    MOV AH, 01H
    INT 21H
    SUB AL, 30H
    MOV NUM2, AL
    
    ; Pedir operacion
    LEA DX, MSG4
    MOV AH, 09H
    INT 21H
    
    ; Leer operacion (NO restar nada, es un simbolo)
    MOV AH, 01H
    INT 21H
    MOV OP, AL
    
    ; Cargar numeros para operar
    MOV AL, NUM1
    MOV BL, NUM2
    
    ; Verificar que operacion hacer
    CMP OP, '+'
    JE  SUMA
    CMP OP, '-'
    JE  RESTA
    CMP OP, '*'
    JE  MULTI
    CMP OP, '/'
    JE  DIVI
    JMP FIN
    
    SUMA:     
        ADD AL, BL
        JMP MOSTRAR
    
    RESTA:    
        SUB AL, BL
        JMP MOSTRAR
    
    MULTI:    
        MUL BL               ; AX = AL * BL
        JMP MOSTRAR
    
    DIVI:     
        CMP BL, 0            ; Verificar division por cero
        JE  ERROR_DIV
        MOV AH, 0            ; Limpiar AH
        DIV BL               ; AL = AX / BL
        JMP MOSTRAR
    
    ERROR_DIV:
        LEA DX, MSG_ERROR
        MOV AH, 09H
        INT 21H
        JMP FIN
    
    MOSTRAR:  
    ; Guardar resultado
        ADD AL, 30H          ; Convertir a ASCII
        MOV BL, AL
    
    ; Mostrar mensaje
        LEA DX, MSG5
        MOV AH, 09H
        INT 21H
    
    ; Mostrar resultado
        MOV DL, BL
        MOV AH, 02H
        INT 21H
    
    FIN:      
    ; Salto de linea final
        MOV DL, 0DH
        MOV AH, 02H
        INT 21H
        MOV DL, 0AH
        MOV AH, 02H
        INT 21H
    
    ; Terminar programa
        MOV AH, 4CH
        INT 21H
MAIN ENDP
END MAIN