#pragma once

#include <array>
#include <limits>
#include "error.hpp"

namespace {
  constexpr unsigned long long operator""_KiB(unsigned long long kib) {
    return kib * 1024;
  }

  constexpr unsigned long long operator""_MiB(unsigned long long mib) {
    return mib * 1024_KiB;
  }

  constexpr unsigned long long operator""_GiB(unsigned long long gib) {
    return gib * 1024_MiB;
  }
}

/** @brief Size of one physical memory frame. */
static const auto kBytesPerFrame{4_KiB};

class FrameID {
 public:
  explicit FrameID(size_t id) : id_{id} {}
  size_t ID() const { return id_; }
  void* Frame() const { return reinterpret_cast<void*>(id_ * kBytesPerFrame); }

 private:
  size_t id_;
};

static const FrameID kNullFrame{std::numeric_limits<size_t>::max()};
