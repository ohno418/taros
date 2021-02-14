# File creating ruls

ipl.bin: ipl.asm
	nasm -f bin -o ipl.bin ipl.asm

haribote.sys: haribote.asm
	nasm -f bin -o haribote.sys haribote.asm

# TODO
# ref: https://github.com/hide27k/haribote-os/blob/master/03_day/harib00e/Makefile
