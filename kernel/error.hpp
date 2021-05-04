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

 private:
  static constexpr std::array<const char*, 4> code_names_ = {
    "kSuccess",
    "kFull",
    "kEmpty",
    "kIndexOutOfRange",
  };

 public:
  Error(Code code, const char* file, int line) : code_{code}, line_{line}, file_{file} {}

  Code Cause() const {
    return this->code_;
  }

  operator bool() const {
    return this->code_ != kSuccess;
  }

  const char* Name() const {
    return code_names_[static_cast<int>(this->code_)];
  }

  const char* File() const {
    return this->file_;
  }

  int Line() const {
    return this->line_;
  }

 private:
  Code code_;
  int line_;
  const char* file_;
};

#define MAKE_ERROR(code) Error((code), __FILE__, __LINE__)

template <class T>
struct WithError {
  T value;
  Error error;
};
