  org 0x7c00

entry:
  ; Initialize registers.
  mov ax, 0
  mov ss, ax
  mov sp, 0x7c00
  mov ds, ax
  mov es, ax

  mov si, msg

putloop:
  mov al, [si]
  add si, 1
  cmp al, 0
  je fin

  ; Display character.
  ; (AL = character,
  ;  BH = page number,
  ;  BL = color)
  mov ah, 0x0e
  mov bx, 15
  int 0x10

  jmp putloop

fin:
  hlt
  jmp fin

msg:
  db 0x0a, 0x0a
  db "hello, world"
  db 0x0a
  db 0

times 510-($-$$) db 0
dw 0xaa55

; nasm -f bin -o tmp.bin taros2.asm && qemu-system-x86_64 tmp.bin
