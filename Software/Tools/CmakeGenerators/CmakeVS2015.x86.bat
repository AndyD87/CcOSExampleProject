SET TOOLS_DIR=%cd%
cd ..
cd ..

mkdir Solution.VC14.x86
cd Solution.VC14.x86
cmake ../ -G "Visual Studio 14"

cd "%TOOLS_DIR%"
