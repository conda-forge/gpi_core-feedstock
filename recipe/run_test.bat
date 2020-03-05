set TESTFILE=%HOMEPATH%\testNetOutput.txt
gpi --nogui TestNetwork.net > %TESTFILE%

findstr gpi.canvasGraph:383 %TESTFILE%
EXIT /B %ERRORLEVEL%
