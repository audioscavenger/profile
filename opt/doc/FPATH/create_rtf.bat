@echo OFF
for /F %%a in ('dir /b /ad') do (
  for /F %%b in ('dir /b %%a ^| grep -v rtf') do (
    if NOT EXIST  %%a\%%b.rtf copy /y template.rtf %%a\_%%b.rtf
    )
  )
pause
