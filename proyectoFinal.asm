.data

menu1: .asciiz "1) Contar numero de palabras\n2)Contar numero de palabras mayor que un n\n3)Crear archivo sin espacios\n4)Crear archivo al reves\n5)Salir\nIngrese una opcion:"

mensajeNroPalabra: .asciiz "\n el numero de palabras es: "
ingresaNombre: .asciiz "Ingrese el nombre del archivo: "
nombreArchivo: .asciiz "prueba1.txt"
sinEspacio: .asciiz "sinEspacio.txt"
alReves: .asciiz "alReves.txt"
aux: .asciiz  ""
presCualqMsj: .asciiz "\nOprima enter para continuar"
buffer: .asciiz ""
bufferNombreArchivo: .space 1024

bufferSinEspacio: .asciiz ""

.text
############### menu ##################
menu:
la $a0, menu1
li $v0, 4
syscall

li $v0, 5
syscall
move $t0, $v0

elegirMenu:
	li $t1, 1
	bne $t0, $t1, opcion2
	jal contarPalabras
	jal presionaCualquiera
	j menu
opcion2:
	li $t1, 2
	bne $t0, $t1, opcion3
	jal contarPalabrasMayor
	jal presionaCualquiera
	j menu
opcion3:
	li $t1, 3
	bne $t0, $t1, opcion4
	jal funcionSinEspacios
	jal presionaCualquiera
	j menu
opcion4:
	li $t1, 4
	bne $t0, $t1, opcionSalir
	j funcionAlReves
	jal presionaCualquiera
 	j menu
opcionSalir:
	li $t1, 5
	bne $t0, $t1, menu
	j exit


contarPalabras:

li $s5, 5 #tamanio de palabra
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


la $s2, buffer #cargo la direccion del buffer
li $t1, 0 #t1 guardara el tamanio de la palabra

Loop:
lb $t5, 0($s2) #cargo el primer caracter


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
jr $ra
###################### OPCION 2 #############################
####################### CONTAR PALABRAS MAYOR QUE ################################
contarPalabrasMayor:
li $s5, 5 #tamanio de palabra
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

Loop3:
lb $t5, 0($s2) #cargo el primer caracter

#para imprimir caracter
#move $a0, $t5 #movemos el caracter a imprimir
#li $v0, 11 # 11 para imprimir caracter
#syscall

li $t7, 32 #cargo el caracter de espacio
bne $t5, $t7, enter3
	###########todo ok
	addi $s7, $s7, 1 #suma uno al numero de palabras
	slt $t4, $s5,$t1
	beq $t4, $zero, prefinalloop3
	addi $s6, $s6, 1 #suma uno al numero de palabras
	li $t1, 0
	j finalloop3
enter3:
li $t8, 13 #cargo el caracter de retorno de carro
bne $t5, $t8, prefinalloop3
	########### todo ok
	addi $s7, $s7, 1 #suma uno al numero de palabras
	slt $t4, $s5,$t1
	beq $t4, $zero, prefinalloop3
	addi $s6, $s6, 1 #suma uno al numero de palabras
	li $t1, 0
	j finalloop3

prefinalloop3:
addi $t1, $t1, 1 #sumo uno al tamanio de la palabra
finalloop3:
addi $s2, $s2,1 #sumo uno al puntero
lb $t6 0($s2) #cargo el caracter siguiente
bne $t6, $zero, Loop3 #termina el loop 

li $v0,4
la $a0,mensajeNroPalabra
syscall

move $a0, $s6 #muevo el numero de palabras para imprimir
li $v0, 1
syscall


jr $ra
############################### SIN ESPACIO #########################
#####################################################################
funcionSinEspacios:
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


la $s2, buffer #cargo la direccion del buffer

Loop1:
lb $t5, 0($s2) #cargo el primer caracter


li $t7, 32 #cargo el caracter de espacio
bne $t5, $t7, enter1
	###########todo ok es espacio
	addi $s7, $s7, 1 #suma uno al numero de palabras
	j finalloop1
