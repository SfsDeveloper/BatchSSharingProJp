echo off
rem %1 : Folder or File
rem %2 - %argc : Distribution drive (argc=Number of arguments)

set folder_shr=%1_shr
set dp_from=%~dp0%folder_shr%\
set p_from=%~p0%folder_shr%\

rem Count the number of arguments
set argc=0
for %%x in (%*) do Set /A argc+=1

if %argc% lss 2 (
	echo Not enough arguments
	pause
	exit /b
)

rem Determine the number of shares
Set /A n=argc

rem %%1 is skipped
shift

rem loop i = 2 to n
Set i=2
Set from_files=""
:LOOP
	rem End if there is no i-th argument
	if "%1"=="" goto :ENDOFLOOP
	
	rem Source file and distribution folder
	set from_file=%1:%p_from%*.shr
	set to_folder=%dp_from%
	
	rem Create if there is no distribution folder
	If not exist %from_file% (
		echo Not found %from_file%
		pause
		exit /b
	)
	
	rem Move to distribution folder
	echo move %from_file% %to_folder%
	move %from_file% %to_folder%
	
	rem To the next argument
	Set /A i+=1
	shift
goto LOOP
:ENDOFLOOP

rem Reconstruct
echo powershell -Command "& '%~dp0SSharing.ps1'" -cmd -default -decode -de_report_n -pause_n '\"%folder_shr%\"'
powershell -Command "& '%~dp0SSharing.ps1'" -cmd -default -decode -de_report_n -pause_n '\"%folder_shr%\"'

pause
