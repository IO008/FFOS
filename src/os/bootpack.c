void io_hlt();
void io_cli(void);	// 中断标志设为0，禁止中断
void io_out8(int port, int data);
int io_load_eflags(void);	// 记录中断许可标志位
void io_store_eflags(int eflags);	// 恢复中断许可标志

void init_paletee();
void set_palette(int start, int end, unsigned char *rgb);

void HariMain(void) {
	int i;
	for (i = 0xa0000; i <= 0xaffff; i++) {	// 写入 vram 中
		*((char*)i) = i & 0x0f;
	}
	
	for (;;) {
		io_hlt();
	}
}

void init_paletee() {
	static unsigned char table_rgb[16 * 3] = {
		0x00, 0x00, 0x00,	/*  0:黒 */
		0xff, 0x00, 0x00,	/*  1:亮红 */
		0x00, 0xff, 0x00,	/*  2:亮绿*/
		0xff, 0xff, 0x00,	/*  3:亮黄 */
		0x00, 0x00, 0xff,	/*  4:亮蓝 */
		0xff, 0x00, 0xff,	/*  5:亮紫 */
		0x00, 0xff, 0xff,	/*  6:浅亮蓝 */
		0xff, 0xff, 0xff,	/*  7:白 */
		0xc6, 0xc6, 0xc6,	/*  8:亮灰 */
		0x84, 0x00, 0x00,	/*  9:暗红 */
		0x00, 0x84, 0x00,	/* 10:暗绿 */
		0x84, 0x84, 0x00,	/* 11:暗黄 */
		0x00, 0x00, 0x84,	/* 12:暗蓝 */
		0x84, 0x00, 0x84,	/* 13:暗紫 */
		0x00, 0x84, 0x84,	/* 14:浅暗蓝色 */
		0x84, 0x84, 0x84	/* 15:暗灰色 */
	};
	set_palette(0, 15, table_rgb);
}

void set_palette(int start, int end, unsigned char *rgb) {
	int i, eflags;
	eflags = io_load_eflags(); 
	io_cli(); 
	io_out8(0x03c8, start);
	for (i = start; i < end; i++) {
		io_out8(0x03c9, rgb[0] / 4);
		io_out8(0x03c9, rgb[1] / 4);
		io_out8(0x03c9, rgb[2] / 4);
		rgb += 3;
	}
	io_store_eflags(eflags); 
}
