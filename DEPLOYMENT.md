# Automatic Domain-Based Deployment for Hostinger

This setup automatically deploys your landing pages to the correct domains in Hostinger hosting based on your Hugo configuration files.

## How Domain Matching Works

The deployment system automatically detects your domains from:
1. **Hugo config files** (baseURL settings)
2. **GitHub secrets** (if provided)
3. **File structure** (automatic mapping)

### Automatic Domain Structure:
```
eco-landing repository
├── config/conventionalmortgagebrokers/ → conventionalmortgagebrokers.com
├── config/conventionalmortgageloans/  → conventionalmortgageloans.com
└── config/helocloanofficers/         → helocloanofficers.com
```

### Hostinger Directory Structure:
```
Hostinger Hosting
├── /domains/conventionalmortgagebrokers.com/public_html/
├── /domains/conventionalmortgageloans.com/public_html/
└── /domains/helocloanofficers.com/public_html/
```

## Setup Instructions

### Step 1: Hostinger Domain Setup

Make sure your domains are properly configured in Hostinger:
1. **Add your domains** in Hostinger control panel
2. **Point domains** to your hosting account
3. **Note the directory structure** (usually `/domains/yourdomain.com/public_html/`)

### Step 2: GitHub Secrets (Minimal Required)

Go to your GitHub repository → **Settings** → **Secrets and variables** → **Actions**

#### Essential Secrets:
- **FTP_SERVER**: Your Hostinger FTP server (e.g., `files.000webhost.com` or your domain)
- **FTP_USERNAME**: Your Hostinger FTP username  
- **FTP_PASSWORD**: Your Hostinger FTP password

#### Optional Secrets (for custom paths):
- **BROKERS_FTP_DIR**: Custom path for brokers site (if different from auto-detected)
- **LOANS_FTP_DIR**: Custom path for loans site
- **HELOC_FTP_DIR**: Custom path for HELOC site
- **MAIN_FTP_DIR**: Custom path for main site

### Step 3: Domain URLs in Hugo Config

Make sure your Hugo config files have the correct baseURL:

**config/conventionalmortgagebrokers/hugo.toml:**
```toml
baseURL = "https://conventionalmortgagebrokers.com"
```

**config/conventionalmortgageloans/hugo.toml:**
```toml
baseURL = "https://conventionalmortgageloans.com"
```

**config/helocloanofficers/hugo.toml:**
```toml
baseURL = "https://helocloanofficers.com"
```

### Step 3: Test the Deployment

1. Make any small change to your repository (edit a file)
2. Commit and push the changes:
   ```bash
   git add .
   git commit -m "Test automatic deployment"
   git push origin main
   ```
3. Go to your GitHub repository → **Actions** tab
4. Watch the deployment process in real-time

## Deployment Process

When you push changes, the workflow will:

1. ✅ **Checkout** your code
2. ✅ **Setup Hugo** and Node.js
3. ✅ **Install dependencies** (npm packages)
4. ✅ **Build all sites** with Hugo
5. ✅ **Deploy to Hostinger** via FTP
6. ✅ **Notify** you of success/failure

## File Structure on Hostinger

The deployment will create this structure on your Hostinger hosting:

```
/public_html/
├── index.html (main site)
├── blogs/
├── categories/
├── tags/
├── conventionalmortgagebrokers/ (if separate directory)
├── conventionalmortgageloans/ (if separate directory)
└── helocloanofficers/ (if separate directory)
```

## Troubleshooting

### Common Issues:

1. **FTP Connection Failed**
   - Check your FTP credentials in GitHub secrets
   - Verify your Hostinger FTP server address

2. **Hugo Build Failed**
   - Check your Hugo configuration files
   - Ensure all content files are properly formatted

3. **Permission Denied**
   - Verify your FTP username has write permissions
   - Check the server directory path (usually `/public_html/`)

### Checking Deployment Logs:

1. Go to GitHub repository → **Actions** tab
2. Click on the latest workflow run
3. Expand each step to see detailed logs

## Benefits

- 🚀 **Automatic**: No manual FTP uploads needed
- ⚡ **Fast**: Deploys in minutes after pushing changes
- 🔒 **Secure**: FTP credentials stored safely in GitHub secrets
- 📱 **Multi-site**: Handles all your landing pages automatically
- 📊 **Tracking**: See deployment history and logs

## Making Changes

To update your landing pages:

1. Edit your content files locally
2. Test with `hugo server`
3. Commit and push changes
4. GitHub automatically deploys to Hostinger!

That's it! Your eco-landing repository is now set up for automatic deployment to Hostinger hosting.