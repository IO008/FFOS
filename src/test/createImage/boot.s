
# A bootsect, which print a string by BIOS interrupt video services(int 0x10)
.section .text
.global _start
.code16
_start:
	movw	%cx,	%ax
	movw	%ax,	%ds
	movw	%ax,	%es
	movw	$msgstr,%bp
	movw	len,	%cx
	movb	$0x05,	%dh
	movb	$0x08,	%dl
	movb	$0x01,	%al
	movb	$0x13,	%ah
	movb	$0x01,	%bl
	movb	$0x00,	%bh
	int		$0x10
1:
	jmp		1b
msgstr:
	.asciz	"Hello babyos(print by BIOS int 0x10:0x13, mode 0x01)!"
len:
	.int	. - msgstr
	.org	0x1fe,	0x90
	.word	0xaa55
