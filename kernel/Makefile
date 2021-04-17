OBJS = main.o graphics.o font.o hankaku.o

kernel.elf: $(OBJS) Makefile
	ld.lld --entry KernelMain -z norelro -z separate-code --image-base 0x100000 \
		--static -o $@ $(OBJS)

%.o: %.cpp Makefile
	g++ -O2 -Wall -g -ffreestanding -mno-red-zone -fno-exceptions \
		-fno-rtti -std=c++17 -c $<

hankaku.o: hankaku.bin
	objcopy -I binary -O elf64-x86-64 -B i386:x86-64 $< $@

hankaku.bin: hankaku.txt
	../tools/makefont.py -o $@ $<

.PHONY: clean
clean:
	rm -f kernel.elf *.o *.bin
