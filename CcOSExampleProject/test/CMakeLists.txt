################################################################################
# Create Tests only if we are building CcOSExampleProject
################################################################################

set ( CURRENT_TEST_PROJECT ${CURRENT_PROJECT}Test )

########
# Add Source Files
########
file (GLOB SOURCE_FILES
"*.c"
"*.cpp"
"*.h")

include_directories( ${CMAKE_CURRENT_SOURCE_DIR} )

if(WINDOWS)
CcOSExampleProjectGenerateRcFileToCurrentDir(${CURRENT_TEST_PROJECT} SOURCE_FILES )
endif()

CcAddExecutable( ${CURRENT_TEST_PROJECT} ${SOURCE_FILES} )

set_property( TARGET ${CURRENT_TEST_PROJECT} PROPERTY FOLDER "/Testing/${CURRENT_PROJECT_IDE_PATH}")

source_group( "" FILES ${SOURCE_FILES})

target_link_libraries ( ${CURRENT_TEST_PROJECT} LINK_PRIVATE
                        ${CURRENT_PROJECT}
                        CcTesting )

CcAddTest(${CURRENT_TEST_PROJECT})

#################
# Post configuration steps
#################
CcOSExampleProjectExeSettings(${CURRENT_PROJECT})
