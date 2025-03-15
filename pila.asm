section .data
    msg db "Resultado: "        ; mensaje a mostrar
    msg_len equ $-msg           ; longitud del mensaje
    buffer db "  ", 10, 0       ; buffer para guardar el resultado de dos dígitos + nueva línea

section .text
    global _start
_start:
    ; Empujar el valor 5 a la pila
    mov eax, 5                  ; cargar 5 en el registro EAX
    push eax                    ; empujar el valor de EAX(5) a la pila
    
    ; sacar el valor de la pila, multiplicarlo por 2
    pop eax                     ; sacar el valor (5) de la pila ponerlo en EAX
    shl eax, 1                  ; Multiplicar el valor en EAX por 2 (equivalente a EAX * 2)
    
    ; convertir el número a ASCII (para soportar valores de 0-99)
    mov ecx, 10                 ; divisor
    mov edx, 0                  ; limpiar edx para la división
    div ecx                     ; divide eax por ecx, cociente en eax, resto en edx
    
    ; primer dígito (decenas)
    add eax, '0'                ; convertir a ASCII
    mov [buffer], al            ; guardar en el buffer
    
    ; segundo dígito (unidades)
    add edx, '0'                ; convertir resto a ASCII
    mov [buffer+1], dl          ; guardar en el buffer
    
    ; mostrar el mensaje "Resultado: "
    mov eax, 4                  ; sys_write
    mov ebx, 1                  ; stdout
    mov ecx, msg                ; puntero al mensaje
    mov edx, msg_len            ; longitud del mensaje
    int 0x80                    ; llamada al sistema
    
    ; mostrar el resultado
    mov eax, 4                  ; sys_write
    mov ebx, 1                  ; stdout
    mov ecx, buffer             ; puntero al buffer
    mov edx, 3                  ; longitud (2 dígitos + nueva línea)
    int 0x80                    ; llamada al sistema
    
    ; salir del programa
    mov eax, 1                  ; sys_exit
    xor ebx, ebx                ; código de salida 0
    int 0x80                    ; llamada al sistema