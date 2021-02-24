; BOOT_INFO
cyls equ 0x0ff0
leds equ 0x0ff1
vmode equ 0x0ff2
scrnx equ 0x0ff4
scrny equ 0x0ff6
vram equ 0x0ff8

  org 0xc200

  ; Video interruption
  mov al, 0x13 ; Standard 256-color mode (320*200*8bit color)
  mov ah, 0x00 ; Video mode
  int 0x10

  mov byte [vmode], 8
  mov word [scrnx], 320
  mov word [scrny], 20
  mov dword [vram], 0x000a0000

  ; Keyboard interruption
  mov ah, 0x02 ; Get the state of the keyboard
  int 0x16
  mov [leds], al

fin:
  hlt
  jmp fin
