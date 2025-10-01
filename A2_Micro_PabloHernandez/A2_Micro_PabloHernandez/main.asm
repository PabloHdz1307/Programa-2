;
; A2_Micro_PabloHernandez.asm
;Facutad de Estudios Superiores Cuautitlán
;Universidad Nacional Autonoma de México 
;Ingeniería en Telecomunicaciones, Sistemas y Electrónica
; Author : Pablo Hernandez
;Actividad 2 Microcontroladores

;Declaracion de variables
.dseg
.org 0x120
var1:	.byte 1;

;Inicia segmento de programa
.cseg 
.org 0x00
.def nhex = r16
.equ ramdir = 0x0200
	rjmp main

//Programa Principal
main:
;Inicia el Stack
    ldi     R16, low(RAMEND)
    out     SPL, R16
    ldi     R16, high(RAMEND)
    out     SPH, R16

//Programa principal
		ldi ZH,high(var1) //Carga en la parte alta de Z la parte alta de la dirección de var1
		ldi ZL,low(var1)  //Carga en la parte baja de Z la parte baja de la dirección var1
		ldi nhex,0x0F     //aqui se carga en valor de n menor o igual a 99
bucle_hex:
		st Z+,nhex		//Guarda el valor de nhex en la direccion a la que apunta Z y lo incrementa
		dec	nhex		//Decrementa nhex

		cpi	nhex,0xFF  //compara si nhex es igual a -1 (0xFF)
		brne bucle_hex	//si no es igual, salta al bucle hex

//Conversión y almacenamiento

		ldi ZH,high(var1) //Carga en la parte alta de Z la parte alta de la dirección de var1
		ldi ZL,low(var1)  //Carga en la parte baja de Z la parte baja de la dirección var1
		ldi XH,high(ramdir)	;Carga en la parte alta de X la parte alta de la dirección de ramdir
		ldi XL,low(ramdir)	;""
bucle:

		ld nhex,Z+ //Carga en nhex lo que hay en Z e incrementa Z
		call conversion

			






//Subrutina de conversión
conversion:
		



;