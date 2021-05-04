disk.img: bootx64.efi kernel/kernel.elf
	qemu-img create -f raw $@ 200M
	mkfs.fat -n 'MIKAN OS' -s 2 -f 2 -R 32 -F 32 $@
	mkdir -p mnt
	sudo mount -o loop $@ mnt
	sudo mkdir -p mnt/efi/boot
	sudo cp $< mnt/efi/boot/$<
	sudo cp kernel/kernel.elf mnt/kernel.elf
	sudo umount mnt

.PHONY: run
run: disk.img
	qemu-system-x86_64 \
		-monitor stdio \
		-drive if=pflash,file=../mikanos-build/devenv/OVMF_CODE.fd \
		-drive if=pflash,file=../mikanos-build/devenv/OVMF_VARS.fd \
		-hda $<

bootx64.efi: FORCE
	rm -f $@
	cp ../edk2/Build/MikanLoaderX64/DEBUG_CLANG38/X64/Loader.efi ./$@

kernel/kernel.elf: FORCE
	$(MAKE) -C ./kernel

FORCE:

.PHONY: clean
clean:
	$(MAKE) -C ./kernel clean
	rm -rf disk.img bootx64.efi mnt
