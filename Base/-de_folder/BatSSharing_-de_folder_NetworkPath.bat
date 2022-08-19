rem Not : If you want to add <\> to the end of the network path as in the following sample, write <\\>.

powershell -Command "& '%~dp0SSharing.ps1'" -cmd -default -decode -de_report -de_folder "\\netname\abc\def\\" -pause -de_openfolder '\"%1\"'
pause
