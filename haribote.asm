  org 0xc200

  ; Video interrupt
  mov al, 0x13 ; Standard 256-color mode on VGA graphics hardware
  mov ah, 0x00 ; Video mode
  int 0x10

  ; Keyboard interrupt
  mov ah, 0x02 ; Get the state of the keyboard
  int 0x16

fin:
  hlt
  jmp fin
