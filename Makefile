run: disk.img
	qemu-system-x86_64 \
		-monitor stdio \
		-drive if=pflash,file=../mikanos-build/devenv/OVMF_CODE.fd \
		-drive if=pflash,file=../mikanos-build/devenv/OVMF_VARS.fd \
		-hda disk.img

disk.img: bootx64.efi
	qemu-img create -f raw disk.img 200M
	mkfs.fat -n 'MIKAN OS' -s 2 -f 2 -R 32 -F 32 disk.img
	mkdir -p mnt
	sudo mount -o loop disk.img mnt
	sudo mkdir -p mnt/efi/boot
	sudo cp bootx64.efi mnt/efi/boot/bootx64.efi
	sudo umount mnt

.PHONY: clean
clean:
	sudo rm -rf disk.img bootx64.efi mnt
