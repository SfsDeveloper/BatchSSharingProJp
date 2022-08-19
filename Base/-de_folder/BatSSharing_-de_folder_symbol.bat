echo off
rem Note : When using <%>, enter <%%>.
rem Note : When using <'>, enter <''>.

rem If you specify   <-ext '\"abc !#$%%^&''()=~{}`+_,def\"'>, 
rem the extension is         <abc !#$%^&'()=~{}`+_,def>.
echo on

powershell -Command "& '%~dp0SSharing.ps1'" -cmd -default -decode -de_report -de_folder '\"abc !#$%%^&''()=~{}`+_,def\"' -pause -de_openfolder '\"%1\"'
pause
