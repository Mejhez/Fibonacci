.data
prompt1: .asciiz "Ingrese la cantidad de numeros de la serie Fibonacci: "
result:  .asciiz "La serie Fibonacci es: "
sum_msg: .asciiz "La suma de los numeros de la serie es: "

.text
main:
    # Mostrar mensaje para ingresar la cantidad de números
    li $v0, 4              
    la $a0, prompt1        
    syscall

    # Leer la cantidad de números
    li $v0, 5              
    syscall
    move $t0, $v0         

    # Verificar que la cantidad sea al menos 1
    blez $t0, error        # si la cantidad es menor o igual a 0, mostrar error

    # Inicializar variables
    li $t1, 0             
    li $t2, 1             
    li $t3, 0             
    li $t4, 0             
    li $t5, 0             
    li $t6, 1              

print_series:
    # Mostrar el número actual de la serie
    li $v0, 1              
    move $a0, $t1          
    syscall

    # Imprimir coma si no es el último número
    bne $t3, $t0, print_comma

    # Imprimir salto de línea después del último número
    li $v0, 11            
    li $a0, 10            
    syscall
    j continue_sum

print_comma:
    li $v0, 11            
    li $a0, 44             
    syscall
    li $v0, 11             
    li $a0, 32          
    syscall

continue_sum:
    add $t4, $t4, $t1      

    # Calcular el siguiente número en la serie
    add $t5, $t1, $t2     
    move $t1, $t2          
    move $t2, $t5        

    # Incrementar el índice
    addi $t3, $t3, 1      
    bne $t3, $t0, print_series  # repetir hasta alcanzar la cantidad

    # Mostrar mensaje con la suma
    li $v0, 4             
    la $a0, sum_msg        
    syscall

    li $v0, 1             
    move $a0, $t4          
    syscall

    # Salir del programa
    li $v0, 10             
    syscall

error:
    # Mostrar mensaje de error si la cantidad no es la correcta
    li $v0, 4              
    la $a0, error_message  
    syscall

    li $v0, 10            
    syscall

.data
error_message: .asciiz "La cantidad de numeros debe ser mayor a 0."
