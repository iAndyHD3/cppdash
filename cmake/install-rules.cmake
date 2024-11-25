if(PROJECT_IS_TOP_LEVEL)
  set(
      CMAKE_INSTALL_INCLUDEDIR "include/cppdash-${PROJECT_VERSION}"
      CACHE STRING ""
  )
  set_property(CACHE CMAKE_INSTALL_INCLUDEDIR PROPERTY TYPE PATH)
endif()

include(CMakePackageConfigHelpers)
include(GNUInstallDirs)

# find_package(<package>) call for consumers to find this project
set(package cppdash)

install(
    DIRECTORY
    include/
    "${PROJECT_BINARY_DIR}/export/"
    DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
    COMPONENT cppdash_Development
)

install(
    TARGETS cppdash_cppdash
    EXPORT cppdashTargets
    RUNTIME #
    COMPONENT cppdash_Runtime
    LIBRARY #
    COMPONENT cppdash_Runtime
    NAMELINK_COMPONENT cppdash_Development
    ARCHIVE #
    COMPONENT cppdash_Development
    INCLUDES #
    DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
)

write_basic_package_version_file(
    "${package}ConfigVersion.cmake"
    COMPATIBILITY SameMajorVersion
)

# Allow package maintainers to freely override the path for the configs
set(
    cppdash_INSTALL_CMAKEDIR "${CMAKE_INSTALL_LIBDIR}/cmake/${package}"
    CACHE STRING "CMake package config location relative to the install prefix"
)
set_property(CACHE cppdash_INSTALL_CMAKEDIR PROPERTY TYPE PATH)
mark_as_advanced(cppdash_INSTALL_CMAKEDIR)

install(
    FILES cmake/install-config.cmake
    DESTINATION "${cppdash_INSTALL_CMAKEDIR}"
    RENAME "${package}Config.cmake"
    COMPONENT cppdash_Development
)

install(
    FILES "${PROJECT_BINARY_DIR}/${package}ConfigVersion.cmake"
    DESTINATION "${cppdash_INSTALL_CMAKEDIR}"
    COMPONENT cppdash_Development
)

install(
    EXPORT cppdashTargets
    NAMESPACE cppdash::
    DESTINATION "${cppdash_INSTALL_CMAKEDIR}"
    COMPONENT cppdash_Development
)

if(PROJECT_IS_TOP_LEVEL)
  include(CPack)
endif()
