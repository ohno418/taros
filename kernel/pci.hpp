#pragma once

#include <cstdint>
#include <array>
#include "error.hpp"

namespace pci {
  /** @brief IO port address of CONFIG_ADDRESS register. */
  const uint16_t kConfigAddress = 0x0cf8;
  /** @brief IO port address of CONFIG_DATA register. */
  const uint16_t kConfigData = 0x0cfc;

  /** @brief PCI device class code. */
  struct ClassCode {
    uint8_t base, sub, interface;

    bool Match(uint8_t b) { return b == base; }
    bool Match(uint8_t b, uint8_t s) { return Match(b) && s == sub; }
    bool Match(uint8_t b, uint8_t s, uint8_t i) {
      return Match(b, s) && i == interface;
    }
  };

  /** @brief Store basic information for PCI devices. */
  struct Device {
    uint8_t bus, device, function, header_type;
    ClassCode class_code;
  };

  /** @brief Write an integer into CONFIG_ADDRESS. */
  void WriteAddress(uint32_t address);
  /** @brief Write data into CONFIG_DATA. */
  void WriteData(uint32_t value);
  /** @brief Read 32-bit integer from CONFIG_DATA. */
  uint32_t ReadData();

  /** @brief Read from vendor ID register. */
  uint16_t ReadVendorId(uint8_t bus, uint8_t device, uint8_t function);
  /** @brief Read from device ID register. */
  uint16_t ReadDeviceId(uint8_t bus, uint8_t device, uint8_t function);
  /** @brief Read from header type register.
   *
   * Structure of header type register:
   * - Bit 7: MF
   *   If MF = 1, this device has multiple functions.
   * - Bit 6 to 0: Header Type
   *   - 0x00: Standard Header
   *   - 0x01: PCI-to-PCI Bridge
   *   - 0x02: Card Bus Bridge
   */
  uint8_t ReadHeaderType(uint8_t bus, uint8_t device, uint8_t function);
  /** @brief Read from class code register. */
  ClassCode ReadClassCode(uint8_t bus, uint8_t device, uint8_t function);

  inline uint16_t ReadVendorId(const Device& dev) {
    return ReadVendorId(dev.bus, dev.device, dev.function);
  }

  /** @brief Read 32-bit register of PCI device. */
  uint32_t ReadConfReg(const Device& dev, uint8_t reg_addr);
  void WriteConfReg(const Device& dev, uint8_t reg_addr, uint32_t value);

  /** @brief Read from bus number register. (For header type 0x01.)
   *
   * - 23:16 : Subordinate bus number
   * - 15:8  : Secondary bus number
   * - 7:0   : Primary bus number
   */
  uint32_t ReadBusNumbers(uint8_t bus, uint8_t device, uint8_t function);

  /** @brief Return true if single function. */
  bool IsSingleFunctionDevice(uint8_t header_type);

  /** @brief List of devices that are found by ScanAllBus(). */
  inline std::array<Device, 32> devices;
  /** @brief Number of valid devices */
  inline int num_device;
  /** @brief Scan all PCI devices and store them into `devices`.
   *
   * Scan PCI devices from bus 0 recursively and write them into `devices`.
   * Write the number of found devices into `num_device`.
   */
  Error ScanAllBus();

  constexpr uint8_t CalcBarAddress(unsigned int bar_index) {
    return 0x10 + 4 * bar_index;
  }

  WithError<uint64_t> ReadBar(Device& device, unsigned int bar_index);
}
