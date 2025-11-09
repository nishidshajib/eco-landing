# Dynamic Landing Pages - Multi-Domain Hugo Setup

## 🚀 Quick Start

### Preview Domain Sites (Development)

```powershell
# Preview HELOC domain on port 1320
hugo server --environment helocloanofficers --port 1320

# Preview Conventional Loans domain on port 1321
hugo server --environment conventionalmortgageloans --port 1321

# Preview Conventional Brokers domain on port 1322
hugo server --environment conventionalmortgagebrokers --port 1322

# Preview fhaloanofficers domain on port 1323
hugo server --environment fhaloanofficers --port 1323

# Preview firsttimebuyeroptions on port 1324
hugo server --environment firsttimebuyeroptions --port 1324

# Preview conformingmortgageloans on port 1325
hugo server --environment conformingmortgageloans --port 1325

# Preview refinanceloanofficers on port 1326
hugo server --environment refinanceloanofficers --port 1326
```
#conformingmortgageloans
Access sites at:
- HELOC: http://localhost:1320
- Conventional Loans: http://localhost:1321
- Conventional Brokers: http://localhost:1322

---

## 🏗️ Build for Production

### Build Single Domain

```powershell
# Build HELOC domain
hugo --environment helocloanofficers --minify

# Build Conventional Loans domain
hugo --environment conventionalmortgageloans --minify

# Build Conventional Brokers domain
hugo --environment conventionalmortgagebrokers --minify
```

Output directories:
- `public/helocloanofficers/`
- `public/conventionalmortgageloans/`
- `public/conventionalmortgagebrokers/`

### Build All Domains

```powershell
# Build all three domains with minification
hugo --environment helocloanofficers --minify
hugo --environment conventionalmortgageloans --minify
hugo --environment conventionalmortgagebrokers --minify
```

---

## 📦 Build & Deploy Script

Create a PowerShell script to build all domains:

```powershell
# build-all.ps1
$domains = @('helocloanofficers', 'conventionalmortgageloans', 'conventionalmortgagebrokers')

foreach ($domain in $domains) {
    Write-Host "Building $domain..." -ForegroundColor Green
    hugo --environment $domain --minify
    Write-Host "✓ $domain built successfully" -ForegroundColor Cyan
}

Write-Host "`n✓ All domains built successfully!" -ForegroundColor Green
```

Run: `.\build-all.ps1`

---

## 🌐 Domain Structure

```
config/
├── _default/           # Base config
├── helocloanofficers/  # HELOC domain config
├── conventionalmortgageloans/  # Conventional loans config
└── conventionalmortgagebrokers/  # Brokers config

content/
├── helocloanofficers/  # HELOC content
├── conventionalmortgageloans/  # Conventional loans content
└── conventionalmortgagebrokers/  # Brokers content

public/
├── helocloanofficers/  # HELOC build output
├── conventionalmortgageloans/  # Conventional loans output
└── conventionalmortgagebrokers/  # Brokers output
```

---

## 📝 Add New Domain

1. **Create config**: `config/newdomain/hugo.toml`
2. **Create content**: `content/newdomain/_index.md`
3. **Add blog folder**: `content/newdomain/blogs/`
4. **Preview**: `hugo server --environment newdomain --port 1323`
5. **Build**: `hugo --environment newdomain --minify`

---

## 🔧 Common Commands

```powershell
# Clean all builds
Remove-Item -Recurse -Force public/*

# Build with verbose output
hugo --environment helocloanofficers --minify --verbose

# Check Hugo version
hugo version

# Generate production build with stats
hugo --environment conventionalmortgageloans --minify --templateMetrics
```

---

## 🚢 Deployment

Each domain outputs to its own directory:
- Upload `public/helocloanofficers/` → helocloanofficers.com
- Upload `public/conventionalmortgageloans/` → conventionalmortgageloans.com
- Upload `public/conventionalmortgagebrokers/` → conventionalmortgagebrokers.com
