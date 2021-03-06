@echo OFF
pushd %~dp0

set CHANGELOGmd=CHANGELOG.new.md
echo ## Contents >%CHANGELOGmd%

for /f "tokens=2,3,4 delims=." %%a in ('dir /o-n /b *.zip *.7z') do (
  echo - [v%%a.%%b.%%c]^(#v%%a%%b%%c^) >>%CHANGELOGmd%
)

for /f "tokens=2,3,4 delims=." %%a in ('dir /o-n /b *.zip *.7z') do (
  echo.>>%CHANGELOGmd%
  echo * v%%a.%%b.%%c >>%CHANGELOGmd%
  echo   * >>%CHANGELOGmd%
)
