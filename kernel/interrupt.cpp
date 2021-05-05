#include "interrupt.hpp"

// Interrupt Descriptor Table
std::array<InterruptDescriptor, 256> idt;

void NotifyEndOfInterrupt() {
  volatile auto end_of_interrupt = reinterpret_cast<uint32_t*>(0xfee000b0);
  *end_of_interrupt = 0;
}
