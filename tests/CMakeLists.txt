# Don't run tests when library is used with add_subdirectory
if(PROJECT_SOURCE_DIR STREQUAL CMAKE_SOURCE_DIR)

    include(FetchContent)
    FetchContent_Declare(
      Catch2
      GIT_SHALLOW    TRUE
      GIT_REPOSITORY https://github.com/catchorg/Catch2.git
      GIT_TAG        4e8d92bf02f7d1c8006a0e7a5ecabd8e62d98502 # v3.6.0
    )
    FetchContent_MakeAvailable(Catch2)

    include(FetchContent)
    FetchContent_Declare(
      fmt
      GIT_SHALLOW    TRUE
      GIT_REPOSITORY https://github.com/fmtlib/fmt.git
      GIT_TAG        e69e5f977d458f2650bb346dadf2ad30c5320281 # v10.2.1
    )
    FetchContent_MakeAvailable(fmt)


      add_executable(request_tests "${CMAKE_SOURCE_DIR}/tests/test.cpp")
      target_link_libraries(request_tests PRIVATE cppdash-lib)
      target_include_directories(request_tests PRIVATE src)
      target_compile_definitions(request_tests PRIVATE LIBCPPDASH_BUILD_TESTING)
      target_compile_features(request_tests PUBLIC cxx_std_17)

    target_link_libraries(request_tests PRIVATE Catch2::Catch2WithMain)
endif()
