     1 00000000                                 [FORMAT "WCOFF"]
     2 00000000                                 [INSTRSET "i486p"]
     3 00000000                                 [OPTIMIZE 1]
     4 00000000                                 [OPTION 1]
     5 00000000                                 [BITS 32]
     6 00000000                                 	EXTERN	_init_gdtidt
     7 00000000                                 	EXTERN	_init_paletee
     8 00000000                                 	EXTERN	_init_screen
     9 00000000                                 	EXTERN	_init_mouse_cursor8
    10 00000000                                 	EXTERN	_putblock8_8
    11 00000000                                 	EXTERN	_putfonts8_asc
    12 00000000                                 	EXTERN	_sprintf
    13 00000000                                 	EXTERN	_io_hlt
    14 00000000                                 [FILE "bootpack.c"]
    15                                          [SECTION .data]
    16 00000000                                 LC0:
    17 00000000 41 42 43 20 31 32 33 00         	DB	"ABC 123",0x00
    18 00000008                                 LC1:
    19 00000008 48 61 72 69 62 6F 74 65 20 4F   	DB	"Haribote OS.",0x00
       00000012 53 2E 00 
    20 00000015                                 LC2:
    21 00000015 73 63 72 6E 78 20 3D 20 25 64   	DB	"scrnx = %d",0x00
       0000001F 00 
    22                                          [SECTION .text]
    23 00000000                                 	GLOBAL	_HariMain
    24 00000000                                 _HariMain:
    25 00000000 55                              	PUSH	EBP
    26 00000001 89 E5                           	MOV	EBP,ESP
    27 00000003 57                              	PUSH	EDI
    28 00000004 56                              	PUSH	ESI
    29 00000005 53                              	PUSH	EBX
    30 00000006 8D 9D FFFFFEC4                  	LEA	EBX,DWORD [-316+EBP]
    31 0000000C 81 EC 00000130                  	SUB	ESP,304
    32 00000012 E8 [00000000]                   	CALL	_init_gdtidt
    33 00000017 E8 [00000000]                   	CALL	_init_paletee
    34 0000001C 0F BF 05 00000FF6               	MOVSX	EAX,WORD [4086]
    35 00000023 50                              	PUSH	EAX
    36 00000024 0F BF 05 00000FF4               	MOVSX	EAX,WORD [4084]
    37 0000002B 50                              	PUSH	EAX
    38 0000002C FF 35 00000FF8                  	PUSH	DWORD [4088]
    39 00000032 E8 [00000000]                   	CALL	_init_screen
    40 00000037 B9 00000002                     	MOV	ECX,2
    41 0000003C 0F BF 05 00000FF4               	MOVSX	EAX,WORD [4084]
    42 00000043 8D 50 F0                        	LEA	EDX,DWORD [-16+EAX]
    43 00000046 89 D0                           	MOV	EAX,EDX
    44 00000048 99                              	CDQ
    45 00000049 F7 F9                           	IDIV	ECX
    46 0000004B 0F BF 15 00000FF6               	MOVSX	EDX,WORD [4086]
    47 00000052 83 EA 2C                        	SUB	EDX,44
    48 00000055 89 C7                           	MOV	EDI,EAX
    49 00000057 89 D0                           	MOV	EAX,EDX
    50 00000059 6A 0E                           	PUSH	14
    51 0000005B 99                              	CDQ
    52 0000005C F7 F9                           	IDIV	ECX
    53 0000005E 53                              	PUSH	EBX
    54 0000005F 89 C6                           	MOV	ESI,EAX
    55 00000061 E8 [00000000]                   	CALL	_init_mouse_cursor8
    56 00000066 6A 10                           	PUSH	16
    57 00000068 53                              	PUSH	EBX
    58 00000069 8D 5D C4                        	LEA	EBX,DWORD [-60+EBP]
    59 0000006C 56                              	PUSH	ESI
    60 0000006D 57                              	PUSH	EDI
    61 0000006E 6A 10                           	PUSH	16
    62 00000070 6A 10                           	PUSH	16
    63 00000072 0F BF 05 00000FF4               	MOVSX	EAX,WORD [4084]
    64 00000079 50                              	PUSH	EAX
    65 0000007A FF 35 00000FF8                  	PUSH	DWORD [4088]
    66 00000080 E8 [00000000]                   	CALL	_putblock8_8
    67 00000085 83 C4 34                        	ADD	ESP,52
    68 00000088 68 [00000000]                   	PUSH	LC0
    69 0000008D 6A 07                           	PUSH	7
    70 0000008F 6A 08                           	PUSH	8
    71 00000091 6A 08                           	PUSH	8
    72 00000093 0F BF 05 00000FF4               	MOVSX	EAX,WORD [4084]
    73 0000009A 50                              	PUSH	EAX
    74 0000009B FF 35 00000FF8                  	PUSH	DWORD [4088]
    75 000000A1 E8 [00000000]                   	CALL	_putfonts8_asc
    76 000000A6 68 [00000008]                   	PUSH	LC1
    77 000000AB 6A 00                           	PUSH	0
    78 000000AD 6A 1F                           	PUSH	31
    79 000000AF 6A 1F                           	PUSH	31
    80 000000B1 0F BF 05 00000FF4               	MOVSX	EAX,WORD [4084]
    81 000000B8 50                              	PUSH	EAX
    82 000000B9 FF 35 00000FF8                  	PUSH	DWORD [4088]
    83 000000BF E8 [00000000]                   	CALL	_putfonts8_asc
    84 000000C4 83 C4 30                        	ADD	ESP,48
    85 000000C7 68 [00000008]                   	PUSH	LC1
    86 000000CC 6A 07                           	PUSH	7
    87 000000CE 6A 1E                           	PUSH	30
    88 000000D0 6A 1E                           	PUSH	30
    89 000000D2 0F BF 05 00000FF4               	MOVSX	EAX,WORD [4084]
    90 000000D9 50                              	PUSH	EAX
    91 000000DA FF 35 00000FF8                  	PUSH	DWORD [4088]
    92 000000E0 E8 [00000000]                   	CALL	_putfonts8_asc
    93 000000E5 0F BF 05 00000FF4               	MOVSX	EAX,WORD [4084]
    94 000000EC 50                              	PUSH	EAX
    95 000000ED 68 [00000015]                   	PUSH	LC2
    96 000000F2 53                              	PUSH	EBX
    97 000000F3 E8 [00000000]                   	CALL	_sprintf
    98 000000F8 83 C4 24                        	ADD	ESP,36
    99 000000FB 53                              	PUSH	EBX
   100 000000FC 6A 07                           	PUSH	7
   101 000000FE 6A 40                           	PUSH	64
   102 00000100 6A 10                           	PUSH	16
   103 00000102 0F BF 05 00000FF4               	MOVSX	EAX,WORD [4084]
   104 00000109 50                              	PUSH	EAX
   105 0000010A FF 35 00000FF8                  	PUSH	DWORD [4088]
   106 00000110 E8 [00000000]                   	CALL	_putfonts8_asc
   107 00000115 83 C4 18                        	ADD	ESP,24
   108 00000118                                 L2:
   109 00000118 E8 [00000000]                   	CALL	_io_hlt
   110 0000011D EB F9                           	JMP	L2
