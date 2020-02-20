 
set ( CURRENT_PROJECT           "CcOSExampleProject" )
set ( CURRENT_PROJECT_IDE_PATH  "" )
  
#############################################################################
# Add source Files
#############################################################################
file (GLOB SOURCE_FILES
      "*.c"
      "*.cpp"
      "*.h")

include_directories( ${CMAKE_CURRENT_SOURCE_DIR} )
  
if(WINDOWS)
  CcOSExampleProjectGenerateRcFileToCurrentDir(${CURRENT_PROJECT} SOURCE_FILES )
endif()
  
#############################################################################
# Add resources to this project
#############################################################################
find_program(CcOSResource_FOUND CcOSResource)
set(CURRENT_PROJECT_RESOURCE_FILES
    ${CMAKE_CURRENT_LIST_DIR}/Resources/CcOSExampleProject.json
    ${CMAKE_CURRENT_LIST_DIR}/Resources/CcOSExampleProject.json.c
    ${CMAKE_CURRENT_LIST_DIR}/Resources/CcOSExampleProject.json.h)
   
if(CcOSResource_FOUND)
    CcAddResourceString(${CMAKE_CURRENT_LIST_DIR}/Resources CcOSExampleProject.json CcOSExampleProject_Json CURRENT_PROJECT_RESOURCE_FILES)

    add_custom_target("${CURRENT_PROJECT}_Resources" DEPENDS  ${CURRENT_PROJECT_RESOURCE_FILES})
    set_target_properties("${CURRENT_PROJECT}_Resources" PROPERTIES FOLDER "Resources/${CURRENT_PROJECT_IDE_PATH}")                             
    source_group( "Resources" FILES ${CURRENT_PROJECT_RESOURCE_FILES})
endif()

#############################################################################
# Setup project
#############################################################################
#add_library( ${CURRENT_PROJECT} ${CC_LINK_TYPE} ${SOURCE_FILES} ${CURRENT_PROJECT_RESOURCE_FILES})
CcAddExecutable( ${CURRENT_PROJECT} ${SOURCE_FILES} ${CURRENT_PROJECT_RESOURCE_FILES})
  
#############################################################################
# Setup project dependencies
#############################################################################
if(CcOSResource_FOUND)
  add_dependencies(${CURRENT_PROJECT} "${CURRENT_PROJECT}_Resources")
endif()
  
set_property( TARGET ${CURRENT_PROJECT} PROPERTY FOLDER "${CURRENT_PROJECT_IDE_PATH}")
  
target_link_libraries ( ${CURRENT_PROJECT} LINK_PUBLIC
                                CcKernel
                                CcRemoteDevice )
  
#################
# Post configuration steps
#################
CcOSExampleProjectTargetIncludeDirs( ${CURRENT_PROJECT} ${OPENSLL_INCLUDE_DIR} )
#CcOSExampleProjectLibSettings(${CURRENT_PROJECT} TRUE TRUE ${SOURCE_FILES})
CcOSExampleProjectExeSettings(${CURRENT_PROJECT} ${SOURCE_FILES} ${CURRENT_PROJECT_RESOURCE_FILES})
  
########
# Add an unity-test, if available
########
CcAddTestDir(${CMAKE_CURRENT_SOURCE_DIR}/test)
