.PHONY: run
run: disk.img
	qemu-system-x86_64 \
		-monitor stdio \
		-drive if=pflash,file=../mikanos-build/devenv/OVMF_CODE.fd \
		-drive if=pflash,file=../mikanos-build/devenv/OVMF_VARS.fd \
		-hda $<

disk.img: bootx64.efi kernel/kernel.elf
	qemu-img create -f raw $@ 200M
	mkfs.fat -n 'MIKAN OS' -s 2 -f 2 -R 32 -F 32 $@
	mkdir -p mnt
	sudo mount -o loop $@ mnt
	sudo mkdir -p mnt/efi/boot
	sudo cp $< mnt/efi/boot/$<
	sudo cp kernel/kernel.elf mnt/kernel.elf
	sudo umount mnt

kernel/kernel.elf: kernel/main.o
	ld.lld --entry KernelMain -z norelro --image-base 0x100000 --static \
		-o $@ $<

kernel/main.o: kernel/main.cpp
	clang++ -O2 -Wall -g --target=x86_64-elf -ffreestanding -mno-red-zone \
		-fno-exceptions -fno-rtti -std=c++17 -c -o $@ $<

.PHONY: clean
clean:
	rm -rf disk.img bootx64.efi \
		kernel/main.o kernel/kernel.elf mnt
