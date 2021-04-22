#pragma once

#include <cstdint>

namespace pci {
  /** @brief IO port address of CONFIG_ADDRESS register */
  const uint16_t kConfigAddress = 0x0cf8;
  /** @brief IO port address of CONFIG_DATA register */
  const uint16_t kConfigData = 0x0cfc;
}
