add_library(sm_example STATIC 
    sm_example.c
)

target_include_directories(sm_example PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}/include/ports
)