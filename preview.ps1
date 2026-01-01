# Preview script for testing individual domains with hugo serve
# Usage: .\preview.ps1 badcreditloanspecialist

param(
    [Parameter(Mandatory=$true)]
    [string]$domain
)

$configPath = "config/$domain/hugo.toml"

if (-not (Test-Path $configPath)) {
    Write-Host "Error: Domain '$domain' not found in config/" -ForegroundColor Red
    Write-Host "Available domains:" -ForegroundColor Yellow
    Get-ChildItem -Path "config" -Directory | Where-Object { $_.Name -ne "_default" } | ForEach-Object { Write-Host "  - $($_.Name)" -ForegroundColor Cyan }
    exit 1
}

Write-Host "Starting preview server for: $domain" -ForegroundColor Green
Write-Host "URL: http://localhost:1313" -ForegroundColor Cyan
Write-Host "Press Ctrl+C to stop" -ForegroundColor Yellow
Write-Host ""

hugo serve --environment $domain --config "config/_default/hugo.toml,$configPath" --bind 127.0.0.1 --port 1313
