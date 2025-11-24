# Dynamic Landing Pages - Multi-Domain Hugo Setup

## 🚀 Automated Multi-Domain System (Updated: Nov 16, 2025)

This repository automatically builds and deploys **12 landing page domains** to Hostinger with zero manual configuration!

### ✨ Key Features

- 🎯 **Automatic Discovery**: Scans config directory for all domains
- 🏗️ **Parallel Building**: Builds all 12 domains simultaneously
- 📤 **Smart Deployment**: Each domain uploads to its matching Hostinger directory
- ♻️ **Zero Configuration**: Add new domains without touching workflows
- 🕐 **Auto-Publishing**: Schedule blog posts for automatic publishing
- 🎯 **Single Domain Deploy**: Deploy just one domain without rebuilding all
- 📊 **Full Tracking**: Monitor all deployments in GitHub Actions

### 📋 Currently Configured Domains (12 total)

1. **badcreditloanspecialist.com**
2. **conformingloanofficers.com** ⭐ NEW
3. **conformingmortgageloans.com**
4. **conventionalmortgagebrokers.com**
5. **conventionalmortgageloans.com**
6. **fhaloanofficers.com**
7. **firsttimebuyeroptions.com**
8. **helocloanofficers.com**
9. **mtglenders.com**
10. **refimortgagebrokers.com**
11. **refinanceloanofficers.com**
12. **veteransloanofficers.com**

---

## 🚀 Quick Start

### Preview Domain Sites (Development)

```bash
# Preview individual domains on different ports
hugo server --environment helocloanofficers --port 1320
hugo server --environment conventionalmortgageloans --port 1321
hugo server --environment conventionalmortgagebrokers --port 1322
hugo server --environment fhaloanofficers --port 1323
hugo server --environment firsttimebuyeroptions --port 1324
hugo server --environment conformingmortgageloans --port 1325
hugo server --environment refinanceloanofficers --port 1326
hugo server --environment refimortgagebrokers --port 1327
hugo server --environment mtglenders --port 1328
hugo server --environment veteransloanofficers --port 1329
hugo server --environment badcreditloanspecialist --port 1330
hugo server --environment conventionalloanofficers --port 1331
hugo server --environment conformingloanofficers --port 1332
hugo server --environment purchaseloanofficers --port 1333
hugo server --environment newconstructionloanofficers --port 1334
hugo server --environment renovationloanofficers --port 1335
hugo server --environment fha203kloanofficer --port 1336
hugo server --environment fhahomemortgageloan --port 1337
hugo server --environment nonconforminghomeloans --port 1338
hugo server --environment purchasemortgageloans --port 1339
hugo server --environment cashoutrefinancemortgages --port 1340
hugo server --environment cashoutrefimortgage --port 1341
hugo server --environment cash-outrefinancing --port 1342
hugo server --environment onlinemortgagescalculator --port 1343
hugo server --environment homemortgagescalculator --port 1344
hugo server --environment onlineheloccalculator --port 1345
hugo server --environment conforminghomeloan --port 1346
hugo server --environment cashoutrefinancecalculators --port 1347
hugo server --environment newconstructionmortgagebrokers --port 1348
hugo server --environment cashoutmortgagerefinance --port 1349
hugo server --environment onlinevaluecalculator --port 1350
hugo server --environment homeloanpurchase --port 1351



Access sites at http://localhost:PORT

---

## 🏗️ Build for Production

### Build All Domains Automatically (Recommended)

```bash
# Build all 11 domains with a single command
bash scripts/build-all-domains.sh
```

This will:
- ✅ Discover all domain configurations automatically
- ✅ Build each domain with Hugo + minification
- ✅ Output to separate directories in `public/`
- ✅ Show detailed build statistics

### Build Single Domain

```bash
# Build specific domain
hugo --config config/helocloanofficers/hugo.toml --minify --destination public/helocloanofficers
hugo --config config/conventionalmortgageloans/hugo.toml --minify --destination public/conventionalmortgageloans
```

Output directories:
- `public/badcreditloanspecialist/`
- `public/conformingmortgageloans/`
- `public/conventionalmortgagebrokers/`
- `public/conventionalmortgageloans/`
- `public/fhaloanofficers/`
- `public/firsttimebuyeroptions/`
- `public/helocloanofficers/`
- `public/mtglenders/`
- `public/refimortgagebrokers/`
- `public/refinanceloanofficers/`
- `public/veteransloanofficers/`

---

## 📦 Build & Deploy Scripts

### Automated Build Script

Use the automated build script to build all domains:

```bash
# Build all landing pages automatically
bash scripts/build-all-domains.sh
```

This will automatically:
- Discover all 11 domain configurations
- Build each domain with Hugo + minification
- Output to separate directories in `public/`
- Show detailed build statistics

### Deployment Map Generator

Generate a deployment configuration map:

```bash
# See deployment configuration for all domains
bash scripts/generate-deployment-map.sh
```

---

## 🌐 Domain Structure

```
config/
├── _default/                     # Base configuration
├── badcreditloanspecialist/      # Bad Credit Loan Specialist domain
├── conformingloanofficers/       # Conforming Loan Officers domain ⭐ NEW
├── conformingmortgageloans/      # Conforming Mortgage Loans domain
├── conventionalmortgagebrokers/  # Conventional Brokers domain
├── conventionalmortgageloans/    # Conventional Loans domain
├── fhaloanofficers/              # FHA Loan Officers domain
├── firsttimebuyeroptions/        # First-Time Buyer Options domain
├── helocloanofficers/            # HELOC Loan Officers domain
├── mtglenders/                   # MTG Lenders domain
├── refimortgagebrokers/          # Refi Mortgage Brokers domain
├── refinanceloanofficers/        # Refinance Loan Officers domain
└── veteransloanofficers/         # Veterans Loan Officers domain

