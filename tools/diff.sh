#!/bin/bash

diffx () {
  file=$1
  echo "file: $file"
  eval "diff ./kernel/$file ../mikanos/kernel/$file" \
    | sed 's/^[0-9].*//' | sed 's/^> *\/\/.*//' | sed 's/^< *\/\/.*//' \
    | sed 's/^> *//' | sed 's/^< *//' | sed 's/^\/\*.*//' | sed 's/^\*.*//' \
    | sed 's/---//' | sed '/^$/d' | sed 's/^/\t/'
}

diffx acpi.cpp
diffx acpi.hpp
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
diffx keyboard.cpp
diffx keyboard.hpp
diffx layer.cpp
diffx layer.hpp
# diffx libcxx_support.cpp
diffx logger.cpp
diffx logger.hpp
diffx main.cpp
diffx memory_manager.cpp
diffx memory_manager.hpp
diffx memory_map.hpp
diffx message.hpp
diffx mouse.cpp
diffx mouse.hpp
# diffx newlib_support.c
diffx paging.cpp
diffx paging.hpp
diffx pci.cpp
diffx pci.hpp
diffx register.hpp
diffx segment.cpp
diffx segment.hpp
diffx task.cpp
diffx task.hpp
diffx terminal.cpp
diffx terminal.hpp
diffx timer.cpp
diffx timer.hpp
diffx window.cpp
diffx window.hpp
diffx x86_descriptor.hpp

diffx usb/arraymap.hpp
diffx usb/descriptor.hpp
diffx usb/device.cpp
diffx usb/device.hpp
diffx usb/endpoint.hpp
diffx usb/memory.cpp
diffx usb/memory.hpp
diffx usb/setupdata.hpp
diffx usb/classdriver/base.cpp
diffx usb/classdriver/base.hpp
diffx usb/classdriver/hid.cpp
diffx usb/classdriver/hid.hpp
diffx usb/classdriver/keyboard.cpp
diffx usb/classdriver/keyboard.hpp
diffx usb/classdriver/mouse.cpp
diffx usb/classdriver/mouse.hpp
diffx usb/xhci/context.hpp
diffx usb/xhci/device.cpp
diffx usb/xhci/device.hpp
diffx usb/xhci/devmgr.cpp
diffx usb/xhci/devmgr.hpp
diffx usb/xhci/port.cpp
diffx usb/xhci/port.hpp
diffx usb/xhci/registers.cpp
diffx usb/xhci/registers.hpp
diffx usb/xhci/ring.cpp
diffx usb/xhci/ring.hpp
diffx usb/xhci/speed.hpp
diffx usb/xhci/trb.cpp
diffx usb/xhci/trb.hpp
diffx usb/xhci/xhci.cpp
diffx usb/xhci/xhci.hpp
