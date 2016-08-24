@echo off

del *.obj
del ../Out/*

CALL .\BuildBoot.bat
CALL .\BuildKern.bat

echo DBG: Currently working in %cd%

Pause