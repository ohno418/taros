#include "memory_manager.hpp"

// TODO: allocate and free

void BitmapMemoryManager::MarkAllocated(FrameID start_frame, size_t num_frames) {
  for (size_t i = 0; i < num_frames; ++i) {
    SetBit(FrameID{start_frame.ID() + i}, true);
  }
}

void BitmapMemoryManager::SetMemoryRange(FrameID range_begin, FrameID range_end) {
  range_begin_ = range_begin;
  range_end_ = range_end;
}

bool BitmapMemoryManager::GetBit(FrameID frame) const {
  auto line_index = frame.ID() / kBitsPerMapLine;
  auto bit_index = frame.ID() % kBitsPerMapLine;

  return (alloc_map_[line_index] & (static_cast<MapLineType>(1) << bit_index)) != 0;
}

void BitmapMemoryManager::SetBit(FrameID frame, bool allocated) {
  auto line_index = frame.ID() / kBitsPerMapLine;
  auto bit_index = frame.ID() % kBitsPerMapLine;

  if (allocated) {
    alloc_map_[line_index]  |= (static_cast<MapLineType>(1) << bit_index);
  } else {
    alloc_map_[line_index]  &= ~(static_cast<MapLineType>(1) << bit_index);
  }
}
