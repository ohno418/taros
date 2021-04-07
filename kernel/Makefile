kernel.elf: main.o
	ld.lld --entry KernelMain -z norelro -z separate-code --image-base 0x100000 \
		--static -o $@ $<

main.o: main.cpp
	g++ -O2 -fno-exceptions -ffreestanding \
		-c -o $@ $<

.PHONY: clean
clean:
	rm -f kernel.elf main.o
