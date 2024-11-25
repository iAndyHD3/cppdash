cmake_minimum_required(VERSION 3.14)

project(cppdashTests LANGUAGES CXX)

include(../cmake/project-is-top-level.cmake)
include(../cmake/folders.cmake)

# ---- Dependencies ----

if(PROJECT_IS_TOP_LEVEL)
  find_package(cppdash REQUIRED)
  enable_testing()
endif()

# ---- Tests ----

add_executable(cppdash_test source/cppdash_test.cpp)
target_link_libraries(cppdash_test PRIVATE cppdash::cppdash)
target_compile_features(cppdash_test PRIVATE cxx_std_20)

add_test(NAME cppdash_test COMMAND cppdash_test)

# ---- End-of-file commands ----

add_folders(Test)
