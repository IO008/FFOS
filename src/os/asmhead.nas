; asmhead
; TAB=4

BOTPAK	EQU		0x00280000		; bootpack 加载目的地
DSKCAC	EQU		0x00100000		; 磁盘缓存位置
DSKCAC0	EQU		0x00008000		; 磁盘缓存位置（实模式）

CYLS	EQU		0x0ff0		; 设定启动区
LEDS	EQU		0x0ff1
VMODE	EQU		0x0ff2		; 颜色数目信息。颜色位数
SCRNX	EQU		0x0ff4		; 分辨率的X
SCRNY	EQU		0x0ff6		; 分辨率的Y
VRAM	EQU		0x0ff8		; 图像缓冲区开始地址

		ORG		0xc200

		MOV		AL,0x13		; 320x200x8 位彩色模式， 调色板模式
		MOV		AH,0x00
		INT		0x10
		MOV		BYTE [VMODE],8		; 记录换面模式
		MOV		WORD [SCRNX],320
		MOV		WORD [SCRNY],200
		MOV		DWORD [VRAM],0x000a0000

		MOV		AH,0x02
		INT		0x16	; keyboard bios
		MOV		[LEDS],AL

; 阻止 PIC 接受任何中断
; 根据 AT 兼容机的规范，如果要初始化 PIC， 如果你不在 CLI 前面这样做，它会偶尔挂起
; PIC 初始化将在稍后完成

		MOV		AL,0xff
		OUT		0x21,AL
		NOP						; 如果重复 OUT 命令，似乎有些模型不起作用。
		OUT		0xa1,AL

		CLI						; 此外，即使在 CPU 级别也禁用中断。

		; 设置 A20GATE 使 CPU 可以访问 1MB 以上的内存

		CALL	waitkbdout
		MOV		AL,0xd1
		OUT		0x64,AL
		CALL	waitkbdout
		MOV		AL,0xdf			; enable A20
		OUT		0x60,AL
		CALL	waitkbdout

; 保护模式转换

[INSTRSET "i486p"]				; 想要使用486指令的描述

		LGDT	[GDTR0]			; 设置临时 GDT
		MOV		EAX,CR0
		AND		EAX,0x7fffffff	; 将bit31设置为0（因为禁止分页）
		OR		EAX,0x00000001	; 将 bit0 设置为 1（用于转换到保护模式）
		MOV		CR0,EAX
		JMP		pipelineflush
pipelineflush:
		MOV		AX,1*8			; 读/写段 32bit
		MOV		DS,AX
		MOV		ES,AX
		MOV		FS,AX
		MOV		GS,AX
		MOV		SS,AX

; bootpack转发

		MOV		ESI,bootpack	; 转发源
		MOV		EDI,BOTPAK		; 转发目的地
		MOV		ECX,512*1024/4
		CALL	memcpy

; 磁盘数据最终转送到它本来的位置去

; 首先从引导扇区

		MOV		ESI,0x7c00		; 转发源
		MOV		EDI,DSKCAC		; 转发目的地
		MOV		ECX,512/4
		CALL	memcpy

; 其他的

		MOV		ESI,DSKCAC0+512	; 转发源
		MOV		EDI,DSKCAC+512	; 转发目的地
		MOV		ECX,0
		MOV		CL,BYTE [CYLS]
		IMUL	ECX,512*18*2/4	; 从柱面数转换为字节数 / 4
		SUB		ECX,512/4		; IPL减去
		CALL	memcpy

; asmhead 我已经做了我必须做的一切
; 剩下的交给 bootpack

; bootpack启动

		MOV		EBX,BOTPAK
		MOV		ECX,[EBX+16]
		ADD		ECX,3			; ECX += 3;
		SHR		ECX,2			; ECX /= 4;
		JZ		skip			; 没有什么可以转移的
		MOV		ESI,[EBX+20]	; 转发源
		ADD		ESI,EBX
		MOV		EDI,[EBX+12]	; 转发目的地
		CALL	memcpy
skip:
		MOV		ESP,[EBX+12]	; 初始堆栈值
		JMP		DWORD 2*8:0x0000001b

waitkbdout:
		IN		 AL,0x64
		AND		 AL,0x02
		JNZ		waitkbdout		; AND 如果结果不为0，则转到waitkbdout
		RET

memcpy:
		MOV		EAX,[ESI]
		ADD		ESI,4
		MOV		[EDI],EAX
		ADD		EDI,4
		SUB		ECX,1
		JNZ		memcpy			; 如果减法的结果不为0，去memcpy
		RET
; 如果不忘记输入地址大小前缀，memcpy 也可以用字符串指令编写

		ALIGNB	16
GDT0:
		RESB	8				; 空选择器
		DW		0xffff,0x0000,0x9200,0x00cf	; 读/写段 32bit
		DW		0xffff,0x0000,0x9a28,0x0047	; 可执行段 32 位（用于bootpack）

		DW		0
GDTR0:
		DW		8*3-1
		DD		GDT0

		ALIGNB	16
bootpack: