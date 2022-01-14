; naskfunc
; TAB=4

[FORMAT "WCOFF"]        ; 目标文件模式

[INSTRSET "i486p"]	; 486指令

[BITS 32]       ; 制作32位模式用的机器语言

; 制作目标文件信息
[FILE "naskfunc.nas"]       ; 源文件信息

        GLOBAL  _io_hlt,_write_mem8,_io_cli, _io_sti, _io_stihlt     ; 程序中包含函数名
        GLOBAL	_io_in8,  _io_in16,  _io_in32
        GLOBAL	_io_out8, _io_out16, _io_out32
        GLOBAL	_io_load_eflags, _io_store_eflags
; 实际函数
[SECTION .text]     ; 目标文件写了这些之后再写程序

_io_hlt:        ; void io_hit(void);
        HLT
        RET

_write_mem8:    ; void write_mem8(int addr, int data)
        MOV     ECX,[ESP+4] ; [ESP + 4] 存放的地址将其读入 ECX中
        MOV     AL,[ESP+8]    ; [ESP + 8] 存放数据 放入AL
        MOV     [ECX],AL
        RET

_io_cli:        ; void io_cli(void)
        CLI
        RET

_io_sti:        ; void io_sti(void);
        STI
        RET

_io_stihlt:	; void io_stihlt(void);
        STI
        HLT
        RET

_io_in8:	; int io_in8(int port);
        MOV	EDX,[ESP+4]	; port
        MOV	EAX,0
        IN	AL,DX
        RET

_io_in16:	; int io_in16(int port);
        MOV	EDX,[ESP+4]	; port
        MOV	EAX,0
        IN	AX,DX
        RET

_io_in32:	; int io_in32(int port);
        MOV	EDX,[ESP+4]	; port
        IN	EAX,DX
        RET

_io_out8:	; void io_out8(int port, int data);
        MOV	EDX,[ESP+4]	; port
        MOV	AL,[ESP+8]	; data
        OUT	DX,AL
        RET

_io_out16:	; void io_out16(int port, int data);
        MOV	EDX,[ESP+4]	; port
        MOV	EAX,[ESP+8]	; data
        OUT	DX,AX
        RET

_io_out32:	; void io_out32(int port, int data);
        MOV	EDX,[ESP+4]	; port
        MOV	EAX,[ESP+8]	; data
        OUT	DX,EAX
        RET

_io_load_eflags:        ; int io_load_eflags(void);
        PUSHFD		; PUSH EFLAGS 
        POP	EAX
        RET

_io_store_eflags:	; void io_store_eflags(int eflags);
        MOV	EAX,[ESP+4]
        PUSH	EAX
        POPFD	; POP EFLAGS
        RET