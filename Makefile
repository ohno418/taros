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

bootx64.efi: FORCE
	rm -f $@
	cp ../edk2/Build/MikanLoaderX64/DEBUG_CLANG38/X64/Loader.efi ./$@

kernel/kernel.elf: kernel/main.o
	ld.lld --entry KernelMain -z norelro -z separate-code --image-base 0x100000 \
		--static -o $@ $<

kernel/main.o: kernel/main.cpp
	clang++ -O2 --target=x86_64-elf -fno-exceptions -ffreestanding \
		-c -o $@ $<

FORCE:

.PHONY: clean
clean:
	rm -rf disk.img bootx64.efi \
		kernel/main.o kernel/kernel.elf mnt
