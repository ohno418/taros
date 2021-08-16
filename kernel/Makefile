OBJS = main.o graphics.o mouse.o font.o hankaku.o newlib_support.o console.o \
	   pci.o asmfunc.o libcxx_support.o logger.o interrupt.o segment.o paging.o \
	   memory_manager.o window.o layer.o timer.o frame_buffer.o acpi.o keyboard.o \
	   task.o terminal.o \
	   usb/memory.o usb/device.o usb/xhci/ring.o usb/xhci/trb.o usb/xhci/xhci.o \
	   usb/xhci/port.o usb/xhci/device.o usb/xhci/devmgr.o usb/xhci/registers.o \
	   usb/classdriver/base.o usb/classdriver/hid.o usb/classdriver/keyboard.o \
	   usb/classdriver/mouse.o
CPPFLAGS = -I/usr/include/c++/v1 -I/usr/include -I. -nostdlibinc
CFLAGS   = -O2 -Wall -g -ffreestanding -mno-red-zone -nostdlib
CXXFLAGS = -O2 -Wall -g -ffreestanding -mno-red-zone \
           -fno-exceptions -fno-rtti -std=c++17 -nostdlib
LDFLAGS  = -L/home/ohno/dev/osdev/taros/kernel/newlib \
           -L/usr/lib \
           -L/usr/lib/gcc/x86_64-pc-linux-gnu/11.1.0 \
           --entry KernelMain -z norelro -z separate-code \
           --image-base 0x100000 --static


kernel.elf: $(OBJS) Makefile
	ld.lld $(LDFLAGS) -o $@ $(OBJS) -lc -lc++ -lc++abi -lgcc -lgcc_eh

%.o: %.cpp Makefile
	clang++ $(CPPFLAGS) $(CXXFLAGS) -c -o $@ $<

%.o: %.c Makefile
	clang $(CPPFLAGS) $(CFLAGS) -c $<

%.o: %.asm Makefile
	nasm -f elf64 -o $@ $<


# Fonts
hankaku.o: hankaku.bin
	objcopy -I binary -O elf64-x86-64 -B i386:x86-64 $< $@

hankaku.bin: hankaku.txt
	../tools/makefont.py -o $@ $<


.PHONY: clean
clean:
	rm -f kernel.elf *.o *.bin \
		usb/*.o usb/xhci/*.o usb/classdriver/*.o