content/
├── badcreditloanspecialist/      # Content for Bad Credit domain
├── conformingloanofficers/       # Content for Conforming Officers domain ⭐ NEW
├── conformingmortgageloans/      # Content for Conforming Loans domain
├── conventionalmortgagebrokers/  # Content for Brokers domain
├── conventionalmortgageloans/    # Content for Conventional domain
├── fhaloanofficers/              # Content for FHA domain
├── firsttimebuyeroptions/        # Content for First-Time domain
├── helocloanofficers/            # Content for HELOC domain
├── mtglenders/                   # Content for MTG domain
├── refimortgagebrokers/          # Content for Refi Brokers domain
├── refinanceloanofficers/        # Content for Refinance domain
└── veteransloanofficers/         # Content for Veterans domain

public/                           # Built sites (git-ignored)
├── badcreditloanspecialist/      # → badcreditloanspecialist.com
├── conformingloanofficers/       # → conformingloanofficers.com ⭐ NEW
├── conformingmortgageloans/      # → conformingmortgageloans.com
├── conventionalmortgagebrokers/  # → conventionalmortgagebrokers.com
├── conventionalmortgageloans/    # → conventionalmortgageloans.com
├── fhaloanofficers/              # → fhaloanofficers.com
├── firsttimebuyeroptions/        # → firsttimebuyeroptions.com
├── helocloanofficers/            # → helocloanofficers.com
├── mtglenders/                   # → mtglenders.com
├── refimortgagebrokers/          # → refimortgagebrokers.com
├── refinanceloanofficers/        # → refinanceloanofficers.com
└── veteransloanofficers/         # → veteransloanofficers.com
```

---

## 📝 Add New Domain (Fully Automated!)

Adding a new landing page domain is completely automatic:

1. **Create config**: `config/newdomain/hugo.toml`
   ```toml
   baseURL = 'https://newdomain.com/'
   title = 'New Domain'
   theme = 'heloc-blog'
   contentDir = 'content/newdomain'
   publishDir = 'public/newdomain'
   ```

2. **Create content**: `content/newdomain/_index.md`

3. **Add blog folder**: `content/newdomain/blogs/`

4. **Commit and push** - GitHub Actions will automatically:
   - Discover the new domain
   - Build it with Hugo
   - Deploy to `/domains/newdomain.com/public_html/` on Hostinger

**No workflow changes needed!**

---

## 🔧 Common Commands

```bash
# Clean all builds
rm -rf public/*

# Build all domains automatically
bash scripts/build-all-domains.sh

# Build with verbose output (single domain)
hugo --config config/helocloanofficers/hugo.toml --minify --verbose

# Check Hugo version
hugo version

# View deployment map
bash scripts/generate-deployment-map.sh
```

---

## 🚢 Automatic Deployment to Hostinger

### GitHub Actions - Fully Automated

Push changes and **all 12 domains deploy automatically!**

```bash
git add .
git commit -m "Update landing pages"
git push origin main
```

GitHub Actions will:
1. ✅ Discover all 12 domain configurations
2. ✅ Build each domain with Hugo
3. ✅ Deploy each to its Hostinger directory:
   - `public/badcreditloanspecialist/` → badcreditloanspecialist.com
   - `public/conformingloanofficers/` → conformingloanofficers.com
   - `public/conformingmortgageloans/` → conformingmortgageloans.com
   - `public/conventionalmortgagebrokers/` → conventionalmortgagebrokers.com
   - `public/conventionalmortgageloans/` → conventionalmortgageloans.com
   - `public/fhaloanofficers/` → fhaloanofficers.com
   - `public/firsttimebuyeroptions/` → firsttimebuyeroptions.com
   - `public/helocloanofficers/` → helocloanofficers.com
   - `public/mtglenders/` → mtglenders.com
   - `public/refimortgagebrokers/` → refimortgagebrokers.com
   - `public/refinanceloanofficers/` → refinanceloanofficers.com
   - `public/veteransloanofficers/` → veteransloanofficers.com

### Deploy Single Domain (Manual Trigger)

Need to deploy just **one domain** without rebuilding all 12?

1. Go to **Actions** tab in GitHub
2. Click **"Deploy Single Domain"** workflow
3. Click **"Run workflow"**
4. Enter domain name (e.g., `conformingloanofficers`)
5. Click **"Run workflow"** button

This will:
- ✅ Build only that specific domain
- ✅ Deploy only to that domain's Hostinger directory
- ✅ Save time when you only changed one domain

**Example domain names:**
- `conformingloanofficers`
- `helocloanofficers`
- `conventionalmortgageloans`
- `fhaloanofficers`
- etc.

### Setup Instructions

See **[DEPLOYMENT.md](DEPLOYMENT.md)** for complete setup guide.

**Quick Setup:**
1. Add 3 GitHub secrets: `FTP_SERVER`, `FTP_USERNAME`, `FTP_PASSWORD`
2. Push changes
3. All domains deploy automatically!

### Manual Deployment (Optional)

If you need to deploy manually:

```bash
# Build all domains
bash scripts/build-all-domains.sh

# Upload to Hostinger via FTP
# Use FileZilla or similar FTP client
# Upload public/domainname/ to /domains/domainname.com/public_html/
```

---

## 📚 Documentation

- **[DEPLOYMENT.md](DEPLOYMENT.md)** - Complete deployment setup guide
- **[AUTO-PUBLISHING.md](AUTO-PUBLISHING.md)** - Scheduled post publishing
- **[HOSTINGER-SETUP.md](HOSTINGER-SETUP.md)** - Hostinger configuration guide
- **[QUICK-SETUP.md](QUICK-SETUP.md)** - Quick start guide

---

## ✨ Key Features

- 🎯 **12 Landing Page Domains** - All automated
- 🚀 **Auto-Discovery** - New domains detected automatically
- 🏗️ **Parallel Building** - Fast, efficient builds
- 📤 **Smart Deployment** - Each domain to its correct location
- 🎯 **Single Domain Deploy** - Deploy one domain without rebuilding all
- 🕐 **Scheduled Publishing** - Auto-publish blog posts
- 📊 **Full Tracking** - Monitor all deployments
- ♻️ **Zero Configuration** - Add domains without workflow changes

---

**Your eco-landing repository is now a fully automated multi-domain publishing system!** 🎉