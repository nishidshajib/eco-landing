# Automatic Multi-Domain Deployment to Hostinger

This setup automatically builds and deploys **ALL** landing pages to their corresponding domains in Hostinger hosting. **No manual configuration needed for new domains!**

## 🎯 Overview

The deployment system now automatically discovers and builds all domain configurations, then deploys each one to its matching domain on Hostinger.

### Currently Configured Domains (11 total)

✅ badcreditloanspecialist.com  
✅ conformingmortgageloans.com  
✅ conventionalmortgagebrokers.com  
✅ conventionalmortgageloans.com  
✅ fhaloanofficers.com  
✅ firsttimebuyeroptions.com  
✅ helocloanofficers.com  
✅ mtglenders.com  
✅ refimortgagebrokers.com  
✅ refinanceloanofficers.com  
✅ veteransloanofficers.com  

## 🚀 How It Works

1. **Automatic Discovery**: GitHub Actions scans the `config/` directory for all domain configurations
2. **Parallel Building**: All domains are built simultaneously using Hugo
3. **Smart Deployment**: Each domain's public folder is uploaded to its matching directory in Hostinger
4. **Domain Matching**: Domains are automatically matched using the `baseURL` in each Hugo config file

### Automatic Domain Structure

```
eco-landing repository
├── config/badcreditloanspecialist/     → badcreditloanspecialist.com
├── config/conformingmortgageloans/     → conformingmortgageloans.com
├── config/conventionalmortgagebrokers/ → conventionalmortgagebrokers.com
├── config/conventionalmortgageloans/   → conventionalmortgageloans.com
├── config/fhaloanofficers/             → fhaloanofficers.com
├── config/firsttimebuyeroptions/       → firsttimebuyeroptions.com
├── config/helocloanofficers/           → helocloanofficers.com
├── config/mtglenders/                  → mtglenders.com
├── config/refimortgagebrokers/         → refimortgagebrokers.com
├── config/refinanceloanofficers/       → refinanceloanofficers.com
└── config/veteransloanofficers/        → veteransloanofficers.com
```

### Hostinger Directory Structure

```
Hostinger Hosting
├── /domains/badcreditloanspecialist.com/public_html/
├── /domains/conformingmortgageloans.com/public_html/
├── /domains/conventionalmortgagebrokers.com/public_html/
├── /domains/conventionalmortgageloans.com/public_html/
├── /domains/fhaloanofficers.com/public_html/
├── /domains/firsttimebuyeroptions.com/public_html/
├── /domains/helocloanofficers.com/public_html/
├── /domains/mtglenders.com/public_html/
├── /domains/refimortgagebrokers.com/public_html/
├── /domains/refinanceloanofficers.com/public_html/
└── /domains/veteransloanofficers.com/public_html/
```

## 📋 Setup Instructions

### Step 1: Hostinger Domain Setup

Make sure your domains are properly configured in Hostinger:
1. **Add all your domains** in Hostinger control panel
2. **Point domains** to your hosting account
3. **Verify directory structure** (usually `/domains/yourdomain.com/public_html/`)

### Step 2: GitHub Secrets (Only 3 Required!)

Go to your GitHub repository → **Settings** → **Secrets and variables** → **Actions**

#### Essential Secrets (REQUIRED):
```
FTP_SERVER    = your Hostinger FTP server (e.g., ftp.yourdomain.com)
FTP_USERNAME  = your FTP username
FTP_PASSWORD  = your FTP password
```

**That's it!** The system will automatically detect all domains and deploy them to the correct locations.

#### Optional Per-Domain FTP Path Overrides

Only add these if your Hostinger directory structure is different from the default:

```
BADCREDITLOANSPECIALIST_FTP_DIR     = /custom/path/
CONFORMINGMORTGAGELOANS_FTP_DIR     = /custom/path/
CONVENTIONALMORTGAGEBROKERS_FTP_DIR = /custom/path/
CONVENTIONALMORTGAGELOANS_FTP_DIR   = /custom/path/
FHALOANOFFICERS_FTP_DIR             = /custom/path/
FIRSTTIMEBUYEROPTIONS_FTP_DIR       = /custom/path/
HELOCLOANOFFICERS_FTP_DIR           = /custom/path/
MTGLENDERS_FTP_DIR                  = /custom/path/
REFIMORTGAGEBROKERS_FTP_DIR         = /custom/path/
REFINANCELOANOFFICERS_FTP_DIR       = /custom/path/
VETERANSLOANOFFICERS_FTP_DIR        = /custom/path/
```

