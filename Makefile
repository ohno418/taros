ipl.bin: ipl.asm
	nasm -f bin -o ipl.bin ipl.asm

haribote.sys: haribote.asm
	nasm -f bin -o haribote.sys haribote.asm

haribote.img : ipl.bin haribote.sys
	./z_tools/edimg imgin:./z_tools/fdimg0at.tek \
		wbinimg src:ipl.bin len:512 from:0 to:0 \
		copy from:haribote.sys to:@: \
		imgout:haribote.img

.PHONY: run
run: haribote.img
	qemu-system-x86_64 -fda haribote.img


.PHONY: clean
clean:
	rm -f ipl.bin haribote.sys haribote.img
