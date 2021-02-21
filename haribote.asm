  org 0xc200

  mov al, 0x13 ; Standard 256-color mode on VGA graphics hardware
  mov ah, 0x00 ; Video mode
  int 0x10

fin:
  hlt
  jmp fin
