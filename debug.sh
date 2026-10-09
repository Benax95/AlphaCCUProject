#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BUILD_DIR="${BUILD_DIR:-build}"
FLASH_OFFSET="${FLASH_OFFSET:-0x0}"
ELF_PATH="${1:-${SCRIPT_DIR}/${BUILD_DIR}/debug/esp32c6_bare_metal.elf}"

openocd -f board/esp32c6-builtin.cfg

riscv32-esp-elf-gdb -ex "target remote :3333" "${ELF_PATH}"
