@echo off
setlocal enabledelayedexpansion

if "%1"=="" (
    echo Usage: build-single domainname
    echo Example: build-single badcreditloanspecialist
    exit /b 1
)

set domain=%1

if not exist "config\%domain%\hugo.toml" (
    echo Error: Domain '%domain%' not found
    exit /b 1
)

echo Building %domain%...
hugo --environment %domain% --config config\_default\hugo.toml,config\%domain%\hugo.toml --destination public\%domain% --cleanDestinationDir --minify

echo Done! Built to public\%domain%\
