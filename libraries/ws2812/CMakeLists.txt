add_library(ws2812_lib STATIC ws2812.c)
target_include_directories(ws2812_lib PUBLIC ${CMAKE_CURRENT_LIST_DIR})

target_link_libraries(ws2812_lib PRIVATE esp32_rv_sdk)