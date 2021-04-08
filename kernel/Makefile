kernel.elf: main.o
	ld.lld --entry KernelMain -z norelro -z separate-code --image-base 0x100000 \
		--static -o $@ $<

main.o: main.cpp
	g++ -O2 -Wall -g -ffreestanding -mno-red-zone -fno-exceptions \
		-fno-rtti -std=c++17 -c -o $@ $<

.PHONY: clean
clean:
	rm -f kernel.elf main.o
