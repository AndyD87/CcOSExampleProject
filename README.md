# CcOSExampleProject

Project wich is based on CcOS.

Target of this Project is to have an project wich can be copied 
and after simply relplace of "CcOSExampleProject" with new "ProjectName", 
a new project is born.

All CcOS based Project will be created with this as basic model, for keep
projects more compareable and easer to maintain. Changes here will later added
to other projects too.

# Create new Project from Example

This has to be done to create a new Project named "NewProject"
 - Clone CcOSExampleProject to "NewProject" root directory
 - Rename Folder "CcOSExampleProject" to "NewProject" in root directory
 - Rename case sensitive "CcOSExampleProject" to "NewProject" in all files.
 - Rename case sensitive "CCOSEXAMPLEPROJECT" to "NEWPROJECT" in all files. 
 - If it is required, setup CcOS submodule:
   - Remove .gitmodule
   - Remove CcOS
   - Execute *git submodule add https://github.com/AndyD87/CcOS.git ./CcOS*

# Build CcOSExampleProject

A little overview:
* Language: c++11
* Buildsystem: cmake
* Sample Travis Ci implementation

Current status:
* [![Build Status](https://travis-ci.org/AndyD87/CcOSExampleProject.svg?branch=master)](https://travis-ci.org/AndyD87/CcOSExampleProject)

## Build on Windows

For building on Windows, at least Visual Studio 2013 is required, earlier Version doesn't fully support c++11.
In subdirectory "Tools", you can find some scripts for creating Solutions depending on Version and Architecture.
Direct builds with nmake are possbile. Look at cmake documentation, how to make it.

Execute following to get a Solution:

    cd Tools
    CmakeVS2013.x64.bat
    cd ..\Solution
    CcOSExampleProject.sln
    
## Build on Linux

One way to build on Linux is to use building scripts under Tools:

    cd Tools
    sh build.sh # change to "buildDebug.sh" if debug is requried
    cd ..\Solution

Second way is to build on commandline, without build script.
Here an example:

    mkdir Solution
    cd Solution
    cmake ../
    make
    make install

## Licence

Author of CcOSExampleProject-Framework: [Andreas Dirmeier](http://adirmeier.de)
This application is licenced under LGPL v3. Look at COPYING and COPYING.LESSER for further information.
