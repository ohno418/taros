#include <new>
#include <cerrno>

int printk(const char* format, ...);

extern "C" int posix_memalign(void**, size_t, size_t) {
  return ENOMEM;
}
