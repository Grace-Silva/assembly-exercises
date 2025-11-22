.MODEL SMALL
.STACK 100H

.DATA
    MSG1 DB '===== SUMA DE PRIMEROS N NUMEROS =====',0DH,0AH,'$'
    MSG2 DB 0DH,0AH,'Ingrese N (1-9): $'
    MSG3 DB 0DH,0AH,'La suma es: $'
    RESULTADO DB '00$'  ; Para resultados de 2 digitos

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    ; Mostrar titulo
    LEA DX, MSG1
    MOV AH, 09H
    INT 21H
    
    ; Pedir N
    LEA DX, MSG2
    MOV AH, 09H
    INT 21H
    
    ; Leer N
    MOV AH, 01H
    INT 21H
    SUB AL, 30H        ; Convertir a numero
    
    ; Calcular suma
    MOV BL, AL         ; BL = N
    MOV CL, 1          ; CL = contador (empieza en 1)
    MOV AL, 0          ; AL = suma (empieza en 0)
    
SUMAR:
    ADD AL, CL         ; suma = suma + contador
    INC CL             ; contador++
    CMP CL, BL         ; ¿contador > N?
    JBE SUMAR          ; Si contador <= N, continuar
    
    ; Convertir resultado a ASCII (puede ser 2 digitos)
    MOV AH, 0          ; Limpiar AH
    MOV BL, 10
    DIV BL             ; AL = cociente, AH = residuo
    
    ; Primer digito (decenas)
    ADD AL, 30H
    MOV RESULTADO[0], AL
    
    ; Segundo digito (unidades)
    MOV AL, AH
    ADD AL, 30H
    MOV RESULTADO[1], AL
    
    ; Mostrar mensaje
    LEA DX, MSG3
    MOV AH, 09H
    INT 21H
    
    ; Mostrar resultado
    LEA DX, RESULTADO
    MOV AH, 09H
    INT 21H
    
    ; Salto de linea
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