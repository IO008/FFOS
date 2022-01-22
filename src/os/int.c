#include "bootpack.h"

void init_pic(void) 
{
	io_out8(PIC0_IMR, 0xff); /* 禁止所有中断 */
	io_out8(PIC1_IMR, 0xff); /* 禁止所有中断 */

	io_out8(PIC0_ICW1, 0x11); /* 边缘触发模式 */
	io_out8(PIC0_ICW2, 0x20); /* IRQ0-7由INT20-27接收 */
	io_out8(PIC0_ICW3, 1 << 2); /* PIC1由IRQ2连接 */
	io_out8(PIC0_ICW4, 0x01); /* 无缓冲区模式 */

	io_out8(PIC1_ICW1, 0x11); /* 边缘触发模式 */
	io_out8(PIC1_ICW2, 0x28); /* IRQ8-15由INT28-2f接收 */
	io_out8(PIC1_ICW3, 2); /* PIC1由IRQ2连接 */
	io_out8(PIC1_ICW4, 0x01); /* 无缓冲区模式 */

	io_out8(PIC0_IMR, 0xfb); /* 11111011 PIC1以外全部禁止 */
	io_out8(PIC1_IMR, 0xff); /* 11111111 禁止所有中断 */
}

#define PORT_KEYDAT		0x0060

struct KEYBUF keybuf;

// 键盘中断
void inthandler21(int *esp) 
{

	unsigned char data;
	io_out8(PIC0_OCW2, 0x61);	/* 通知pic IRQ-01 受理完毕 */
	data = io_in8(PORT_KEYDAT);
	if (keybuf.next < 32) {
		keybuf.data[keybuf.next] = data;
		keybuf.next++;
	}
}

// 鼠标中断
void inthandler2c(int *esp) 
{
	struct BOOTINFO *binfo = (struct BOOTINFO *) ADR_BOOTINFO;
	boxfill8(binfo->vram, binfo->scrnx, COL8_000000, 0, 0, 32 * 8 - 1, 15);
	putfonts8_asc(binfo->vram, binfo->scrnx, 0, 0, COL8_FFFFFF, "INT 2C (IRQ-12) : PS/2 mouse");
	for (;;) {
		io_hlt();
	}
}

/*针对来自PIC0的不完全中断的对策*/
/* 在 Athlon 64 X2 机器上，这个中断只在 PIC 初始化时发生一次，因为芯片组。 */
/*这个中断处理函数对中断什么都不做*/
/* 为什么你不必做任何事情？
→ 由于此中断是由 PIC 初始化期间的电噪声产生的，
你不必认真地做任何事情.*/
void inthandler27(int *esp)
{
	io_out8(PIC0_OCW2, 0x67); // 通知 PIC IRQ-07 验收完成（见 7-1）
	return;
}