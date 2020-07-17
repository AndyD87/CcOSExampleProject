set(CCOS_DIR ${CMAKE_CURRENT_LIST_DIR}/CcOS)  

macro(CcOSLoad)
  if(NOT EXISTS ${CCOS_DIR}/CcOS.cmake)
    execute_process(COMMAND git submodule init "${CCOS_DIR}"
                    WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR})
    execute_process(COMMAND git submodule update "${CCOS_DIR}"
                    WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR})
  endif()

  if(EXISTS ${CCOS_DIR}/CcOS.config.cmake)
    include(${CCOS_DIR}/CcOS.config.cmake)
  endif()
endmacro()

macro(CcOSLoadMacros)
  include(${CCOS_DIR}/CMakeConfig/CcMacros.cmake)
endmacro()

macro(CcOSLoadProjects)
  set(CC_LINK_TYPE                          STATIC  )
  set(CCOS_BUILDLEVEL                       1       )
  set(CCOS_CCKERNEL_ACTIVE                  4       )
  set(CCOS_CCUTIL_CCTESTING_ACTIVE          4       )
  set(CCOS_CCNETWORK_CCREMOTEDEVICE_ACTIVE  4       )
  include(${CCOS_DIR}/CcOS.cmake)
endmacro()

