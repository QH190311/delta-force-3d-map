@echo off
chcp 65001 >nul 2>&1
setlocal

title 3D Map Preview

where py >nul 2>&1
if not errorlevel 1 (set "PY=py") else (set "PY=python")
%PY% --version >nul 2>&1
if errorlevel 1 (
  echo.
  echo   [ERROR] Python not found. Install from python.org
  echo.
  pause & exit /b 1
)

set PORT=8777
:chk
netstat -an | findstr ":%PORT%" | findstr LISTENING >nul 2>&1
if not errorlevel 1 (
  set /a PORT+=1
  if %PORT% GTR 8790 goto fail
  goto chk
)

echo.
echo   ================================================
echo     3D Map Preview
echo   ================================================
echo.
echo     URL: http://127.0.0.1:%PORT%/web/index.html
echo.
echo     Close this window to stop.
echo.

start "" "http://127.0.0.1:%PORT%/web/index.html"

REM IMPORTANT: do NOT use --directory here.
REM A non-ASCII folder path breaks the cmd -> python handoff.
REM Python resolves the cwd on its own, which works fine.
%PY% -m http.server %PORT% --bind 127.0.0.1

echo.
echo   [stopped]
pause & exit /b 0

:fail
echo   [ERROR] ports 8777-8790 all in use. Run stop.bat first.
pause
