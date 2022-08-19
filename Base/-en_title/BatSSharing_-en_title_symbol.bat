echo off
rem Note : When using <%>, enter <%%>.
rem Note : When using <'>, enter <''>.

rem If you specify   <-ext '\"abc !#$%%^&''()=~{}`+_,def\"'>, 
rem the extension is         <abc !#$%^&'()=~{}`+_,def>.
echo on

powershell -Command "& '%~dp0SSharing.ps1'" -cmd -default -encode -en_report -en_n 5 -en_k 3 -en_title '\"abc !#$%%^&''()=~{}`+_,def\"' -pause_n '\"%1\"'
pause
