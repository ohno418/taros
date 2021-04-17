#include <cstdint>
#include <cstddef>

#include "frame_buffer_config.hpp"
#include "graphics.hpp"
#include "font.hpp"

void* operator new(size_t size, void* buf) {
  return buf;
}

void operator delete(void* obj, size_t size) noexcept {
}

char pixel_writer_buf[sizeof(RGBResv8BitPerColorPixelWriter)];
PixelWriter* pixel_writer;

extern "C" void KernelMain(const FrameBufferConfig& frame_buffer_config) {
  switch (frame_buffer_config.pixel_format) {
    case kPixelRGBResv8BitPerColor:
      pixel_writer = new(pixel_writer_buf)
        RGBResv8BitPerColorPixelWriter{frame_buffer_config};
      break;
    case kPixelBGRResv8BitPerColor:
      pixel_writer = new(pixel_writer_buf)
        BGRResv8BitPerColorPixelWriter{frame_buffer_config};
      break;
  }

  for (int x = 0; x < frame_buffer_config.horizontal_resolution; ++x) {
    for (int y = 0; y < frame_buffer_config.vertical_resolution; ++y) {
      pixel_writer->Write(x, y, {255, 255, 255});
    }
  }
  for (int x = 0; x < 200; ++x) {
    for (int y = 0; y < 115; ++y) {
      pixel_writer->Write(x, y, {255, 165, 0});
    }
  }

  WriteAscii(*pixel_writer, 50, 50,  'H', {0, 0, 0});
  WriteAscii(*pixel_writer, 58, 50,  'e', {0, 0, 0});
  WriteAscii(*pixel_writer, 66, 50,  'l', {0, 0, 0});
  WriteAscii(*pixel_writer, 74, 50,  'l', {0, 0, 0});
  WriteAscii(*pixel_writer, 82, 50,  'o', {0, 0, 0});
  WriteAscii(*pixel_writer, 90, 50,  ',', {0, 0, 0});
  WriteAscii(*pixel_writer, 98, 50, ' ', {0, 0, 0});
  WriteAscii(*pixel_writer, 106, 50, 'T', {0, 0, 0});
  WriteAscii(*pixel_writer, 114, 50, 'a', {0, 0, 0});
  WriteAscii(*pixel_writer, 122, 50, 'r', {0, 0, 0});
  WriteAscii(*pixel_writer, 130, 50, 'O', {0, 0, 0});
  WriteAscii(*pixel_writer, 138, 50, 'S', {0, 0, 0});
  WriteAscii(*pixel_writer, 146, 50, '!', {0, 0, 0});

  while (1) __asm__("hlt");
}
