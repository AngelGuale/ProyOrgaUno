.data
mensajeNroPalabra: .asciiz "\n el numero de palabras es: "
ingresaNombre: .asciiz "Ingrese el nombre del archivo: "
nombreArchivo: .asciiz "prueba1.txt"
sinEspacio: .asciiz "sinEspacio.txt"

buffer: .asciiz ""
bufferSinEspacio: .asciiz ""

.text

#la $a0, ingresaNombre
#li $v0, 4
#syscall

li $s7, 0 #s7 es el numero de palabras


############# guardar memoria #######
li $v0, 9           #allocate memory for new record
li $a0, 2048         #enough memory for 2 addresses and all the data
syscall

move $s0, $v0           #hang onto the initial address of all our info
move $t0, $s0
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

Loop:
lb $t5, 0($s2) #cargo el primer caracter

#para imprimir caracter
#move $a0, $t5 #movemos el caracter a imprimir
#li $v0, 11 # 11 para imprimir caracter
#syscall

li $t7, 32 #cargo el caracter de espacio
bne $t5, $t7, enter
	###########todo ok
	addi $s7, $s7, 1 #suma uno al numero de palabras
	j finalloop
enter:
li $t8, 13 #cargo el caracter de retorno de carro
bne $t5, $t8, prefinalloop
	########### todo ok
	addi $s7, $s7, 1 #suma uno al numero de palabras
	j finalloop

prefinalloop:
sb $t5, 0($s0) #guardo cuando no es cero
addi $s0, $s0, 1
finalloop:
addi $s2, $s2,1 #sumo uno al puntero
lb $t6 0($s2) #cargo el caracter siguiente
bne $t6, $zero, Loop #termina el loop 

li $v0,4
la $a0,mensajeNroPalabra
syscall

move $a0, $s7 #muevo el numero de palabras para imprimir
li $v0, 1
syscall


li $v0,4
move $a0,$t0
syscall

######abrir para escribir archivo###############
la $a0, sinEspacio
li $a1, 1 # 0 para leer 1 para escribir
li $a2, 0
li $v0, 13
syscall   

move $s1, $v0 #guarda la salida, o sea el file descriptor


# Write to file just opened
  li   $v0, 15       # system call for write to file
  move $a0, $s1      # file descriptor 
  move   $a1, $t0   # address of buffer from which to write
  li   $a2, 2048       # hardcoded buffer length
  syscall            # write to file


exit: 
li $v0, 10
syscall
