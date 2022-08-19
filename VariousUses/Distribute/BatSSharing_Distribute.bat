echo off
rem %1 : Folder or File
rem %2 : Threshold
rem %3 - %argc : Distribution drive (argc=Number of arguments)

set dp_from=%~dp0%1
set dp_to=%~dp0%1_shr\
set p_to=%~p0%1_shr\
set k=%2

rem Count the number of arguments
set argc=0
for %%x in (%*) do Set /A argc+=1

if %argc% lss 3 (
	echo Not enough arguments
	pause
	exit /b
)

rem Determine the number of shares
Set /A n=argc-1

rem Sharing
echo powershell -Command "& '%~dp0SSharing.ps1'" -cmd -default -encode -en_report_n -en_n %n% -en_k %k% -pause_n '\"%dp_from%\"'
powershell -Command "& '%~dp0SSharing.ps1'" -cmd -default -encode -en_report_n -en_n %n% -en_k %k% -pause_n '\"%dp_from%\"'

rem %%1 and %%2 are skipped
shift
shift

rem loop i = 2 to n
Set i=2
:LOOP
	rem End if there is no i-th argument
	if "%1"=="" goto :ENDOFLOOP
	
	rem Source file and distribution folder
	set from_file=%dp_to%*_%i%.shr
	set to_folder=%1:%p_to%
	
	rem Create if there is no distribution folder
	If not exist %to_folder% mkdir %to_folder%
	
	rem Move to distribution folder
	echo move %from_file% %to_folder%
	move %from_file% %to_folder%
	
	rem Show distribution folder
	explorer %to_folder%
	
	rem To the next argument
	Set /A i+=1
	shift
goto LOOP
:ENDOFLOOP
echo off

pause
