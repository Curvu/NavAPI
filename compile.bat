@echo off

REM ---------------------------
REM Deploy UI and run Trove build
REM ---------------------------

set "scriptDir=%~dp0"
set "src=%scriptDir%ui"
set "dst=C:\Games\Glyph\Games\Trove\Live"
set "override=%dst%\ui\override"
set "troveExe=%dst%\Trove.exe"
set "metaSrc=%scriptDir%mod.yaml"

echo Deploying UI to Trove...
echo Source: "%src%"
echo Destination: "%override%"
echo Live folder: "%dst%"
echo.

echo Copying UI files...
xcopy "%src%\*" "%override%\" /E /Y >nul
echo UI files copied.
echo.

echo Copying mod.yaml to "%dst%"...
xcopy "%metaSrc%" "%dst%\" /Y >nul
echo mod.yaml copied.
echo.

pushd "%dst%"
echo Running: "%troveExe%" -tool buildmod -meta mod.yaml
"%troveExe%" -tool buildmod -meta mod.yaml
if not "%errorlevel%"=="0" (
    echo Trove exited with code %errorlevel%.
) else (
    echo Trove finished successfully.
)
popd

echo.
echo Deployment complete.
