.model small
.stack 100h

.data
    message db 13, 10, "Input 3-digit number(001-399): ", "$"
    error db 13, 10, "Input should be 001-399 only", "$"

    hundreds_digit db 0
    tens_digit db 0
    ones_digit db 0

    counter_hundreds db 0
    counter_tens db 0
    counter_ones db 0

.code
    main proc near
    ; Initializing data
    mov ax, @data
    mov ds, ax
    
    ; Displaying message
    lea dx, message
    mov ah, 09h
    int 21h
;---------------------------------------------------------
    ; Gets user input
    mov ah, 01h
    int 21h
    
    ; Subtract 48 to convert it from ASCII to a numeric value
    sub al, 048

    ; Check if the input is valid (between 0 and 3)
    cmp al, 0
    jl @input_error
    cmp al, 3
    jg @input_error

    mov hundreds_digit, al
    
    ; Gets user input
    mov ah, 01h
    int 21h
    
    ; Subtract 48 to convert it from ASCII to a numeric value
    sub al, 048
    mov tens_digit, al
    
    ; Gets user input
    mov ah, 01h
    int 21h
    
    ; Subtract 48 to convert it from ASCII to a numeric value
    sub al, 048
    mov ones_digit, al
    
    ; New line
    mov ah, 02h
    mov dl, 13
    int 21h
    mov ah, 02h
    mov dl, 10
    int 21h
;---------------------------------------------------------
    
    ; Printing the hundreds in Roman 'C'
    print_hundreds:
    mov bl, counter_hundreds
    cmp bl, hundreds_digit
    je print_tens
    
    mov ah, 2
    mov dl, 'C'
    int 21h
    
    inc counter_hundreds
    
    jmp print_hundreds
;---------------------------------------------------------
    
    ; Printing the tens in Roman 'X'    
    print_tens:
    ; Check if it is in the range of 90
    cmp tens_digit, 9
    je print_90
    ; Check if it is in the range of 50
    cmp tens_digit, 5
    je print_50
    jg print_50
    ; Check if it is in the range of 40
    cmp tens_digit, 4
    je print_40
    
    mov bl, counter_tens
    cmp bl, tens_digit
    je print_ones
    
    mov ah, 2
    mov dl, 'X'
    int 21h
    
    inc counter_tens
    
    jmp print_tens
;---------------------------------------------------------
        
    ; Printing the ones in Roman 'I'
    print_ones:
    ; Check if it is 9, then jump
    cmp ones_digit, 9
    je print_9
    ; Check if it is 5, then jump
    cmp ones_digit, 5
    je print_5
    jg print_5
    ; Check if it is 4, then jump
    cmp ones_digit, 4
    je print_4
    
    mov bl, counter_ones
    cmp bl, ones_digit
    je exit
    
    mov ah, 2
    mov dl, 'I'
    int 21h
    
    inc counter_ones
    
    jmp print_ones
;---------------------------------------------------------
    
    ; Printing of 90 in Roman 'XC'
    print_90:
    mov ah, 2
    mov dl, 'X'
    int 21h
    
    mov ah, 2
    mov dl, 'C'
    int 21h
    
    sub tens_digit, 9
    jmp print_tens
;---------------------------------------------------------

    ; Printing of 50 in Roman 'L'     
    print_50:
    mov ah, 2
    mov dl, 'L'
    int 21h
    
    sub tens_digit, 5
    jmp print_tens
;---------------------------------------------------------
    
    ; Printing of 40 in Roman 'XL' 
    print_40:
    mov ah, 2
    mov dl, 'X'
    int 21h
    
    mov ah, 2
    mov dl, 'L'
    int 21h
    
    sub tens_digit, 4
    jmp print_tens
;---------------------------------------------------------
    
    ; Printing of 9 in Roman 'IX'     
    print_9:
    mov ah, 2
    mov dl, 'I'
    int 21h
    
    mov ah, 2
    mov dl, 'X'
    int 21h
    
    sub ones_digit, 9
    jmp print_ones
;---------------------------------------------------------
    
    ; Printing of 5 in Roman 'V'
    print_5:
    mov ah, 2
    mov dl, 'V'
    int 21h
    
    sub ones_digit, 5
    jmp print_ones
;---------------------------------------------------------

    ; Printing of 4 in Roman 'IV'    
    print_4:
    mov ah, 2
    mov dl, 'I'
    int 21h
    
    mov ah, 2
    mov dl, 'V'
    int 21h
    
    sub ones_digit, 4
    jmp print_ones
;---------------------------------------------------------

    ; Out the error if the coded exceeded 399
    @input_error:
    lea dx, error
    mov ah, 09h
    int 21h

    exit:
    mov ah,4ch
    int 21h 
        
    main endp
end main