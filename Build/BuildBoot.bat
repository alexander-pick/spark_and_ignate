@echo off

REM =========== Compile ===========

for %%a in (..\Src\SparkBoot\*.asm) do "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\bin\ml.exe" /c /omf /nologo %%a

..\Bin\link16\link.exe /TINY /NODEFAULTLIBRARYSEARCH bootstrap.obj,bootstrap.com,nul,nul,nul

REM =========== Move Build ===========

move /Y *.com ..\Out\bootstrap.bin >nul 2>&1

REM =========== Build Boot disk Image ===========

..\Bin\dd\dd.exe if=/dev/zero of=../Out/disc.img bs=1024 count=1440 >nul 2>&1
..\Bin\dd\dd.exe if=../Out/bootstrap.bin of=../Out/disc.img conv=notrunc >nul 2>&1
