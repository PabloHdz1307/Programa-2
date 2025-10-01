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
.def mem = r17
.def count = r20
.equ ramdir = 0x0200  //Dirección de inicio de escritura en la RAM
.equ n = 0x13  //aquí se define el valor de n
	rjmp main
//Look Up Table
tabla_dec:
	.db 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09
	.db 0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18, 0x19
	.db 0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28, 0x29
	.db 0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39
	.db 0x40, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47, 0x48, 0x49
	.db 0x50, 0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57, 0x58, 0x59
	.db 0x60, 0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67, 0x68, 0x69
	.db 0x70, 0x71, 0x72, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78, 0x79
	.db 0x80, 0x81, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87, 0x88, 0x89
	.db 0x90, 0x91, 0x92, 0x93, 0x94, 0x95, 0x96, 0x97, 0x98, 0x99
.align 2 //asegura que la siguiente instrucción a ejecutarse esté en una driección par

//Programa Principal
main:
;Inicia el Stack
    ldi     R16, low(RAMEND)
    out     SPL, R16
    ldi     R16, high(RAMEND)
    out     SPH, R16

//Programa principal
		ldi XH,high(var1) //Carga en la parte alta de X la parte alta de la dirección de var1
		ldi XL,low(var1)  //Carga en la parte baja de X la parte baja de la dirección var1
		ldi nhex,n     //aqui se carga el valor de n
bucle_hex:
		st X+,nhex		//Guarda el valor de nhex en la direccion a la que apunta X y lo incrementa
		dec	nhex		//Decrementa nhex
		cpi	nhex,0xFF  //compara si nhex es igual a -1 (0xFF)
		brne bucle_hex	//si no es igual, salta al bucle hex

//Conversión y almacenamiento
		ldi count, n + 1			//controla el número de iteraciones del bucle_conv
		ldi XH,high(var1)			 // Apuntador para leer 
		ldi XL,low(var1)			// los datos de la memoria RAM (0x120)

		ldi YH,high(ramdir)			;Apuntador para escribir
		ldi YL,low(ramdir)			; los datos en la memoria RAM (0x0200)

bucle_conv:
		ld mem, X+					// Carga en mem el dato de la dirección a la que apunta X y lo incrementa

	//búsqueda en tabla
		ldi ZH,high(tabla_dec*2)	//carga la parte alta de la dirección de la tabla
		ldi ZL,low(tabla_dec*2)		//Carga la parte baja de la dirección de la tabla
		add ZL, mem					//Le suma el índice donde se halla el dato

		lpm mem, Z					//Carga en mem el valor desde la tabla

		st Y+, mem					//Guarda en la RAM el valor de mem, ademas incrementa a Y
		dec count
		brne bucle_conv

end_loop:
		rjmp end_loop
			
		