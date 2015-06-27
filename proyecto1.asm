.data
mensajeNroPalabra: .asciiz "\n el numero de palabras es: "
ingresaNombre: .asciiz "Ingrese el nombre del archivo: "
nombreArchivo: .asciiz "prueba1.txt"
buffer: .asciiz ""

.text

#la $a0, ingresaNombre
#li $v0, 4
#syscall


li $s7, 0 #s7 es el numero de palabras
#abre el archivo, 13 es para abrir funcion OPEN
la $a0, nombreArchivo
li $a1, 0
li $a2, 0
li $v0, 13
syscall   

move $s1, $v0 #guarda la salida, o sea el file descriptor

move $a0, $s1 #muevo el filedescriptor a a0
la $a1, buffer #cargo la direccion del buffer 
li $a2, 2048 # el numero de longitud del buffer
li $v0, 14 #la opcion de leer archivo
syscall


#li $v0, 4
#la $a0, buffer
#syscall 

la $s2, buffer #cargo la direccion del buffer
Loop:
lb $t5, 0($s2) #cargo el primer caracter

#para imprimir caracter
#move $a0, $t5 #movemos el caracter a imprimir
#li $v0, 11 # 11 para imprimir caracter
#syscall

li $t7, 32 #cargo el caracter de espacio
bne $t5, $t7, enter
addi $s7, $s7, 1
enter:
li $t8, 13 #cargo el caracter de retorno de carro
bne $t5, $t8, final
addi $s7, $s7, 1
final:
addi $s2, $s2,1 #sumo uno al puntero
lb $t6 0($s2) #cargo el caracter siguiente
bne $t6, $zero, Loop #termina el loop 

li $v0,4
la $a0,mensajeNroPalabra
syscall

move $a0, $s7 #muevo el numero de palabras para imprimir
li $v0, 1
syscall

