; ffos
; TAB=4

    ORG		0x7c00          ; 程序加载地址

; FAT12格式 软盘
    JMP     entry
    DB		0x90
    DB      "FFOS IPL"      ; 启动区名称8字节
    DW      512     ; 每个扇区大小
    DB      1       ; cluster size
    DW      1       ; FAT 起始位置
    DB      2       ; FAT 个数 必须为2
    DW      224     ; 根目录大小
    DW      2880    ; 磁盘大小
    DB      0xf0    ; 磁盘种类
    DW      9       ; FAT 长度
    DW      18      ; 一个磁到有几个扇区
    DW      2       ; 磁头数
    DD      0       ; 不使用分区
    DD      2880    ; 重写磁盘大小
    DB      0,0,0x29    ; 固定
    DD		0xffffffff
    DB		"FFOS       "	; 磁盘名称 11 字节
    DB		"FAT12   "		; 磁盘名称 8字节
    RESB	18				

; 程序主体
entry:  
    MOV		AX,0			; 寄存器初始化
    MOV		SS,AX
    MOV		SP,0x7c00
    MOV		DS,AX

; 读盘初始化
    MOV     AX,0x0820
    MOV		ES,AX
    MOV     CH,0            ; 柱面0
    MOV     DH,0            ; 磁头号
    MOV     CL,2            ; 扇区号

readloop:
    MOV     SI,0            ; 记录读盘错误次数
; 读盘
retry:
    MOV     AH,0x02         ; 读入磁盘
    MOV     AL,1            ; 处理对象的扇区数 1个扇区
    MOV     BX,0            ; 缓冲地址
    MOV     DL,0x00         ; 驱动器号
    INT     0x13            ; 调用bios磁盘函数
    JNC     fin
    ADD     SI,1
    CMP     SI,5            ; 重试5次
    JAE     error
    MOV     AH,0x00         ; 磁盘复位
    MOV     DL,0x00
    INT     0x13
    JMP     retry

fin:
    HLT						; 停止cpu 直到有事件发生
    JMP		fin	

error:
    MOV		SI,msg

putloop:
    MOV		AL,[SI]
    ADD		SI,1			
    CMP		AL,0
    JE		fin
    MOV		AH,0x0e			; 单字符显示功能
    MOV		BX,15			; 色标
    INT		0x10			; 视频 BIOS 调用
    JMP		putloop

; 信息显示
msg:
    DB		0x0a, 0x0a		; 2个换行
    DB		"load error"
    DB		0x0a			; 换行
    DB		0

    RESB	0x7dfe-$		; 填写0x00 直到 0x001fe

    DB		0x55, 0xaa