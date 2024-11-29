# included further down to avoid interfering with our cache variables
# include(GNUInstallDirs)

# Sometimes it's useful to be able to single out a dependency to be built as
# static or shared, even if obtained from source
if(PROJECT_IS_TOP_LEVEL)
  option(BUILD_SHARED_LIBS "Build shared libs" OFF)
endif()
option(
  LIBCPPDASH_BUILD_SHARED
  "Override BUILD_SHARED_LIBS for ${package_name} library"
  ${BUILD_SHARED_LIBS}
)
mark_as_advanced(LIBCPPDASH_BUILD_SHARED)
set(build_type STATIC)
if(LIBCPPDASH_BUILD_SHARED)
  set(build_type SHARED)
endif()

# target_include_directories with SYSTEM modifier will request the compiler to
# omit warnings from the provided paths, if the compiler supports that.
# This is to provide a user experience similar to find_package when
# add_subdirectory or FetchContent is used to consume this project.
set(warning_guard)
if(NOT PROJECT_IS_TOP_LEVEL)
  option(
    LIBCPPDASH_INCLUDES_WITH_SYSTEM
    "Use SYSTEM modifier for ${package_name}'s includes, disabling warnings"
    ON
  )
  mark_as_advanced(LIBCPPDASH_INCLUDES_WITH_SYSTEM)
  if(LIBCPPDASH_INCLUDES_WITH_SYSTEM)
    set(warning_guard SYSTEM)
  endif()
endif()

# By default tests aren't enabled even with BUILD_TESTING=ON unless the library
# is built as a top level project.
# This is in order to cut down on unnecessary compile times, since it's unlikely
# for users to want to run the tests of their dependencies.
if(PROJECT_IS_TOP_LEVEL)
  option(BUILD_TESTING "Build tests" OFF)
  option(LIBCPPDASH_SANITIZER_BUILD "Build with sanitizers" OFF)
endif()
if(PROJECT_IS_TOP_LEVEL AND BUILD_TESTING)
  set(build_testing ON)
endif()
option(
  LIBCPPDASH_BUILD_TESTING
  "Override BUILD_TESTING for ${package_name} library"
  ${build_testing}
)
set(build_testing)
mark_as_advanced(LIBCPPDASH_BUILD_TESTING)


# -- internal --

set(LIBCPPDASH_DESIRED_CXX_STANDARD cxx_std_20 CACHE STRING "")
option(LIBCPPDASH_USE_CI_WRAPPER "" OFF)
mark_as_advanced(
  LIBCPPDASH_DESIRED_CXX_STANDARD
  LIBCPPDASH_USE_CI_WRAPPER
)
