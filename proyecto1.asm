.data

ingresaNombre: .asciiz "Ingrese el nombre del archivo: "
nombreArchivo: .asciiz "prueba1.txt"
buffer: .asciiz ""
.text

#la $a0, ingresaNombre
#li $v0, 4
#syscall

#li $

#abre el archivo, 13 es para abrir
la $a0, nombreArchivo
li $a1, 0
li $a2, 0
li $v0, 13

syscall   
move $s1, $v0 #guarda la salida

move $a0, $s1 #muevo el filedescriptor a a0
la $a1, buffer
li $a2, 300
li $v0, 14
syscall


li $v0, 4
la $a0, buffer
syscall 

la $s2, buffer #cargo la direccion del buffer

