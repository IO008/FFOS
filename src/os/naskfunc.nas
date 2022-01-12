; naskfunc
; TAB=4

[FORMAT "WCOFF"]        ; 目标文件模式
[BITS 32]       ; 制作32位模式用的机器语言

; 制作目标文件信息
[FILE "naskfunc.nas"]       ; 源文件信息

        GLOBAL  _io_hlt     ; 程序中包含函数名
; 实际函数
[SECTION .text]     ;目标文件写了这些之后再写程序

_io_hlt:        ; void io_hit(void);
        HLT
        RET
