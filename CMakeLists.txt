cmake_minimum_required(VERSION 3.14)

include(cmake/prelude.cmake)

project(
    cppdash
    VERSION 0.1.0
    DESCRIPTION "Short description"
    HOMEPAGE_URL "https://example.com/"
    LANGUAGES CXX
)

include(cmake/project-is-top-level.cmake)
include(cmake/variables.cmake)

# ---- Declare library ----

add_library(
    cppdash_cppdash
    source/cppdash.cpp
)
add_library(cppdash::cppdash ALIAS cppdash_cppdash)

include(GenerateExportHeader)
generate_export_header(
    cppdash_cppdash
    BASE_NAME cppdash
    EXPORT_FILE_NAME export/cppdash/cppdash_export.hpp
    CUSTOM_CONTENT_FROM_VARIABLE pragma_suppress_c4251
)

if(NOT BUILD_SHARED_LIBS)
  target_compile_definitions(cppdash_cppdash PUBLIC CPPDASH_STATIC_DEFINE)
endif()

set_target_properties(
    cppdash_cppdash PROPERTIES
    CXX_VISIBILITY_PRESET hidden
    VISIBILITY_INLINES_HIDDEN YES
    VERSION "${PROJECT_VERSION}"
    SOVERSION "${PROJECT_VERSION_MAJOR}"
    EXPORT_NAME cppdash
    OUTPUT_NAME cppdash
)

target_include_directories(
    cppdash_cppdash ${warning_guard}
    PUBLIC
    "\$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>"
)

target_include_directories(
    cppdash_cppdash SYSTEM
    PUBLIC
    "\$<BUILD_INTERFACE:${PROJECT_BINARY_DIR}/export>"
)

target_compile_features(cppdash_cppdash PUBLIC cxx_std_20)

# ---- Install rules ----

if(NOT CMAKE_SKIP_INSTALL_RULES)
  include(cmake/install-rules.cmake)
endif()

# ---- Examples ----

if(PROJECT_IS_TOP_LEVEL)
  option(BUILD_EXAMPLES "Build examples tree." "${cppdash_DEVELOPER_MODE}")
  if(BUILD_EXAMPLES)
    add_subdirectory(example)
  endif()
endif()

# ---- Developer mode ----

if(NOT cppdash_DEVELOPER_MODE)
  return()
elseif(NOT PROJECT_IS_TOP_LEVEL)
  message(
      AUTHOR_WARNING
      "Developer mode is intended for developers of cppdash"
  )
endif()

include(cmake/dev-mode.cmake)
