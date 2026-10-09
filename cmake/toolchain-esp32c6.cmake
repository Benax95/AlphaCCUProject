    set(CMAKE_SYSTEM_NAME Generic)
    set(CMAKE_SYSTEM_PROCESSOR riscv32)

    # Prevent CMake's compiler checks from trying to link a host executable with
    # Darwin-specific flags when probing this cross toolchain on macOS.
    set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

    #specity the C and C++ standards
    set(CMAKE_C_STANDARD 11)
    set(CMAKE_CXX_STANDARD 17)

    list(APPEND CMAKE_TRY_COMPILE_PLATFORM_VARIABLES RISCV32_TOOLCHAIN_BIN)

    find_program(RISCV32_ESP_ELF_GCC riscv32-esp-elf-gcc REQUIRED HINTS ${RISCV32_TOOLCHAIN_BIN})
    find_program(RISCV32_ESP_ELF_GXX riscv32-esp-elf-g++ REQUIRED HINTS ${RISCV32_TOOLCHAIN_BIN})
    find_program(RISCV32_ESP_ELF_CPP riscv32-esp-elf-cpp REQUIRED HINTS ${RISCV32_TOOLCHAIN_BIN})
    find_program(RISCV32_ESP_ELF_LD riscv32-esp-elf-ld REQUIRED HINTS ${RISCV32_TOOLCHAIN_BIN})
    find_program(RISCV32_ESP_ELF_OBJCOPY riscv32-esp-elf-objcopy REQUIRED HINTS ${RISCV32_TOOLCHAIN_BIN})
    find_program(RISCV32_ESP_ELF_OBJDUMP riscv32-esp-elf-objdump REQUIRED HINTS ${RISCV32_TOOLCHAIN_BIN})
    find_program(RISCV32_ESP_ELF_SIZE riscv32-esp-elf-size REQUIRED HINTS ${RISCV32_TOOLCHAIN_BIN})

    # Specify the cross-compiler
    set(CMAKE_C_COMPILER ${RISCV32_ESP_ELF_GCC})
    set(CMAKE_CXX_COMPILER ${RISCV32_ESP_ELF_GXX})
    set(CMAKE_ASM_COMPILER ${RISCV32_ESP_ELF_GCC})
    set(CMAKE_CPP ${RISCV32_ESP_ELF_CPP})
    # Specify the linker
    set(CMAKE_LINKER ${RISCV32_ESP_ELF_LD})

    # Define flags
    if(MY_ACTIVE_PRESET_NAME STREQUAL "debug")
        set(CMAKE_C_FLAGS "-march=rv32imac_zicsr_zifencei -mabi=ilp32 -nostartfiles  -Wno-unused-variable -Wno-unused-parameter -fdata-sections -ffunction-sections -fno-strict-aliasing  -fshort-enums -fno-builtin -Og")
    else()
        set(CMAKE_C_FLAGS "-march=rv32imac_zicsr_zifencei -mabi=ilp32 -nostartfiles  -Wno-unused-variable -Wno-unused-parameter -fdata-sections -ffunction-sections -fno-strict-aliasing  -fshort-enums -fno-builtin -O2")
    endif()

    set(CMAKE_ASM_FLAGS "${CMAKE_C_FLAGS} -x assembler-with-cpp")

    add_link_options("SHELL:-Wl,--gc-sections -u _printf_float --specs=nano.specs --specs=nosys.specs")

    # Optional: Set objcopy and size utilities
    set(CMAKE_OBJCOPY ${RISCV32_ESP_ELF_OBJCOPY})
    set(CMAKE_OBJDUMP ${RISCV32_ESP_ELF_OBJDUMP})
    set(CMAKE_SIZE ${RISCV32_ESP_ELF_SIZE})
