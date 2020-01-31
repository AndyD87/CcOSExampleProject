################################################################################
# @Author Andreas Dirmeier
# @brief Main CMakeList.txt for CcOSExampleProject
################################################################################
cmake_minimum_required (VERSION 3.0)


# Enable to check memory usage and leakings
#set(MEMORYMONITOR_ENABLED      TRUE)
#set(MEMORYMONITOR_CHECK_KERNEL TRUE)
if($ENV{TEST_CCOS})
  set(MEMORYMONITOR_ENABLED      TRUE)
  set(MEMORYMONITOR_CHECK_KERNEL TRUE)
endif()


# Set Debug build if not BUILD_TYPE selected
#if(NOT CMAKE_BUILD_TYPE)
#  set(CMAKE_BUILD_TYPE Debug)
#endif()

# Enable verbose output if required
#set(CMAKE_VERBOSE_MAKEFILE TRUE CACHE INTERNAL "")

message("-- Default build type: ${CMAKE_BUILD_TYPE}")

################################################################################
# Setup Globals
################################################################################
include( ${CMAKE_CURRENT_SOURCE_DIR}/VERSION.cmake )
include( ${CMAKE_CURRENT_SOURCE_DIR}/CMakeConfig/ProjectMacros.cmake )
include( ${CMAKE_CURRENT_SOURCE_DIR}/CcOSImport.cmake )

if(WINDOWS)
  set(CMAKE_INSTALL_PREFIX "C:/Program Files/CcOSExampleProject")
endif()

################################################################################
# Setup Cache directory if not yet defined
################################################################################
if(NOT DEFINED CC_CACHE_DIR)
  # Check for global Cache dir
  if(EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/../Cache)
    set( CC_CACHE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/../Cache)
  else()
    # Check for local Cache dir
    set( CC_CACHE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Cache)
    if(NOT EXISTS ${CC_CACHE_DIR})
      file(MAKE_DIRECTORY ${CC_CACHE_DIR})
    endif()
  endif()
endif()

################################################################################
# Load CcOS
################################################################################
CcOSLoad()
CcOSLoadMacros()

################################################################################
# Configuration is done, setup Project
################################################################################
if(NOT CC_NO_PROJECT)
  project("CcOSExampleProject" VERSION "${CCOSEXAMPLEPROJECT_VERSION_CMAKE}")
endif()

################################################################################
# Setup Debug
################################################################################
if(CMAKE_BUILD_TYPE MATCHES "[Dd][Ee][Bb][Uu][Gg]")
  message("- Build-Type set to Debug")
  set(CCOSEXAMPLEPROJECT_BUILD_TYPE "DEBUG" )
  set(CMAKE_VERBOSE_MAKEFILE          ON)
else()
  message("- Build-Type set to Release")
  set(CCOSEXAMPLEPROJECT_BUILD_TYPE "RELEASE" )
endif()

################################################################################
# Setup Output Paths
################################################################################
# To be able to overwrite global output root use -DCC_OUTPUT_DIR=/path on configuration
if(NOT CC_OUTPUT_DIR)
  set(CC_OUTPUT_DIR "${CMAKE_CURRENT_SOURCE_DIR}/Output")
endif()

################################################################################
# Setup Default Values for CMAKE
################################################################################
CcNoConfigurationDirs()
enable_testing()
set_property(GLOBAL PROPERTY USE_FOLDERS ON)

################################################################################
# Import CcOS
################################################################################
CcOSLoadProjects()

################################################################################
# Setup CcOSExampleProject Projects
################################################################################
add_subdirectory(CcOSExampleProject)

################################################################################
# Update dokumentation
################################################################################
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/Documents/Doxygen)


set(CPACK_PACKAGE_DESCRIPTION         ${CMAKE_PROJECT})
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "CcOSExampleProject Project")
set(CPACK_PACKAGE_VENDOR              "Andreas Dirmeier")
set(CPACK_PACKAGE_CONTACT             "coolcow_ccos@yahoo.com")
set(CPACK_PACKAGE_VERSION             ${PROJECT_VERSION})
set(CPACK_PACKAGE_INSTALL_DIRECTORY   ${CMAKE_PROJECT_NAME})
set(CPACK_RESOURCE_FILE_LICENSE       ${CMAKE_CURRENT_SOURCE_DIR}/Documents/COPYING.LESSER.rtf)

if(LINUX)
  set(CPACK_GENERATOR "DEB")
  set(CPACK_DEBIAN_PACKAGE_MAINTAINER ${CPACK_PACKAGE_VENDOR})

  include(CPack)
elseif(WINDOWS)
  CcLoadWixTools()
  set(CPACK_GENERATOR                 "WIX")
  set(CPACK_WIX_UPGRADE_GUID          "750BDD2D-8242-443A-8921-0953FA67A053")
  include(CPack)
endif()
