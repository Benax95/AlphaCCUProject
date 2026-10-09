cmake_minimum_required(VERSION 3.13)

if(MY_ACTIVE_PRESET_NAME STREQUAL "release" OR MY_ACTIVE_PRESET_NAME STREQUAL "debug")

    # Project name 
    project(test_bare_metal LANGUAGES C CXX ASM)
    
    set(TARGET_SOC "esp32c6" CACHE STRING "Target SOC")

    # Define esp32c6 sdk as static library
    add_library(esp32_rv_sdk STATIC ${CMAKE_CURRENT_SOURCE_DIR}/core/startup/${TARGET_SOC}/startup.c)

    target_include_directories(esp32_rv_sdk PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/sdk-config ${CMAKE_CURRENT_SOURCE_DIR}/core/startup/${TARGET_SOC})

    string(TOUPPER ${TARGET_SOC} TARGET_SOC_UPPER)

    target_compile_definitions(esp32_rv_sdk PUBLIC TARGET_SOC_${TARGET_SOC_UPPER})

    add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/core/delay)
    add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/core/esp_common)
    add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/core/esp_hw_support)
    add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/core/esp_rom)
    add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/core/hal)
    add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/core/interrupts)
    add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/core/mtimer)
    add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/core/riscv)    
    add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/core/soc)
    add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/core/syscalls)
    add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/drivers/es8311)
    add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/drivers/gpio_drv)
    add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/drivers/i2c_drv)
    add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/drivers/i2s_drv)
    add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/drivers/sdmmc)
    add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/drivers/sd_spi)
    add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/drivers/spi_drv)
    add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/drivers/uart_drv)
    add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/drivers/usb_serial)
    add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/libraries/ws2812)
    add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/src/adapters)

    add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/src/example)


    target_link_options(esp32_rv_sdk PUBLIC
        "SHELL:-T${CMAKE_CURRENT_SOURCE_DIR}/ld/${TARGET_SOC}/${TARGET_SOC}.ld"
        "SHELL:-T${CMAKE_CURRENT_SOURCE_DIR}/core/soc/${TARGET_SOC}/ld/${TARGET_SOC}.peripherals.ld"
        "SHELL:-T${CMAKE_CURRENT_SOURCE_DIR}/core/esp_rom/${TARGET_SOC}/ld/${TARGET_SOC}.rom.ld"
        "SHELL:-T${CMAKE_CURRENT_SOURCE_DIR}/core/esp_rom/${TARGET_SOC}/ld/${TARGET_SOC}.rom.api.ld"
    )

    set(TARGET_SOC "esp32c6" CACHE STRING "Target SOC")

    include(${CMAKE_CURRENT_SOURCE_DIR}/cmake/sdk-utils.cmake)

    add_executable(esp32c6_bare_metal.elf app/main.c)

    target_link_libraries(esp32c6_bare_metal.elf PRIVATE 
        sm_example
        adapters_lib
    )

    sdk_config(esp32c6_bare_metal.elf)

    add_extra_outputs(esp32c6_bare_metal.elf)

elseif(MY_ACTIVE_PRESET_NAME STREQUAL "test")
    project(test LANGUAGES C CXX)

    # additional warnings
    add_compile_options(-Wall -Wextra -Wpedantic)   

    include(${CMAKE_CURRENT_SOURCE_DIR}/cmake/add-git-submodule.cmake)
    add_git_submodule(Unity)
    add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/src/example)
    add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/test)
endif()

