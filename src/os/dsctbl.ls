     1 00000000                                 [FORMAT "WCOFF"]
     2 00000000                                 [INSTRSET "i486p"]
     3 00000000                                 [OPTIMIZE 1]
     4 00000000                                 [OPTION 1]
     5 00000000                                 [BITS 32]
     6 00000000                                 	EXTERN	_load_gdtr
     7 00000000                                 	EXTERN	_load_idtr
     8 00000000                                 	EXTERN	_asm_inthandler21
     9 00000000                                 	EXTERN	_asm_inthandler27
    10 00000000                                 	EXTERN	_asm_inthandler2c
    11 00000000                                 [FILE "dsctbl.c"]
    12                                          [SECTION .text]
    13 00000000                                 	GLOBAL	_init_gdtidt
    14 00000000                                 _init_gdtidt:
    15 00000000 55                              	PUSH	EBP
    16 00000001 89 E5                           	MOV	EBP,ESP
    17 00000003 56                              	PUSH	ESI
    18 00000004 53                              	PUSH	EBX
    19 00000005 BE 00270000                     	MOV	ESI,2555904
    20 0000000A BB 00001FFF                     	MOV	EBX,8191
    21 0000000F                                 L6:
    22 0000000F 6A 00                           	PUSH	0
    23 00000011 6A 00                           	PUSH	0
    24 00000013 6A 00                           	PUSH	0
    25 00000015 56                              	PUSH	ESI
    26 00000016 83 C6 08                        	ADD	ESI,8
    27 00000019 E8 000000B7                     	CALL	_set_segmdesc
    28 0000001E 83 C4 10                        	ADD	ESP,16
    29 00000021 4B                              	DEC	EBX
    30 00000022 79 EB                           	JNS	L6
    31 00000024 68 00004092                     	PUSH	16530
    32 00000029 BE 0026F800                     	MOV	ESI,2553856
    33 0000002E 6A 00                           	PUSH	0
    34 00000030 BB 000000FF                     	MOV	EBX,255
    35 00000035 6A FF                           	PUSH	-1
    36 00000037 68 00270008                     	PUSH	2555912
    37 0000003C E8 00000094                     	CALL	_set_segmdesc
    38 00000041 68 0000409A                     	PUSH	16538
    39 00000046 68 00280000                     	PUSH	2621440
    40 0000004B 68 0007FFFF                     	PUSH	524287
    41 00000050 68 00270010                     	PUSH	2555920
    42 00000055 E8 0000007B                     	CALL	_set_segmdesc
    43 0000005A 83 C4 20                        	ADD	ESP,32
    44 0000005D 68 00270000                     	PUSH	2555904
    45 00000062 68 0000FFFF                     	PUSH	65535
    46 00000067 E8 [00000000]                   	CALL	_load_gdtr
    47 0000006C 58                              	POP	EAX
    48 0000006D 5A                              	POP	EDX
    49 0000006E                                 L11:
    50 0000006E 6A 00                           	PUSH	0
    51 00000070 6A 00                           	PUSH	0
    52 00000072 6A 00                           	PUSH	0
    53 00000074 56                              	PUSH	ESI
    54 00000075 83 C6 08                        	ADD	ESI,8
    55 00000078 E8 000000A2                     	CALL	_set_gatedesc
    56 0000007D 83 C4 10                        	ADD	ESP,16
    57 00000080 4B                              	DEC	EBX
    58 00000081 79 EB                           	JNS	L11
    59 00000083 68 0026F800                     	PUSH	2553856
    60 00000088 68 000007FF                     	PUSH	2047
    61 0000008D E8 [00000000]                   	CALL	_load_idtr
    62 00000092 6A 08                           	PUSH	8
    63 00000094 6A 10                           	PUSH	16
    64 00000096 68 [00000000]                   	PUSH	_asm_inthandler21
    65 0000009B 68 0026F908                     	PUSH	2554120
    66 000000A0 E8 0000007A                     	CALL	_set_gatedesc
    67 000000A5 6A 08                           	PUSH	8
    68 000000A7 6A 10                           	PUSH	16
    69 000000A9 68 [00000000]                   	PUSH	_asm_inthandler27
    70 000000AE 68 0026F938                     	PUSH	2554168
    71 000000B3 E8 00000067                     	CALL	_set_gatedesc
    72 000000B8 83 C4 28                        	ADD	ESP,40
    73 000000BB 6A 08                           	PUSH	8
    74 000000BD 6A 10                           	PUSH	16
    75 000000BF 68 [00000000]                   	PUSH	_asm_inthandler2c
    76 000000C4 68 0026F960                     	PUSH	2554208
    77 000000C9 E8 00000051                     	CALL	_set_gatedesc
    78 000000CE 8D 65 F8                        	LEA	ESP,DWORD [-8+EBP]
    79 000000D1 5B                              	POP	EBX
    80 000000D2 5E                              	POP	ESI
    81 000000D3 5D                              	POP	EBP
    82 000000D4 C3                              	RET
    83 000000D5                                 	GLOBAL	_set_segmdesc
    84 000000D5                                 _set_segmdesc:
    85 000000D5 55                              	PUSH	EBP
    86 000000D6 89 E5                           	MOV	EBP,ESP
    87 000000D8 53                              	PUSH	EBX
    88 000000D9 8B 55 0C                        	MOV	EDX,DWORD [12+EBP]
    89 000000DC 8B 4D 10                        	MOV	ECX,DWORD [16+EBP]
    90 000000DF 8B 5D 08                        	MOV	EBX,DWORD [8+EBP]
    91 000000E2 8B 45 14                        	MOV	EAX,DWORD [20+EBP]
    92 000000E5 81 FA 000FFFFF                  	CMP	EDX,1048575
    93 000000EB 76 08                           	JBE	L17
    94 000000ED C1 EA 0C                        	SHR	EDX,12
    95 000000F0 0D 00008000                     	OR	EAX,32768
    96 000000F5                                 L17:
    97 000000F5 66 89 13                        	MOV	WORD [EBX],DX
    98 000000F8 88 43 05                        	MOV	BYTE [5+EBX],AL
    99 000000FB C1 EA 10                        	SHR	EDX,16
   100 000000FE C1 F8 08                        	SAR	EAX,8
   101 00000101 83 E2 0F                        	AND	EDX,15
   102 00000104 66 89 4B 02                     	MOV	WORD [2+EBX],CX
   103 00000108 83 E0 F0                        	AND	EAX,-16
   104 0000010B C1 F9 10                        	SAR	ECX,16
   105 0000010E 09 C2                           	OR	EDX,EAX
   106 00000110 88 4B 04                        	MOV	BYTE [4+EBX],CL
   107 00000113 88 53 06                        	MOV	BYTE [6+EBX],DL
   108 00000116 C1 F9 08                        	SAR	ECX,8
   109 00000119 88 4B 07                        	MOV	BYTE [7+EBX],CL
   110 0000011C 5B                              	POP	EBX
   111 0000011D 5D                              	POP	EBP
   112 0000011E C3                              	RET
   113 0000011F                                 	GLOBAL	_set_gatedesc
   114 0000011F                                 _set_gatedesc:
   115 0000011F 55                              	PUSH	EBP
   116 00000120 89 E5                           	MOV	EBP,ESP
   117 00000122 53                              	PUSH	EBX
   118 00000123 8B 55 08                        	MOV	EDX,DWORD [8+EBP]
   119 00000126 8B 45 10                        	MOV	EAX,DWORD [16+EBP]
   120 00000129 8B 5D 14                        	MOV	EBX,DWORD [20+EBP]
   121 0000012C 8B 4D 0C                        	MOV	ECX,DWORD [12+EBP]
   122 0000012F 66 89 42 02                     	MOV	WORD [2+EDX],AX
   123 00000133 88 5A 05                        	MOV	BYTE [5+EDX],BL
   124 00000136 66 89 0A                        	MOV	WORD [EDX],CX
   125 00000139 89 D8                           	MOV	EAX,EBX
   126 0000013B C1 F8 08                        	SAR	EAX,8
   127 0000013E C1 F9 10                        	SAR	ECX,16
   128 00000141 88 42 04                        	MOV	BYTE [4+EDX],AL
   129 00000144 66 89 4A 06                     	MOV	WORD [6+EDX],CX
   130 00000148 5B                              	POP	EBX
   131 00000149 5D                              	POP	EBP
   132 0000014A C3                              	RET
