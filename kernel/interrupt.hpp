#pragma once

#include <array>
#include <cstdint>

enum class DescriptorType {
  kUpper8Bytes   = 0,
  kLDT           = 2,
  kTSSAvailable  = 9,
  kTSSBusy       = 11,
  kCallGate      = 12,
  kInterruptGate = 14,
  kTrapGate      = 15,
};

union InterruptDescriptorAttribute {
  uint16_t data;
  struct {
    uint16_t interrupt_stack_table : 3;
    uint16_t : 5;
    /**  Interrupt Descriptor Type
     * - 14 : Interrupt Gate (for normal interrupts)
     * - 15 : Trap Gate
     */
    DescriptorType type : 4;
    uint16_t : 1;
    /** DPL
     * Set 0 for almost all cases.
     */
    uint16_t descriptor_privilege_level : 2;
    /** A flag that determines whether a descriptor is enabled or not. */
    uint16_t present : 1;
  } __attribute__((packed)) bits;
} __attribute__((packed));

struct InterruptDescriptor {
  uint16_t offset_low;
  uint16_t segment_selector;
  InterruptDescriptorAttribute attr;
  uint16_t offset_middle;
  uint32_t offset_high;
  uint32_t reserved;
} __attribute__((packed));

void NotifyEndOfInterrupt();
