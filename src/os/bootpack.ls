     1 00000000                                 [FORMAT "WCOFF"]
     2 00000000                                 [INSTRSET "i486p"]
     3 00000000                                 [OPTIMIZE 1]
     4 00000000                                 [OPTION 1]
     5 00000000                                 [BITS 32]
     6 00000000                                 	EXTERN	_init_gdtidt
     7 00000000                                 	EXTERN	_init_pic
     8 00000000                                 	EXTERN	_io_sti
     9 00000000                                 	EXTERN	_init_paletee
    10 00000000                                 	EXTERN	_init_screen
    11 00000000                                 	EXTERN	_init_mouse_cursor8
    12 00000000                                 	EXTERN	_putblock8_8
    13 00000000                                 	EXTERN	_sprintf
    14 00000000                                 	EXTERN	_putfonts8_asc
    15 00000000                                 	EXTERN	_io_out8
    16 00000000                                 	EXTERN	_io_hlt
    17 00000000                                 [FILE "bootpack.c"]
    18                                          [SECTION .data]
    19 00000000                                 LC0:
    20 00000000 73 63 72 6E 78 20 3D 20 25 64   	DB	"scrnx = %d",0x00
       0000000A 00 
    21                                          [SECTION .text]
    22 00000000                                 	GLOBAL	_HariMain
    23 00000000                                 _HariMain:
    24 00000000 55                              	PUSH	EBP
    25 00000001 89 E5                           	MOV	EBP,ESP
    26 00000003 57                              	PUSH	EDI
    27 00000004 56                              	PUSH	ESI
    28 00000005 53                              	PUSH	EBX
    29 00000006 8D 9D FFFFFEC4                  	LEA	EBX,DWORD [-316+EBP]
    30 0000000C 81 EC 00000130                  	SUB	ESP,304
    31 00000012 E8 [00000000]                   	CALL	_init_gdtidt
    32 00000017 E8 [00000000]                   	CALL	_init_pic
    33 0000001C E8 [00000000]                   	CALL	_io_sti
    34 00000021 E8 [00000000]                   	CALL	_init_paletee
    35 00000026 0F BF 05 00000FF6               	MOVSX	EAX,WORD [4086]
    36 0000002D 50                              	PUSH	EAX
    37 0000002E 0F BF 05 00000FF4               	MOVSX	EAX,WORD [4084]
    38 00000035 50                              	PUSH	EAX
    39 00000036 FF 35 00000FF8                  	PUSH	DWORD [4088]
    40 0000003C E8 [00000000]                   	CALL	_init_screen
    41 00000041 B9 00000002                     	MOV	ECX,2
    42 00000046 0F BF 05 00000FF4               	MOVSX	EAX,WORD [4084]
    43 0000004D 8D 50 F0                        	LEA	EDX,DWORD [-16+EAX]
    44 00000050 89 D0                           	MOV	EAX,EDX
    45 00000052 99                              	CDQ
    46 00000053 F7 F9                           	IDIV	ECX
    47 00000055 0F BF 15 00000FF6               	MOVSX	EDX,WORD [4086]
    48 0000005C 83 EA 2C                        	SUB	EDX,44
    49 0000005F 89 C7                           	MOV	EDI,EAX
    50 00000061 89 D0                           	MOV	EAX,EDX
    51 00000063 6A 0E                           	PUSH	14
    52 00000065 99                              	CDQ
    53 00000066 F7 F9                           	IDIV	ECX
    54 00000068 53                              	PUSH	EBX
    55 00000069 89 C6                           	MOV	ESI,EAX
    56 0000006B E8 [00000000]                   	CALL	_init_mouse_cursor8
    57 00000070 6A 10                           	PUSH	16
    58 00000072 53                              	PUSH	EBX
    59 00000073 8D 5D C4                        	LEA	EBX,DWORD [-60+EBP]
    60 00000076 56                              	PUSH	ESI
    61 00000077 57                              	PUSH	EDI
    62 00000078 6A 10                           	PUSH	16
    63 0000007A 6A 10                           	PUSH	16
    64 0000007C 0F BF 05 00000FF4               	MOVSX	EAX,WORD [4084]
    65 00000083 50                              	PUSH	EAX
    66 00000084 FF 35 00000FF8                  	PUSH	DWORD [4088]
    67 0000008A E8 [00000000]                   	CALL	_putblock8_8
    68 0000008F 83 C4 34                        	ADD	ESP,52
    69 00000092 0F BF 05 00000FF4               	MOVSX	EAX,WORD [4084]
    70 00000099 50                              	PUSH	EAX
    71 0000009A 68 [00000000]                   	PUSH	LC0
    72 0000009F 53                              	PUSH	EBX
    73 000000A0 E8 [00000000]                   	CALL	_sprintf
    74 000000A5 53                              	PUSH	EBX
    75 000000A6 6A 07                           	PUSH	7
    76 000000A8 6A 00                           	PUSH	0
    77 000000AA 6A 00                           	PUSH	0
    78 000000AC 0F BF 05 00000FF4               	MOVSX	EAX,WORD [4084]
    79 000000B3 50                              	PUSH	EAX
    80 000000B4 FF 35 00000FF8                  	PUSH	DWORD [4088]
    81 000000BA E8 [00000000]                   	CALL	_putfonts8_asc
    82 000000BF 83 C4 24                        	ADD	ESP,36
    83 000000C2 68 000000F9                     	PUSH	249
    84 000000C7 6A 21                           	PUSH	33
    85 000000C9 E8 [00000000]                   	CALL	_io_out8
    86 000000CE 68 000000EF                     	PUSH	239
    87 000000D3 68 000000A1                     	PUSH	161
    88 000000D8 E8 [00000000]                   	CALL	_io_out8
    89 000000DD 83 C4 10                        	ADD	ESP,16
    90 000000E0                                 L2:
    91 000000E0 E8 [00000000]                   	CALL	_io_hlt
    92 000000E5 EB F9                           	JMP	L2
