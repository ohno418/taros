#!/bin/bash

diffx () {
  file=$1
  echo "file: $file"
  eval "diff ./$file ../mikanos/$file" \
    | sed 's/^[0-9].*//' | sed 's/^> *\/\/.*//' | sed 's/^< *\/\/.*//' \
    | sed 's/^> *//' | sed 's/^< *//' | sed 's/^\/\*.*//' | sed 's/^\*.*//' \
    | sed 's/---//' | sed '/^$/d' | sed 's/^/\t/'
}

diffx MikanLoaderPkg/elf.hpp
diffx MikanLoaderPkg/Loader.inf
diffx MikanLoaderPkg/Main.c
diffx MikanLoaderPkg/MikanLoaderPkg.dec
diffx MikanLoaderPkg/MikanLoaderPkg.dsc

diffx kernel/acpi.cpp
diffx kernel/acpi.hpp
diffx kernel/asmfunc.asm
diffx kernel/asmfunc.h
diffx kernel/console.cpp
diffx kernel/console.hpp
diffx kernel/elf.hpp
diffx kernel/error.hpp
diffx kernel/font.cpp
diffx kernel/font.hpp
diffx kernel/frame_buffer_config.hpp
diffx kernel/frame_buffer.cpp
diffx kernel/frame_buffer.hpp
diffx kernel/graphics.cpp
diffx kernel/graphics.hpp
diffx kernel/interrupt.cpp
diffx kernel/interrupt.hpp
diffx kernel/keyboard.hpp
diffx kernel/keyboard.cpp
diffx kernel/layer.cpp
diffx kernel/layer.hpp
# diffx kernel/libcxx_support.cpp
diffx kernel/logger.cpp
diffx kernel/logger.hpp
diffx kernel/main.cpp
diffx kernel/memory_manager.cpp
diffx kernel/memory_manager.hpp
diffx kernel/memory_map.hpp
diffx kernel/message.hpp
diffx kernel/mouse.cpp
diffx kernel/mouse.hpp
# diffx kernel/newlib_support.c
diffx kernel/paging.cpp
diffx kernel/paging.hpp
diffx kernel/pci.cpp
diffx kernel/pci.hpp
diffx kernel/register.hpp
diffx kernel/segment.cpp
diffx kernel/segment.hpp
diffx kernel/timer.cpp
diffx kernel/timer.hpp
diffx kernel/window.cpp
diffx kernel/window.hpp
diffx kernel/x86_descriptor.hpp

diffx kernel/usb/arraymap.hpp
diffx kernel/usb/descriptor.hpp
diffx kernel/usb/device.cpp
diffx kernel/usb/device.hpp
diffx kernel/usb/endpoint.hpp
diffx kernel/usb/memory.cpp
diffx kernel/usb/memory.hpp
diffx kernel/usb/setupdata.hpp
diffx kernel/usb/classdriver/base.cpp
diffx kernel/usb/classdriver/base.hpp
diffx kernel/usb/classdriver/hid.cpp
diffx kernel/usb/classdriver/hid.hpp
diffx kernel/usb/classdriver/keyboard.cpp
diffx kernel/usb/classdriver/keyboard.hpp
diffx kernel/usb/classdriver/mouse.cpp
diffx kernel/usb/classdriver/mouse.hpp
diffx kernel/usb/xhci/context.hpp
diffx kernel/usb/xhci/device.cpp
diffx kernel/usb/xhci/device.hpp
diffx kernel/usb/xhci/devmgr.cpp
diffx kernel/usb/xhci/devmgr.hpp
diffx kernel/usb/xhci/port.cpp
diffx kernel/usb/xhci/port.hpp
diffx kernel/usb/xhci/registers.cpp
diffx kernel/usb/xhci/registers.hpp
diffx kernel/usb/xhci/ring.cpp
diffx kernel/usb/xhci/ring.hpp
diffx kernel/usb/xhci/speed.hpp
diffx kernel/usb/xhci/trb.cpp
diffx kernel/usb/xhci/trb.hpp
diffx kernel/usb/xhci/xhci.cpp
diffx kernel/usb/xhci/xhci.hpp
