@echo off
setlocal enabledelayedexpansion

echo 📝 Eco-Landing Scheduled Post Creator (Windows)
echo =============================================

echo.
echo Select the site type:
echo 1) Conventional Mortgage Brokers
echo 2) Conventional Mortgage Loans
echo 3) HELOC Loan Officers
echo 4) Main Site
echo.
set /p site_choice="Enter choice (1-4): "

if "%site_choice%"=="1" (
    set site_type=brokers
    set content_dir=content\conventionalmortgagebrokers\blogs
) else if "%site_choice%"=="2" (
    set site_type=loans
    set content_dir=content\conventionalmortgageloans\blogs
) else if "%site_choice%"=="3" (
    set site_type=heloc
    set content_dir=content\helocloanofficers\blogs
) else if "%site_choice%"=="4" (
    set site_type=main
    set content_dir=content\blogs
) else (
    echo ❌ Invalid choice
    pause
    exit /b 1
)

echo.
set /p title="📝 Post title: "
if "%title%"=="" (
    echo ❌ Title is required
    pause
    exit /b 1
)

echo.
echo 📅 Publish date examples:
echo   - 2025-11-06T10:00:00Z (Today at 10 AM UTC)
echo   - 2025-11-07T15:30:00Z (Tomorrow at 3:30 PM UTC)
echo   - 2025-12-01T08:00:00Z (December 1st at 8 AM UTC)
echo.
set /p publish_date="🕐 Publish date (YYYY-MM-DDTHH:MM:SSZ): "

if "%publish_date%"=="" (
    echo ❌ Publish date is required
    pause
    exit /b 1
)

echo.
set /p author="👤 Author name [Blog Admin]: "
if "%author%"=="" set author=Blog Admin

echo.
set /p tags_input="🏷️  Tags (comma-separated): "

echo.
set /p categories_input="📂 Categories (comma-separated): "

REM Generate filename from title
set filename=%title%
set filename=!filename: =-!
set filename=!filename:,=!
set filename=!filename:.=!
set filename=!filename:'=!
set filename=!filename:"=!
set filename=!filename:?=!
set filename=!filename:!=!
set filename=!filename:@=!
set filename=!filename:#=!
set filename=!filename:$=!
set filename=!filename:%%=!
set filename=!filename:^=!
set filename=!filename:&=!
set filename=!filename:*=!
set filename=!filename:(=!
set filename=!filename:)=!
set filename=!filename:+=!
set filename=!filename:[=!
set filename=!filename:]=!
set filename=!filename:{=!
set filename=!filename:}=!
set filename=!filename:\=!
set filename=!filename:|=!
set filename=!filename:;=!
set filename=!filename::=!
set filename=!filename:</=!
set filename=!filename:>=!
set filename=!filename:/=!

REM Convert to lowercase (simple approach)
for %%a in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    set filename=!filename:%%a=%%a!
)

set filepath=%content_dir%\!filename!.md

REM Create directory if it doesn't exist
if not exist "%content_dir%" mkdir "%content_dir%"

REM Check if file already exists
if exist "%filepath%" (
    echo ❌ File already exists: %filepath%
    pause
    exit /b 1
)

echo.
echo 📋 Post Summary:
echo ----------------
echo Site: %site_type%
echo Title: %title%
echo Publish Date: %publish_date%
echo Author: %author%
echo Tags: %tags_input%
echo Categories: %categories_input%
echo File: %filepath%

echo.
set /p confirm="✅ Create this scheduled post? (y/N): "

if /i "%confirm%"=="y" (
    REM Get current date in ISO format
    for /f "tokens=1-3 delims=/ " %%a in ('date /t') do set currentdate=%%c-%%a-%%b
    for /f "tokens=1-2 delims=: " %%a in ('time /t') do set currenttime=%%a:%%b:00

    REM Format tags and categories for YAML
    set tags_formatted="%tags_input:,=", "%"
    set categories_formatted="%categories_input:,=", "%"

    REM Create the post file
    (
        echo ---
        echo title: "%title%"
        echo date: %currentdate%T%currenttime%Z
        echo publishdate: "%publish_date%"
        echo draft: true
        echo author: "%author%"
        echo tags: [!tags_formatted!]
        echo categories: [!categories_formatted!]
        echo description: "Add your post description here"
        echo ---
        echo.
        echo # %title%
        echo.
        echo Write your post content here...
        echo.
        echo ## Introduction
        echo.
        echo Add your introduction here.
        echo.
        echo ## Main Content
        echo.
        echo Add your main content here.
        echo.
        echo ## Conclusion
        echo.
        echo Add your conclusion here.
    ) > "%filepath%"

    echo.
    echo 🎉 Scheduled post created successfully!
    echo.
    echo 📋 Next steps:
    echo 1. Edit the post content in your preferred editor
    echo 2. Commit and push to GitHub:
    echo    git add .
    echo    git commit -m "Add scheduled post: %title%"
    echo    git push origin main
    echo.
    echo 3. The post will automatically publish on: %publish_date%
    echo 4. GitHub Actions will check every hour and publish when ready
    echo.
    echo 📁 Post created at: %filepath%
) else (
    echo ❌ Post creation cancelled
)

pause