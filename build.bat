@echo off
echo Detecting changed domains...

rem Get changed files from git
for /f "delims=" %%i in ('git diff --name-only HEAD') do (
    set "file=%%i"
    
    rem Check if content or config changed
    echo %%i | findstr /i "^content\\ ^config\\" >nul
    if not errorlevel 1 (
        rem Extract domain name (second part of path)
        for /f "tokens=2 delims=\/" %%d in ("%%i") do (
            if not "%%d"=="_default" (
                set "domains=!domains! %%d"
            )
        )
    )
    
    rem If layouts or themes changed, rebuild all
    echo %%i | findstr /i "^layouts\\ ^themes\\" >nul
    if not errorlevel 1 (
        echo Layouts/themes changed - rebuilding all domains
        goto buildall
    )
)

rem Remove duplicates and build changed domains only
if defined domains (
    echo Building changed domains: %domains%
    for %%d in (%domains%) do (
        if exist "config\%%d\hugo.toml" (
            echo Building %%d...
            hugo --environment %%d --config config\_default\hugo.toml,config\%%d\hugo.toml --destination public\%%d --cleanDestinationDir --minify
        )
    )
    echo Build complete!
    exit /b 0
)

echo No changes detected. Use: build-all to rebuild everything
exit /b 0

:buildall
echo Cleaning public folder...
rmdir /s /q public 2>nul
mkdir public

echo Building all domains...

for /d %%d in (config\*) do (
    if not "%%~nd"=="_default" (
        if exist "config\%%~nd\hugo.toml" (
            echo Building %%~nd...
            hugo --environment %%~nd --config config\_default\hugo.toml,config\%%~nd\hugo.toml --destination public\%%~nd --cleanDestinationDir --minify
        )
    )
)

echo Build complete!
