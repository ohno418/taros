cyls equ 10

  org 0x7c00

; For FAT12 formatted floppy disk.
  jmp entry
  db 0x90
  db "HARIBOTE"
  dw 512
  db 1
  dw 1
  db 2
  dw 224
  dw 2880
  db 0xf0
  dw 9
  dw 18
  dw 2
  dd 0
  dd 2880
  db 0,0,0x29
  dd 0xffffffff
  db "HARIBOTEOS "
  db "FAT12   "
  resb 18

entry:
  ; Initialize registers.
  mov ax, 0
  mov ss, ax
  mov sp, 0x7c00
  mov ds, ax

; Load program from drive.
  mov ax, 0x0820
  mov es, ax   ; Buffer address pointer (ES:BX)
  mov ch, 0    ; Cylinder
  mov dh, 0    ; Head
  mov cl, 2    ; Sector

readloop:
  mov si, 0 ; failure counter

retry:
  mov ah, 0x02 ; Read from drive
  mov al, 1    ; Sectors to read count
  mov bx, 0
  mov dl, 0x00 ; Drive (1st floppy disk)
  int 0x13
  jnc next

  ; If failure
  add si, 1
  cmp si, 5
  jae error

  ; Reset dist system
  mov ah, 0x00
  mov dl, 0x00
  int 0x13
  jmp retry

next:
  ; Advance the load address by 0x200.
  mov ax, es
  add ax, 0x0020
  mov es, ax

  ; Advance the sector number.
  add cl, 1
  cmp cl, 18
  jbe readloop

  ; Go to next head.
  mov cl, 1
  add dh, 1
  cmp dh, 2
  jb readloop

  ; Go to next cylinder
  mov dh, 0
  add ch, 1
  cmp ch, cyls
  jb readloop

  ; Finally, execute haribote.sys!
  jmp 0xc200

fin:
  hlt
  jmp fin

error:
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

msg:
  db 0x0a, 0x0a
  db "load error"
  db 0x0a
  db 0

  times 510-($-$$) db 0
  db 0x55, 0xaa

; nasm -f bin -o tmp.bin ipl.asm && qemu-system-x86_64 tmp.bin