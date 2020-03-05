@echo off

set UNPACK_DIR=repo_contents

:: Move files to root dir to avoid a License file error 
robocopy /mov %UNPACK_DIR% .\ AUTHORS COPYING COPYING.LESSER LICENSE README.md

:: Make the site-packages directory
:: mkdir -p %SP_DIR%\%PKG_NAME%

:: Copy all of the appropriate things there
robocopy %UNPACK_DIR% %SP_DIR%\%PKG_NAME% /MIR /XF .*
robocopy .\ %SP_DIR%\%PKG_NAME% AUTHORS COPYING COPYING.LESSER LICENSE README.md

:: Delete files that won't work for windows installations (C-based nodes)
:: del /s %SP_DIR%\%PKG_NAME%\Gridding
:: del /s %SP_DIR%\%PKG_NAME%\Spiral
:: del /q %SP_DIR%\%PKG_NAME%\Math\fft_PyMOD.cpp
:: del /q %SP_DIR%\%PKG_NAME%\Math\GPI\FFTW_GPI.py
:: del /q %SP_DIR%\%PKG_NAME%\Math\GPI\Interpolate_GPI.py

:: No gpi_make on windows at this time - leaving as comments for reference
:: Do the build in place in site-packages
cd %SP_DIR%\%PKG_NAME%
gpi_make --all --ignore-system-libs --ignore-gpirc -r 3

# drop a version file with parseable info
set VERSION_FPATH=%SP_DIR%/%PKG_NAME%/VERSION
@echo PKG_NAME: %PKG_NAME% > %VERSION_FPATH%
@echo PKG_VERSION: %PKG_VERSION% >> %VERSION_FPATH%
@echo PKG_BUILD_STRING: %PKG_BUILD_STRING% >> %VERSION_FPATH%
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (SET BUILD_DATE=%%c-%%a-%%b)
@echo BUILD_DATE: %BUILD_DATE% >> %VERSION_FPATH%
