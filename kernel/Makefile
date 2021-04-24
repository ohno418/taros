OBJS = main.o graphics.o font.o hankaku.o newlib_support.o console.o pci.o asmfunc.o

CPPFLAGS = -I/usr/include -I/usr/include/c++/10.2.0 -I/usr/include/c++/10.2.0/x86_64-pc-linux-gnu \
		   -I/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include \
		   -nostdinc
CFLAGS   = -O2 -Wall -g -ffreestanding -mno-red-zone
CXXFLAGS = -O2 -Wall -g -ffreestanding -mno-red-zone \
		   -fno-exceptions -fno-rtti -std=c++17
LDFLAGS  = -L/home/yutarofire/dev/taros/build_newlib/libc \
		   --entry KernelMain -z norelro -z separate-code \
		   --image-base 0x100000 --static


kernel.elf: $(OBJS) Makefile
	ld.lld $(LDFLAGS) -o $@ $(OBJS) -lc

%.o: %.cpp Makefile
	g++ $(CPPFLAGS) $(CXXFLAGS) -c $<

%.o: %.c Makefile
	gcc $(CPPFLAGS) $(CFLAGS) -c $<

%.o: %.asm Makefile
	nasm -f elf64 -o $@ $<


# Fonts
hankaku.o: hankaku.bin
	objcopy -I binary -O elf64-x86-64 -B i386:x86-64 $< $@

hankaku.bin: hankaku.txt
	../tools/makefont.py -o $@ $<


.PHONY: clean
clean:
	rm -f kernel.elf *.o *.bin
