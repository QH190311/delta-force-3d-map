@echo off
chcp 65001 >nul 2>&1
title 3D Map Preview - stop

setlocal enabledelayedexpansion
for /l %%P in (8777,1,8790) do (
  for /f "tokens=5" %%A in ('netstat -ano ^| findstr ":%%P " ^| findstr LISTENING 2^>nul') do (
    taskkill /F /PID %%A >nul 2>&1 && echo   killed PID %%A on port %%P
  )
)
echo.
echo   done
timeout /t 2 >nul