### Step 3: Test the Deployment

1. Make any small change to your repository
2. Commit and push:
   ```bash
   git add .
   git commit -m "Test automatic deployment"
   git push origin main
   ```
3. Go to **GitHub Actions** tab
4. Watch all 11 domains build and deploy automatically!

## 🛠️ Local Development & Testing

### Build All Domains Locally

```bash
# Build all landing pages at once
bash scripts/build-all-domains.sh
```

This script will:
- Automatically discover all domain configurations
- Build each domain with Hugo + minification
- Output to separate directories in `public/`
- Show detailed build statistics

### Generate Deployment Map

```bash
# See deployment configuration for all domains
bash scripts/generate-deployment-map.sh
```

This shows:
- Domain names and base URLs
- FTP directory mappings
- Required GitHub secrets
- Public folder paths

## 🔄 Deployment Process

When you push changes, the workflow will:

1. ✅ **Checkout** code
2. ✅ **Setup Hugo** and Node.js
3. ✅ **Install dependencies**
4. ✅ **Auto-discover** all domain configurations
5. ✅ **Build all sites** (11 domains in parallel)
6. ✅ **Deploy each domain** to Hostinger via FTP
7. ✅ **Show summary** of deployed domains

## 📁 File Structure on Hostinger

Each domain gets deployed to its own directory:

```
/domains/yourdomain.com/public_html/
├── index.html
├── blogs/
│   └── your-blog-posts/
├── categories/
├── tags/
├── sitemap.xml
└── manifest.json
```

## 🎉 Adding a New Landing Page Domain

**It's completely automatic!** Just:

1. Create config: `config/newdomain/hugo.toml`
2. Set the `baseURL` in the config
3. Create content: `content/newdomain/`
4. Commit and push

The system will automatically:
- Discover the new domain
- Build it
- Deploy it to Hostinger

**No workflow changes needed!**

## 🔍 Troubleshooting

### Common Issues:

**FTP Connection Failed**
- Check FTP credentials in GitHub secrets
- Verify Hostinger FTP server address
- Try connecting manually with FileZilla

**Hugo Build Failed**
- Check Hugo configuration files
- Ensure content files are properly formatted
- Look for template errors in GitHub Actions logs

**Permission Denied**
- Verify FTP username has write permissions
- Check server directory path
- Contact Hostinger support if needed

**Domain Not Deploying**
- Verify config file exists: `config/yourdomain/hugo.toml`
- Check baseURL is set correctly
- Look for build errors in GitHub Actions logs

### Checking Deployment Logs

1. Go to GitHub → **Actions** tab
2. Click on latest workflow run
3. Expand "Build All Landing Page Domains" step
4. Check individual deploy steps

## 🌟 Benefits

- 🚀 **Fully Automatic**: No manual FTP uploads
- ⚡ **Fast**: Deploys in minutes
- 🔒 **Secure**: Encrypted credentials
- 📱 **Multi-site**: Unlimited landing pages
- 📊 **Tracking**: Full deployment history
- 🕐 **Scheduled Publishing**: Auto-publish posts
- 📅 **Content Management**: Schedule posts in advance
- 🎯 **Smart Discovery**: New domains auto-detected
- ♻️ **Zero Configuration**: No workflow changes needed

## 📧 Auto-Publishing Feature

Automatically publish scheduled blog posts:

- **📝 Create scheduled posts** with future publish dates
- **🕐 Hourly checks** for posts ready to publish  
- **🚀 Automatic publishing** when date/time reached
- **📤 Instant deployment** to all affected domains

See `AUTO-PUBLISHING.md` for details.

## 💡 Making Changes

To update your landing pages:

1. Edit content files locally
2. Test with `hugo server --environment yourdomain`
3. Commit and push
4. All domains automatically rebuild and deploy!

### Creating Scheduled Posts

**Windows:**
```bash
create-scheduled-post.bat
```

**Linux/Mac:**
```bash
bash create-scheduled-post.sh
```

## 📊 Monitoring Deployments

### View All Deployments
1. Go to **GitHub Actions** tab
2. See history of all deployments
3. Click any run to see details for all 11 domains

### Check Build Status
Each workflow run shows:
- Which domains were built
- How many files were generated
- Deployment status for each domain
- Any errors or warnings

---

**Your eco-landing repository now automatically builds and deploys ALL landing page domains to Hostinger!** 

Add new domains by simply creating their config files - no workflow changes needed! 🎉
