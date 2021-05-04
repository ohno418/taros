#include <new>
#include <cerrno>

char* buf;
void* operator new(unsigned long size) {
  return buf;
}

void operator delete(void* buf, std::align_val_t val) {
}

void operator delete(void* obj) noexcept {
}

std::new_handler std::get_new_handler() noexcept {
  return nullptr;
}

extern "C" int posix_memalign(void**, size_t, size_t) {
  return ENOMEM;
}
