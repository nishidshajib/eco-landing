@echo off
echo 🚀 Eco-Landing Domain Setup Helper for Windows
echo ===============================================

set /p brokers_domain="🏢 Conventional Mortgage Brokers domain [conventionalmortgagebrokers.com]: "
if "%brokers_domain%"=="" set brokers_domain=conventionalmortgagebrokers.com

set /p loans_domain="🏠 Conventional Mortgage Loans domain [conventionalmortgageloans.com]: "
if "%loans_domain%"=="" set loans_domain=conventionalmortgageloans.com

set /p heloc_domain="💰 HELOC Loan Officers domain [helocloanofficers.com]: "
if "%heloc_domain%"=="" set heloc_domain=helocloanofficers.com

echo.
echo 🔧 Updating Hugo configuration files...

REM Update brokers config
if exist "config\conventionalmortgagebrokers\hugo.toml" (
    copy "config\conventionalmortgagebrokers\hugo.toml" "config\conventionalmortgagebrokers\hugo.toml.backup" >nul
    powershell -Command "(gc 'config\conventionalmortgagebrokers\hugo.toml') -replace '^baseURL.*', 'baseURL = \"https://%brokers_domain%\"' | sc 'config\conventionalmortgagebrokers\hugo.toml'"
    echo ✅ Updated conventionalmortgagebrokers/hugo.toml
) else (
    echo ❌ Config file not found: config\conventionalmortgagebrokers\hugo.toml
)

REM Update loans config
if exist "config\conventionalmortgageloans\hugo.toml" (
    copy "config\conventionalmortgageloans\hugo.toml" "config\conventionalmortgageloans\hugo.toml.backup" >nul
    powershell -Command "(gc 'config\conventionalmortgageloans\hugo.toml') -replace '^baseURL.*', 'baseURL = \"https://%loans_domain%\"' | sc 'config\conventionalmortgageloans\hugo.toml'"
    echo ✅ Updated conventionalmortgageloans/hugo.toml
) else (
    echo ❌ Config file not found: config\conventionalmortgageloans\hugo.toml
)

REM Update HELOC config
if exist "config\helocloanofficers\hugo.toml" (
    copy "config\helocloanofficers\hugo.toml" "config\helocloanofficers\hugo.toml.backup" >nul
    powershell -Command "(gc 'config\helocloanofficers\hugo.toml') -replace '^baseURL.*', 'baseURL = \"https://%heloc_domain%\"' | sc 'config\helocloanofficers\hugo.toml'"
    echo ✅ Updated helocloanofficers/hugo.toml
) else (
    echo ❌ Config file not found: config\helocloanofficers\hugo.toml
)

echo.
echo 📋 Hostinger Directory Structure Expected:
echo ├── /domains/%brokers_domain%/public_html/
echo ├── /domains/%loans_domain%/public_html/
echo └── /domains/%heloc_domain%/public_html/

echo.
echo 🔐 GitHub Secrets to Configure:
echo Required:
echo   - FTP_SERVER: Your Hostinger FTP server
echo   - FTP_USERNAME: Your Hostinger FTP username
echo   - FTP_PASSWORD: Your Hostinger FTP password

echo.
echo Optional (if Hostinger uses different paths):
echo   - BROKERS_FTP_DIR: /domains/%brokers_domain%/public_html/
echo   - LOANS_FTP_DIR: /domains/%loans_domain%/public_html/
echo   - HELOC_FTP_DIR: /domains/%heloc_domain%/public_html/

echo.
echo ✅ Setup complete! Commit and push these changes to trigger automatic deployment.
echo.
echo Next steps:
echo 1. Configure GitHub Secrets in your repository
echo 2. Ensure domains are set up in Hostinger
echo 3. Commit and push changes:
echo    git add .
echo    git commit -m "Configure domains"
echo    git push

pause