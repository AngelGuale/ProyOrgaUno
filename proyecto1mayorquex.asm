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
li $s6, 0 #s6 es el numero de palabras mayor que s5
#abre el archivo, 13 es para abrir funcion OPEN
######abrir para leer archivo###############
la $a0, nombreArchivo
li $a1, 0 # 0 para leer 1 para escribir
li $a2, 0
li $v0, 13
syscall   

move $s1, $v0 #guarda la salida, o sea el file descriptor
#################### leer el archivo##############
move $a0, $s1 #muevo el filedescriptor a a0
la $a1, buffer #cargo la direccion del buffer 
li $a2, 2048 # el numero de longitud del buffer
li $v0, 14 #la opcion de leer archivo
syscall


#li $v0, 4
#la $a0, buffer
#syscall 

la $s2, buffer #cargo la direccion del buffer
li $t1, 0 #t1 guardara el tamanio de la palabra
li $s5, 20 #tamanio de palabra

move $a0, $s5
li $v0, 1
syscall

Loop:
lb $t5, 0($s2) #cargo el primer caracter

#li $a0, 0
#li $v0, 1
#syscall 
#para imprimir caracter
#move $a0, $t5 #movemos el caracter a imprimir
#li $v0, 11 # 11 para imprimir caracter
#syscall

li $t7, 32 #cargo el caracter de espacio
bne $t5, $t7, enter
	###########todo ok
	######mensaje debug 1 espacio 
	li $a0, 1
	li $v0, 1
	syscall 
	#######
	
	addi $s7, $s7, 1 #suma uno al numero de palabras
	slt $t4, $s5,$t1
	li $t1, 0
	beq $t4, $zero, prefinalloop
	
	li $a0, 0
	li $v0, 1
	syscall 
	
	addi $s6, $s6, 1 #suma uno al numero de palabras
	j finalloop
enter:
li $t8, 13 #cargo el caracter de retorno de carro
bne $t5, $t8, prefinalloop
	########### todo ok
	######mensaje debug 1 espacio 
	li $a0, 1
	li $v0, 1
	syscall 
	#######
	
	
	addi $s7, $s7, 1 #suma uno al numero de palabras
	slt $t4, $s5,$t1
	li $t1, 0
	beq $t4, $zero, prefinalloop
	
	li $a0, 0
	li $v0, 1
	syscall 
	addi $s6, $s6, 1 #suma uno al numero de palabras
	j finalloop

prefinalloop:
addi $t1, $t1, 1 #sumo uno al tamanio de la palabra
finalloop:
addi $s2, $s2,1 #sumo uno al puntero
lb $t6 0($s2) #cargo el caracter siguiente
bne $t6, $zero, Loop #termina el loop 

li $v0,4
la $a0,mensajeNroPalabra
syscall

move $a0, $s6 #muevo el numero de palabras para imprimir
li $v0, 1
syscall

exit: 
li $v0, 10
syscall
