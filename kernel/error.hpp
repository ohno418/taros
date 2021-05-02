#pragma once

#include <array>

class Error {
 public:
  enum Code {
    kSuccess,
    kFull,
    kEmpty,
    kIndexOutOfRange,
    kLastOfCode, // Put this last.
  };

  Error(Code code) : code_{code} {}

  operator bool() const {
    return this->code_ != kSuccess;
  }

  const char* Name() const {
    return code_name_[static_cast<int>(this->code_)];
  }

 private:
  static constexpr std::array<const char*, 4> code_name_ = {
    "kSuccess",
    "kFull",
    "kEmpty",
    "kIndexOutOfRange",
  };

  Code code_;
};

template <class T>
struct WithError {
  T value;
  Error error;
};
