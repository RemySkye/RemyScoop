@echo OFF
setlocal ENABLEEXTENSIONS

:beginning
  FOR /F "usebackq skip=1 tokens=2,*" %%A IN (`C:\Windows\sysnative\reg.exe QUERY HKEY_LOCAL_MACHINE\SOFTWARE\EqualizerAPO /v ConfigPath 2^>nul`) DO set Val=%%B
  if defined Val GOTO finalmove
  ECHO Please install Equalizer APO first!
  ECHO Press any key to exit.
  PAUSE >NUL
  EXIT /B

:finalmove
  robocopy HeSuVi "%Val%\HeSuVi" /E /MOVE /NP /NS /NC /W:2
  if not exist "%appdata%\Microsoft\Windows\Start Menu\Programs\HeSuVi\" mkdir "%appdata%\Microsoft\Windows\Start Menu\Programs\HeSuVi"
  powershell "$s=(New-Object -COM WScript.Shell).CreateShortcut('%appdata%\Microsoft\Windows\Start Menu\Programs\HeSuVi\HeSuVi.lnk');$s.TargetPath='%Val%\HeSuVi\HeSuVi.exe';$s.Save()"
  START "HeSuVi" "%Val%\HeSuVi\HeSuVi.exe"