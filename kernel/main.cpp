extern "C" int KernelMain() {
  while (1) __asm__("hlt");
}
