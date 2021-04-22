#include "pci.hpp"

/** @brief Generate 32-bit integer for CONFIG_ADDRESS */
uint32_t MakeAddress(uint8_t bus, uint8_t device,
                     uint8_t function, uint8_t reg_addr) {
  auto shl = [](uint32_t x, unsigned int bits) {
    return x << bits;
  };

  return shl(1, 31) // enable bit
      | shl(bus, 16)
      | shl(device, 11)
      | shl(function, 8)
      | (reg_addr & 0xfcu); // Mask lower 2 bits with 0.
}