enter1:
li $t8, 13 #cargo el caracter de retorno de carro
bne $t5, $t8, prefinalloop1
	########### todo ok es espacio
	addi $s7, $s7, 1 #suma uno al numero de palabras
	j finalloop1

prefinalloop1:
sb $t5, 0($s0) #guardo cuando no es cero
addi $s0, $s0, 1
finalloop1:
addi $s2, $s2,1 #sumo uno al puntero
lb $t6 0($s2) #cargo el caracter siguiente
bne $t6, $zero, Loop1 #termina el loop 

li $v0,4
la $a0,mensajeNroPalabra
syscall

move $a0, $s7 #muevo el numero de palabras para imprimir
li $v0, 1
syscall

   ##### con esto imprimo la salida
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


########## escribir sobre el archivo abierto #######
  li   $v0, 15       # 15 es para escribir
  move $a0, $s1      # file descriptor 
  move   $a1, $t0   # address of buffer from which to write
  li   $a2, 2048       # longitud del buffer
  syscall            # write to file

 ############ cerrar el archivo ############### 
  li   $v0, 16       # system call for close file
  move $a0, $s1      # file descriptor to close
  syscall            # close file


jr $ra

################# AL REVES #####################################
################################################################
funcionAlReves:

############# guardar memoria #######
li $v0, 9           #allocate memory for new record
li $a0, 2048         #enough memory for 2 addresses and all the data
syscall

move $s0, $v0           #hang onto the initial address of all our info
move $t0, $s0
addi $s0, $s0, 2048
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
li $t1, 0 #tamanio de buffer al reves
Loop2:
lb $t5, 0($s2) #cargo el primer caracter

#para imprimir caracter
#move $a0, $t5 #movemos el caracter a imprimir
#li $v0, 11 # 11 para imprimir caracter
#syscall

li $t7, 32 #cargo el caracter de espacio
bne $t5, $t7, enter2
	###########todo ok
	addi $s7, $s7, 1 #suma uno al numero de palabras
	j finalloop2
enter2:
li $t8, 13 #cargo el caracter de retorno de carro
bne $t5, $t8, prefinalloop2
	########### todo ok
	addi $s7, $s7, 1 #suma uno al numero de palabras
	j finalloop2

prefinalloop2:
sb $t5, 0($s0) #guardo cuando no es cero
addi $s0, $s0, -1
addi $t1, $t1, 1
finalloop2:
addi $s2, $s2,1 #sumo uno al puntero
lb $t6 0($s2) #cargo el caracter siguiente
bne $t6, $zero, Loop2 #termina el loop 

li $v0,4
la $a0,mensajeNroPalabra
syscall

addi $s0, $s0, 1 #le sumo uno porque en el loop queda uno atras

move $a0, $s7 #muevo el numero de palabras para imprimir
li $v0, 1
syscall


li $v0,4
move $a0,$s0
syscall

######abrir para escribir archivo###############
la $a0, alReves
li $a1, 1 # 0 para leer 1 para escribir
li $a2, 0
li $v0, 13
syscall   

move $s1, $v0 #guarda la salida, o sea el file descriptor


# Write to file just opened
  li   $v0, 15       # system call for write to file
  move $a0, $s1      # file descriptor 
  move   $a1, $s0   # address of buffer from which to write
  move   $a2, $t1       # hardcoded buffer length
  syscall            # write to file
 jr $ra
#############################################################################

########## pediremos el nombre del archivo #################
#la $a0, ingresaNombre
#li $v0, 4
#syscall

#la $a0, bufferNombreArchivo
#li $a1, 16
#li $v0, 8
#syscall
#####################################
#la $a0, bufferNombreArchivo
#li $v0, 4
#syscall
presionaCualquiera:

la $a0, presCualqMsj
li $v0, 4
syscall

la $a0, aux
li $a1, 1024
li $v0, 8
syscall
jr $ra

exit: 
li $v0, 10
syscall
