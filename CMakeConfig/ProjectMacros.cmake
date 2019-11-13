set(CCOSEXAMPLEPROJECT_CMAKECONFIG_DIR ${CMAKE_CURRENT_SOURCE_DIR}/CMakeConfig)

################################################################################
# Setup default installation targets for a project
################################################################################
macro (CcOSExampleProjectSetInstall ProjectName )
  set_property( TARGET ${ProjectName} APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR};${CMAKE_CURRENT_BINARY_DIR}>
              )

  install( TARGETS  ${ProjectName}
           EXPORT  "${ProjectName}Config"
           RUNTIME DESTINATION bin
           LIBRARY DESTINATION lib
           ARCHIVE DESTINATION lib/static
           PUBLIC_HEADER DESTINATION include/${ProjectName}
         )

  # If we are building just CcOS Framework we have to package all headers and configs
  if("${CMAKE_PROJECT_NAME}" STREQUAL "CcOS")
    set_property( TARGET ${ProjectName} APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR};${CMAKE_CURRENT_BINARY_DIR}>
                )
    install(EXPORT "${ProjectName}Config" DESTINATION "lib/${ProjectName}")

    install( DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} DESTINATION include
             FILES_MATCHING PATTERN "*.h"
             PATTERN "*/test" EXCLUDE)
  endif()
endmacro()

################################################################################
# Add Xml Configurations to cmake install
################################################################################
macro (CcOSExampleProjectSetInstallConfig ProjectName )
  install( DIRECTORY    ${CMAKE_CURRENT_SOURCE_DIR}/config/
           DESTINATION  config/${ProjectName}
           PATTERN "*.xml" )
endmacro()

################################################################################
# Set Cmake Version Info to Project
################################################################################
macro (CcSetOSVersion ProjectName )
  set_target_properties(  ${ProjectName}
                          PROPERTIES
                          VERSION ${CCOSEXAMPLEPROJECT_VERSION_CMAKE}
                          SOVERSION ${CCOSEXAMPLEPROJECT_VERSION_CMAKE})
endmacro()

################################################################################
# Setup Include Directorys for importing CcOSExampleProject
################################################################################
macro( CcOSExampleProjectTargetIncludeDirs ProjectName )
  foreach(DIR ${ARGN})
    list(APPEND DIRS ${DIR} )
    target_include_directories(${ProjectName} PUBLIC $<BUILD_INTERFACE:${DIR}> )
  endforeach()
  target_include_directories( ${ProjectName} PUBLIC
                                $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
                                $<INSTALL_INTERFACE:$<INSTALL_PREFIX>/include/${ProjectName}> )
endmacro()

################################################################################
# Generate RC-File for MSVC Builds, output is a Version.h File in current dir
################################################################################
macro( CcOSExampleProjectGenerateRcFileToCurrentDir ProjectName )
  set(PROJECT_NAME "${ProjectName}")
  configure_file( ${CCOSEXAMPLEPROJECT_CMAKECONFIG_DIR}/InputFiles/ProjectVersion.rc.in ${CMAKE_CURRENT_SOURCE_DIR}/CcOSExampleProjectVersion.rc.tmp @ONLY)
  CcMoveFile(${CMAKE_CURRENT_SOURCE_DIR}/CcOSExampleProjectVersion.rc.tmp ${CMAKE_CURRENT_SOURCE_DIR}/CcOSExampleProjectVersion.rc)
  if(${ARGC} GREATER 1)
    if(NOT DEFINED GCC)
      list(APPEND ${ARGV1} "${CMAKE_CURRENT_SOURCE_DIR}/CcOSExampleProjectVersion.rc")
    endif()
  endif(${ARGC} GREATER 1)
endmacro()

################################################################################
# Rename Endings of Project output file to CcOSExampleProject default.
# CURRENTLY NOT IN USE!!
################################################################################
macro( CcOSExampleProjectProjectNaming ProjectName )
  set_target_properties(${ProjectName} PROPERTIES OUTPUT_NAME "${ProjectName}" )
  # Debug becomes and d at the end.
  set_target_properties(${ProjectName} PROPERTIES OUTPUT_NAME_DEBUG "${ProjectName}d" )
endmacro()

################################################################################
# Set Version info for library.
# If Linux, set SOVERSION too.
################################################################################
macro( CcOSExampleProjectLibVersion ProjectName )
  set_target_properties(${ProjectName} PROPERTIES
                                        VERSION ${CCOSEXAMPLEPROJECT_VERSION_CMAKE})
  if(LINUX)
    set_target_properties(${ProjectName} PROPERTIES
                                          SOVERSION ${CCOSEXAMPLEPROJECT_VERSION_CMAKE} )
  endif(LINUX)
endmacro()

################################################################################
# Post config Steps afert add_library:
# Usage CcOSExampleProjectLibSettings( ProjectName [bSetupInstall] [bSetupVersion] [sSetFiltersByFolders])
################################################################################
macro( CcOSExampleProjectLibSettings ProjectName )
  if(${ARGC} GREATER 1)
    if(${ARGV1} STREQUAL "TRUE")
      CcOSExampleProjectSetInstall(${ProjectName})
    endif(${ARGV1} STREQUAL "TRUE")
  endif(${ARGC} GREATER 1)

  if(${ARGC} GREATER 2)
    if(${ARGV2} STREQUAL "TRUE")
      CcOSExampleProjectLibVersion(${ProjectName})
    endif(${ARGV2} STREQUAL "TRUE")
  endif(${ARGC} GREATER 2)

  if(${ARGC} GREATER 3)
    set(FILES ${ARGN})
    list(REMOVE_AT FILES 0)
    list(REMOVE_AT FILES 0)
    list(REMOVE_AT FILES 0)
    CcSetFiltersByFolders(${FILES})
  endif(${ARGC} GREATER 3)
endmacro()

################################################################################
# Post config Steps afert add_executable:
# Usage CcOSExampleProjectExeSettings( ProjectName [sSetFiltersByFolders])
################################################################################
macro( CcOSExampleProjectExeSettings ProjectName )
  if(${ARGC} GREATER 1)
    set(FILES ${ARGN})
    CcSetFiltersByFolders(${FILES})
  endif(${ARGC} GREATER 1)
endmacro()
