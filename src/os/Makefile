TOOLPATH = ../tolset/z_tools/
MAKE = $(TOOLPATH)make.exe
NASK = $(TOOLPATH)nask.exe
EDIMG = $(TOOLPATH)edimg.exe
IMGTOL = $(TOOLPATH)imgtol.com
COPY = copy
DEL = del

default :
	$(MAKE) img

ipl.bin : ipl.nas Makefile
	$(NASK) ipl.nas ipl.bin ipl.lst

ffos.sys : ffos.nas Makefile
	$(NASK) ffos.nas ffos.sys ffos.lst

ffos.img : ipl.bin ffos.sys Makefile
	$(EDIMG)	imgin:../tolset/z_tools/fdimg0at.tek \
		wbinimg src:ipl.bin len:512 from:0 to:0  \
		copy from:ffos.sys to:@: \
		imgout:ffos.img

img :
	$(MAKE) ffos.img

run :
	$(MAKE) img
	$(COPY) ffos.img ..\tolset\z_tools\qemu\fdimage0.bin
	$(MAKE) -C ../tolset/z_tools/qemu

install :
	$(MAKE) img
	$(IMGTOL) w a: ffos.img

clean :
	-$(DEL) ipl.bin
	-$(DEL) ipl.lst
	-$(DEL) ffos.sys
	-$(DEL) ffos.lst

src_only :
	$(MAKE) clean
	-$(DEL) ffos.img
