#!/bin/bash

x() {
  file=$1
  echo "file: $file"
  eval "diff ./kernel/$file ../mikanos/kernel/$file" \
    | sed 's/^[0-9].*//' | sed 's/^> *\/\/.*//' | sed 's/^< *\/\/.*//' \
    | sed 's/> *//' | sed 's/< *//' | sed 's/^\/\*.*//' | sed 's/^\*.*//' \
    | sed 's/---//' | sed '/^$/d' | sed 's/^/\t/'
}

x asmfunc.h
x console.cpp
x console.hpp
x elf.hpp
x error.hpp
x font.cpp
x font.hpp
x frame_buffer_config.hpp
x frame_buffer.cpp
x frame_buffer.hpp
x graphics.cpp
x graphics.hpp
x interrupt.cpp
x interrupt.hpp
x layer.cpp
x layer.hpp
x libcxx_support.cpp
x logger.cpp
x logger.hpp
x main.cpp
x memory_manager.cpp
x memory_manager.hpp
x memory_map.hpp
x mouse.cpp
x mouse.hpp
x newlib_support.c
x paging.cpp
x paging.hpp
x pci.cpp
x pci.hpp
x queue.hpp
x register.hpp
x segment.cpp
x segment.hpp
x timer.cpp
x timer.hpp
x window.cpp
x window.hpp
x x86_descriptor.hpp
