@echo off
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
