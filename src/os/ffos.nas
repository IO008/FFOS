; TAB=4

		ORG		0xc200

		MOV		AL,0x13		; 320x200x8 位彩色模式， 调色板模式
		MOV		AH,0x00
		INT		0x10
fin:
		HLT
		JMP		fin
