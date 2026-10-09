add_executable(test_sm_example 
    test_sm_example.c
    test_adapters/error_mock.c
)

target_link_libraries(test_sm_example 
    unity
    sm_example
)

target_include_directories(test_sm_example PUBLIC 
    ${CMAKE_CURRENT_SOURCE_DIR}/test_adapters/
    ${CMAKE_SOURCE_DIR}/include/ports/
)

add_test(NAME sm_example_tests COMMAND test_sm_example)