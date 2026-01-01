# Build script for multi-domain Hugo site
# Builds each domain separately to its own public/domain/ folder
# Categories and tags will be inside each domain folder

Write-Host "Cleaning public folder..." -ForegroundColor Yellow
Remove-Item -Path "public" -Recurse -Force -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Path "public" -Force | Out-Null

Write-Host "Building individual domains..." -ForegroundColor Yellow

# Get all domain configs (everything except _default)
$domains = Get-ChildItem -Path "config" -Directory | Where-Object { $_.Name -ne "_default" }

foreach ($domain in $domains) {
    $domainName = $domain.Name
    $configPath = "config/_default/hugo.toml,config/$domainName/hugo.toml"
    
    Write-Host "Building $domainName..." -ForegroundColor Green
    
    hugo --environment $domainName --config $configPath --destination "public/$domainName" --cleanDestinationDir --minify
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "OK: $domainName built successfully" -ForegroundColor Green
    } else {
        Write-Host "ERROR: $domainName build failed" -ForegroundColor Red
    }
}

Write-Host "Build complete!" -ForegroundColor Cyan
Write-Host "Structure: Each domain has its own categories/ and tags/ folders inside" -ForegroundColor Cyan
Write-Host "Ready to commit public/ and push!" -ForegroundColor Green
