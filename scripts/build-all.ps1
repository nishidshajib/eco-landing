param(
    [switch]$Minify,
    [switch]$VerboseOutput
)

$repoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$configRoot = Join-Path $repoRoot 'config'

if (-not (Test-Path $configRoot)) {
    Write-Error "Config directory '$configRoot' was not found."
    exit 1
}

Push-Location $repoRoot

Get-ChildItem -Path $configRoot -Directory | ForEach-Object {
    $configFile = Join-Path $_.FullName 'hugo.toml'
    if (-not (Test-Path $configFile)) {
        Write-Warning "Skipping '$($_.Name)' because no hugo.toml was found."
        return
    }

    $siteKey = $_.Name
    $args = @('--config', $configFile)
    if ($Minify) {
        $args += '--minify'
    }
    if (-not $VerboseOutput) {
        $args += '--quiet'
    }

    $publishDir = Join-Path $repoRoot "public/$siteKey"
    if (Test-Path $publishDir) {
        Write-Host "Removing existing output for '$siteKey'" -ForegroundColor DarkGray
        Remove-Item $publishDir -Recurse -Force
    }

    Write-Host "Building site '$siteKey' with config $configFile" -ForegroundColor Cyan
    & hugo @args
    if ($LASTEXITCODE -ne 0) {
        Write-Error "Hugo build failed for '$siteKey'"
        Pop-Location
        exit $LASTEXITCODE
    }
}

Pop-Location
Write-Host 'All sites built successfully.' -ForegroundColor Green
