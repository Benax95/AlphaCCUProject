add_library(adapters_lib blink_adapters.c)

target_include_directories(adapters_lib PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}/include/ports/
)

target_link_libraries(adapters_lib PRIVATE esp32_rv_sdk)