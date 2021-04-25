#pragma once

#include <cstdint>
#include <array>
#include "error.hpp"

namespace pci {
  /** @brief IO port address of CONFIG_ADDRESS register. */
  const uint16_t kConfigAddress = 0x0cf8;
  /** @brief IO port address of CONFIG_DATA register. */
  const uint16_t kConfigData = 0x0cfc;

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
  /** @brief Read from class code register.
   *
   * Structure of 32-bit integer:
   *   - 31:24 : Base class
   *   - 23:16 : Sub class
   *   - 15:8  : Programming interface
   *   - 7:0   : Revision ID
   */
  uint32_t ReadClassCode(uint8_t bus, uint8_t device, uint8_t function);

  /** @brief Read from bus number register. (For header type 0x01.)
   *
   * - 23:16 : Subordinate bus number
   * - 15:8  : Secondary bus number
   * - 7:0   : Primary bus number
   */
  uint32_t ReadBusNumbers(uint8_t bus, uint8_t device, uint8_t function);

  /** @brief Return true if single function. */
  bool IsSingleFunctionDevice(uint8_t header_type);

  struct Device {
    uint8_t bus, device, function, header_type;
  };

  /** @brief List of devices that are found by ScanAllBus(). */
  extern std::array<Device, 32> devices;
  /** @brief Number of valid devices */
  extern int num_device;
  /** @brief Scan all PCI devices and store them into `devices`.
   *
   * Scan PCI devices from bus 0 recursively and write them into `devices`.
   * Write the number of found devices into `num_device`.
   */
  Error ScanAllBus();
}
