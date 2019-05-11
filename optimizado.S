
	.data

A:	.float	1.500000,	2.750000,	3.257000
		.float	21.002000,	2.658000,	2.157000 
		.float	56.251000,	3.154000,	3.255000

B:	.float	3.500000,	3.500000,	2.500000
		.float	4.500000,	4.500000,	6.500000		
		.float	5.500000, 1.500000,	2.500000 
	
C: 	.float	15.000000,	17.000000,	14.000000 
		.float	17.000000,	15.000000,	17.000000
		.float	14.000000,	17.000000,	15.000000		 
	
Alfa:	.float 1.235 

M:	.float	0.0,0.0,0.0
		.float	0.0,0.0,0.0
		.float	0.0,0.0,0.0

div: .float 1.0
cero: .float 0.0

	.text

	.global main

main:
	lf	f0,A+0(R0)   ;comienza la carga de datos de A (registros 0-8)
	lf	f9,B+0(R0)   ;comienza la carga de datos de B (registros 9-17)
	lf	f1,A+4(R0)
	multf f27,f0,f9      ;comienza ;multiplicacion de A*B (registros 27-4)
	lf	f10,B+4(R0)
	addf f18,f0,f9       ;comienza la suma de A+B (registros 18-26)
	multf f28,f0,f10
	lf	f11,B+8(R0)
	addf f19,f1,f10
	multf f29,f0,f11
	addi r2,r2,12
	lf	f2,A+8(R0)
	lf	f12,B+0(R2)
	addf f20,f2,f11
	multf f30,f1,f12
	lf	f13,B+4(R2)
	addi r1,r1,12
	multf f31,f1,f13
	lf	f14,B+8(R2)
	addf f27,f27,f30
	multf f0,f1,f14
	lf	f3,A+0(R1)
	addi r2,r2,12
	addf f21,f3,f12
	multf f30,f3,f9
	lf	f15,B+0(R2)
	addf f28,f28,f31
	multf f1,f2,f15
	lf	f4,A+4(R1)
	addf f29,f29,f0
	multf f31,f3,f10
	lf	f16,B+4(R2)
	addf f22,f4,f13
	multf f0,f2,f16
	lf	f17,B+8(R2)
	addf f27,f27,f1
	multf f2,f2,f17
	lf	f5,A+8(R1)
	addf f28,f28,f0
	addi r1,r1,12
	multf f1,f3,f11
	lf	f6,A+0(R1)
	addf f23,f5,f14
	multf f0,f4,f12
	lf	f7,A+4(R1)
	addf f29,f29,f2
	multf f3,f4,f13	
	lf	f8,A+8(R1)
	addf f30,f30,f0
	multf f2,f4,f14
	addf f24,f6,f15
	multf f0,f5,f15
	addf f31,f31,f3
	multf f4,f5,f16
	addf f1,f1,f2
	multf f3,f5,f17
	addf f30,f30,f0 
	multf f2,f6,f9
	addf f31,f31,f4
	multf f0,f6,f10
	addf f1,f1,f3
	multf f5,f6,f11
	addf f25,f7,f16
	multf f4,f7,f12
	addf f26,f8,f17
	multf f3,f7,f13
	addf f2,f2,f4
	multf f6,f7,f14	
	addf f3,f0,f3
	multf f9,f21,f25     ; comienza el determinante de A+B
	multf f10,f22,f24
	multf f11,f22,f26
	subf f9,f9,f10
	multf f12,f25,f23
	multf f13,f21,f26
	multf f14,f23,f24
	subf f11,f11,f12
	multf f9,f20,f9
	subf f13,f13,f14
	multf f11,f18,f11
	lf f12,div(R0)       ;carga 1 para la division
	lf	f20,C+8(R0)  ;comienza la carga de datos de C (registros 18-26)
	multf f13,f19,f13
	lf f18,C+0(R0)		
	addf f9,f9,f11
	lf f19,C+4(R0)	
	multf f0,f8,f16
	lf	f11,cero(R0) ;carga 0 para la comprobación
	addf f5,f5,f6
	subf f7,f9,f13       ;determinante de A+B (se guarda en el registro 7)
	multf f4,f8,f15
	addi r3,r3,12
	eqf f7,f11           ;comprobacion del determinante por cero
	bfpt fin
	addf f3,f3,f0
	multf f6,f8,f17
	divf f7,f12,f7       ;division de uno entre determinante de A+B
	lf	f0,Alfa(R0)  ;carga de datos de Alfa
	lf	f21,C+0(R3)	
	addf f2,f2,f4
	multf f18,f18,f0     ;comienza la multiplicacion de C*Alfa (registros 18-26)
	addf f4,f5,f6
	multf f19,f19,f0
	lf	f22,C+4(R3)
	multf f20,f20,f0
	lf	f23,C+8(R3)
	addi r3,r3,12
	lf	f24,C+0(R3)
	lf	f25,C+4(R3)
	multf f9,f27,f7	      ;comienza la multiplicacion de A*B*(1/|A+B|)(registros 9-17)
	lf	f26,C+8(R3)
	multf f10,f28,f7
	addf f9,f18,f9        ;comienza la suma de C*Alfa+A*B*(1/|A+B|)(registros 9-17)
	multf f11,f29,f7
	addf f10,f19,f10
	multf f12,f30,f7
	sf	M+0(R0),f9    ;comienza guardar valores en M 
	multf f21,f21,f0
	sf	M+4(R0),f10
	addf f11,f20,f11
	multf f22,f22,f0
	sf	M+8(R0),f11
	addf f12,f21,f12
	multf f13,f31,f7
	addi r5,r5,12
	multf f14,f1,f7
	sf	M+0(R5),f12
	multf f23,f23,f0
	addf f13,f22,f13
	multf f15,f2,f7
	sf	M+4(R5),f13
	multf f24,f24,f0
	addf f14,f23,f14
	multf f25,f25,f0
	addf f15,f24,f15
	multf f16,f3,f7
	sf	M+8(R5),f14
	addi r5,r5,12
	multf f17,f4,f7
	multf f26,f26,f0
	addf f16,f25,f16
	sf	M+0(R5),f15
	sf	M+4(R5),f16
	addf f17,f26,f17
	sf	M+8(R5),f17


fin:
	trap 0


;282
