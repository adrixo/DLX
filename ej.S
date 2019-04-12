
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

	.text

	.global main

main:
;carga de datos de A
	lf	f0,A+0(R1)
	lf	f1,A+4(R1)
	lf	f2,A+8(R1)
	addi r1,r1,12
	lf	f3,A+0(R1)
	lf	f4,A+4(R1)
	lf	f5,A+8(R1)
	addi r1,r1,12
	lf	f6,A+0(R1)
	lf	f7,A+4(R1)
	lf	f8,A+8(R1)

;carga de datos de B
	lf	f9,B+0(R2)
	lf	f10,B+4(R2)
	lf	f11,B+8(R2)
	addi r2,r2,12
	lf	f12,B+0(R2)
	lf	f13,B+4(R2)
	lf	f14,B+8(R2)
	addi r2,r2,12
	lf	f15,B+0(R2)
	lf	f16,B+4(R2)
	lf	f17,B+8(R2)

;suma de A+B
	addf f20,f0,f9
	addf f21,f1,f10
	addf f22,f2,f11
	addf f23,f3,f12
	addf f24,f4,f13
	addf f25,f5,f14
	addf f26,f6,f15
	addf f27,f7,f16	
	addf f28,f8,f17

;determinante de A+B
	multf f29,f20,f24
	multf f18,f20,f25
	multf f30,f21,f25
	multf f19,f22,f24
	multf f31,f23,f27
	multf f20,f23,f21
	multf f29,f29,f28
	multf f18,f18,f27
	multf f30,f30,f26
	multf f19,f19,f26
	multf f31,f31,f22
	multf f20,f20,f28

	addf f29,f29,f30
	addf f18,f18,f19
	addf f29,f29,f31
	addf f30,f18,f20

	subf f31,f29,f30 ;determinante de A+B
	
	;beqz f31,fin

;division de uno entre determinante de A+B
	lf f21,div(R0)
	divf f31,f21,f31

;multiplicacion de A*B
	multf f18,f0,f9
	multf f19,f1,f12
	multf f20,f2,f15
	multf f21,f0,f10
	multf f22,f1,f13
	multf f23,f2,f16
	multf f24,f0,f11
	multf f25,f1,f14
	multf f26,f2,f17

	addf f18,f18,f19
	addf f21,f21,f22
	addf f24,f24,f25
	addf f18,f18,f20
	addf f19,f21,f23
	addf f20,f24,f26

	multf f21,f3,f9
	multf f22,f4,f12
	multf f23,f5,f15
	multf f24,f3,f10
	multf f25,f4,f13
	multf f26,f5,f16
	multf f27,f3,f11
	multf f28,f4,f14
	multf f29,f5,f17

	addf f21,f21,f22
	addf f24,f24,f25
	addf f27,f27,f28
	addf f21,f21,f23
	addf f22,f24,f26
	addf f23,f27,f29

	multf f24,f6,f9
	multf f25,f7,f12	
	multf f26,f8,f15
	multf f27,f6,f10
	multf f28,f7,f13	
	multf f29,f8,f16
	multf f30,f6,f11
	multf f0,f7,f14	
	multf f1,f8,f17

	addf f24,f24,f25
	addf f27,f27,f28
	addf f30,f30,f0
	addf f24,f24,f26
	addf f25,f27,f29
	addf f26,f30,f1


;multiplicacion de A*B*(1/|A+B|)
	multf f9,f18,f31
	multf f10,f19,f31
	multf f11,f20,f31
	multf f12,f21,f31
	multf f13,f22,f31
	multf f14,f23,f31
	multf f15,f24,f31
	multf f16,f25,f31
	multf f17,f26,f31

;carga de datos de C
	lf	f0,C+0(R3)
	lf	f1,C+4(R3)
	lf	f2,C+8(R3)
	addi r3,r3,12
	lf	f3,C+0(R3)
	lf	f4,C+4(R3)
	lf	f5,C+8(R3)
	addi r3,r3,12
	lf	f6,C+0(R3)
	lf	f7,C+4(R3)
	lf	f8,C+8(R3)

;carga de datos de Alfa
	lf	f9,Alfa(R4)

;multiplicacion de C*Alfa
	multf f0,f0,f9
	multf f1,f1,f9
	multf f2,f2,f9
	multf f3,f3,f9
	multf f4,f4,f9
	multf f5,f5,f9
	multf f6,f6,f9
	multf f7,f7,f9
	multf f8,f8,f9

;suma de C*Alfa+A*B*(1/|A+B|)
	addf f0,f0,f9
	addf f1,f1,f10
	addf f2,f2,f11
	addf f3,f3,f12
	addf f4,f4,f13
	addf f5,f5,f14
	addf f6,f6,f15
	addf f7,f7,f16
	addf f8,f8,f17

;guardar valores en M
	sf	M+0(R5),f0
	sf	M+4(R5),f1
	sf	M+8(R5),f2
	addi r5,r5,12
	sf	M+0(R5),f3
	sf	M+4(R5),f4
	sf	M+8(R5),f5
	addi r5,r5,12
	sf	M+0(R5),f6
	sf	M+4(R5),f7
	sf	M+8(R5),f8

fin:
	trap 0

