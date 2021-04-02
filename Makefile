.PHONY: run
run: disk.img
	qemu-system-x86_64 \
		-monitor stdio \
		-drive if=pflash,file=../mikanos-build/devenv/OVMF_CODE.fd \
		-drive if=pflash,file=../mikanos-build/devenv/OVMF_VARS.fd \
		-hda $<

disk.img: bootx64.efi
	qemu-img create -f raw $@ 200M
	mkfs.fat -n 'MIKAN OS' -s 2 -f 2 -R 32 -F 32 $@
	mkdir -p mnt
	sudo mount -o loop $@ mnt
	sudo mkdir -p mnt/efi/boot
	sudo cp $< mnt/efi/boot/$<
	sudo umount mnt

.PHONY: clean
clean:
	sudo rm -rf *.img *.efi *.o mnt
