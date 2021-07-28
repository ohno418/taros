#!/bin/bash

diffx () {
  file=$1
  echo "file: $file"
  eval "diff ./kernel/$file ../mikanos/kernel/$file" \
    | sed 's/^[0-9].*//' | sed 's/^> *\/\/.*//' | sed 's/^< *\/\/.*//' \
    | sed 's/^> *//' | sed 's/^< *//' | sed 's/^\/\*.*//' | sed 's/^\*.*//' \
    | sed 's/---//' | sed '/^$/d' | sed 's/^/\t/'
}

diffx asmfunc.asm
diffx asmfunc.h
diffx console.cpp
diffx console.hpp
diffx elf.hpp
diffx error.hpp
diffx font.cpp
diffx font.hpp
diffx frame_buffer_config.hpp
diffx frame_buffer.cpp
diffx frame_buffer.hpp
diffx graphics.cpp
diffx graphics.hpp
diffx interrupt.cpp
diffx interrupt.hpp
diffx layer.cpp
diffx layer.hpp
diffx libcxx_support.cpp
diffx logger.cpp
diffx logger.hpp
diffx main.cpp
diffx memory_manager.cpp
diffx memory_manager.hpp
diffx memory_map.hpp
diffx message.hpp
diffx mouse.cpp
diffx mouse.hpp
diffx newlib_support.c
diffx paging.cpp
diffx paging.hpp
diffx pci.cpp
diffx pci.hpp
diffx register.hpp
diffx segment.cpp
diffx segment.hpp
diffx timer.cpp
diffx timer.hpp
diffx window.cpp
diffx window.hpp
diffx x86_descriptor.hpp
