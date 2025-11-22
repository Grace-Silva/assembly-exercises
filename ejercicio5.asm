.MODEL SMALL
.STACK 100H

.DATA
    ; Diseño decorativo
    LINEA1  DB 0DH,0AH,'  ******************************************',0DH,0AH,'$'
    LINEA2  DB '  ******************************************',0DH,0AH,'$'
    ESPACIO DB 0DH,0AH,'$'
    
    ; Titulo con decoracion
    TITULO1 DB '  **                                      **',0DH,0AH,'$'
    TITULO2 DB '  **      INFORMACION DEL ESTUDIANTE      **',0DH,0AH,'$'
    TITULO3 DB '  **                                      **',0DH,0AH,'$'
    
    ; Decoracion central
    DECO1   DB '  **  ==================================  **',0DH,0AH,'$'
    
    ; Datos personales (REEMPLAZA AQUI CON TUS DATOS)
    NOMBRE1 DB '  **                                      **',0DH,0AH,'$'
    NOMBRE2 DB '  **      Grace Carolina Silva Duarte     **',0DH,0AH,'$'
    NOMBRE3 DB '  **                                      **',0DH,0AH,'$'
    
    CARRERA1 DB '  **     Ing. de Sistemas Res(011685)    **',0DH,0AH,'$'
    CARRERA2 DB '  **                                     **',0DH,0AH,'$'
    
    ; Decoracion final
    DECO2   DB '  **         ~~~  ~~~  ~~~  ~~~           **',0DH,0AH,'$'
    DECO3   DB '  **      San Jose de Cucuta, Colombia    **',0DH,0AH,'$'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    ; Linea superior
    LEA DX, LINEA1
    MOV AH, 09H
    INT 21H
    
    ; Titulo
    LEA DX, TITULO1
    INT 21H
    LEA DX, TITULO2
    INT 21H
    LEA DX, TITULO3
    INT 21H
    
    ; Decoracion
    LEA DX, DECO1
    INT 21H
    
    ; Nombre
    LEA DX, NOMBRE1
    INT 21H
    LEA DX, NOMBRE2
    INT 21H
    LEA DX, NOMBRE3
    INT 21H
    
    ; Carrera
    LEA DX, CARRERA1
    INT 21H
    LEA DX, CARRERA2
    INT 21H
    
    ; Decoracion final
    LEA DX, DECO1
    INT 21H
    LEA DX, DECO2
    INT 21H
    LEA DX, DECO3
    INT 21H
    LEA DX, TITULO1
    INT 21H
    
    ; Linea inferior
    LEA DX, LINEA2
    INT 21H
    
    ; Espacio final
    LEA DX, ESPACIO
    INT 21H
    
    ; Terminar
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN