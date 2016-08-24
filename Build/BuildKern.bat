@echo off

REM =========== Compile ===========

..\Bin\vc152\CL.EXE /AT /c /Zl /Od /nologo /Gs /G2 /Gx ..\Src\IgniteKernel\*.cpp
REM "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\bin\cl.exe"  /O2 /nologo /GS- /GR- /c /Zl /Od ..\Src\IgniteKernel\*.cpp

for %%a in (..\Src\IgniteKernel\*.asm) do "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\bin\ml.exe" /c /omf %%a

REM "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\bin\link.exe" /NOD /SUBSYSTEM:NATIVE /NOLOGO boot.obj kernel.obj display.obj string.obj
..\Bin\link16\link.exe  /TINY /NODEFAULTLIBRARYSEARCH boot.obj kernel.obj display.obj string.obj,boot.com,nul,nul,nul

REM =========== Move Build ===========

move /Y *.com ..\Out\kernel.bin >nul 2>&1

REM =========== Build Boot disk Image ===========
REM	seek = 1, we seek 1 block further (512 bytes)

..\Bin\dd\dd.exe if=../Out/kernel.bin of=../Out/disc.img conv=notrunc seek=1 >nul 2>&1