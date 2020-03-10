@echo off
set UNPACK_DIR=repo_contents

:: Move files to root dir to avoid a License file error 
robocopy /mov %UNPACK_DIR% .\ AUTHORS COPYING COPYING.LESSER LICENSE README.md

:: Copy all of the appropriate things to site-packages\gpi_core
robocopy %UNPACK_DIR% %SP_DIR%\%PKG_NAME% /MIR /XF .*
robocopy .\ %SP_DIR%\%PKG_NAME% AUTHORS COPYING COPYING.LESSER LICENSE README.md

:: Do the build in place in site-packages
cd %SP_DIR%\%PKG_NAME%
gpi_make --all --ignore-system-libs --ignore-gpirc -r 3

:: drop a version file with parseable info
set VERSION_FPATH=%SP_DIR%/%PKG_NAME%/VERSION
@echo PKG_NAME: %PKG_NAME% > %VERSION_FPATH%
@echo PKG_VERSION: %PKG_VERSION% >> %VERSION_FPATH%
@echo PKG_BUILD_STRING: %PKG_BUILD_STRING% >> %VERSION_FPATH%
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (SET BUILD_DATE=%%c-%%a-%%b)
@echo BUILD_DATE: %BUILD_DATE% >> %VERSION_FPATH%
