# Hostinger Setup Checklist for Eco-Landing

This guide walks you through setting up your Hostinger hosting to work with the automatic deployment system.

## 🎯 Overview

You need to configure:
1. **Domain setup** for your landing pages
2. **FTP access** for GitHub Actions to deploy
3. **Directory structure** for multiple sites
4. **GitHub Secrets** with your Hostinger credentials

---

## 📋 Step 1: Domain Setup in Hostinger

### Add Your Domains
1. **Log into Hostinger Control Panel**
2. Go to **Domains** → **Add Domain**
3. Add these domains (or your chosen domains):
   - `conventionalmortgagebrokers.com`
   - `conventionalmortgageloans.com` 
   - `helocloanofficers.com`

### Domain Configuration Options:

#### Option A: Separate Domains (Recommended)
Each landing page gets its own domain:
```
conventionalmortgagebrokers.com → /domains/conventionalmortgagebrokers.com/public_html/
conventionalmortgageloans.com  → /domains/conventionalmortgageloans.com/public_html/
helocloanofficers.com         → /domains/helocloanofficers.com/public_html/
```

#### Option B: Subdomains
Use subdomains of your main domain:
```
brokers.yourdomain.com → /public_html/brokers/
loans.yourdomain.com   → /public_html/loans/
heloc.yourdomain.com   → /public_html/heloc/
```

#### Option C: Subdirectories
All under one main domain:
```
yourdomain.com/brokers → /public_html/brokers/
yourdomain.com/loans   → /public_html/loans/
yourdomain.com/heloc   → /public_html/heloc/
```

---

## 🔐 Step 2: FTP Access Setup

### Get FTP Credentials
1. In Hostinger Control Panel, go to **Files** → **FTP Accounts**
2. Note down your FTP details:
   - **FTP Server**: Usually `ftp.yourdomain.com` or an IP like `185.xxx.xxx.xxx`
   - **Username**: Your hosting username (e.g., `u123456789`)
   - **Password**: Your hosting password
   - **Port**: Usually `21` (default)

### Test FTP Connection
Before setting up GitHub, test your FTP:
1. Use an FTP client like FileZilla
2. Connect with your credentials
3. Navigate to verify directory structure

---

## 📁 Step 3: Directory Structure Setup

### Check Your Directory Layout
Connect via FTP or File Manager and verify you have:

```
/ (root)
├── public_html/ (main domain)
│   ├── index.html (optional main site)
│   └── subdirectories/ (if using Option C)
├── domains/ (if using separate domains)
│   ├── conventionalmortgagebrokers.com/
│   │   └── public_html/
│   ├── conventionalmortgageloans.com/
│   │   └── public_html/
│   └── helocloanofficers.com/
│       └── public_html/
```

### Create Directories (if needed)
If directories don't exist, create them via:
- **File Manager** in Hostinger Control Panel
- **FTP client** 
- **Terminal** (if available)

---

## 🔑 Step 4: Configure GitHub Secrets

### Required Secrets
Go to your GitHub repository: `https://github.com/nishidshajib/eco-landing/settings/secrets/actions`

Click **"New repository secret"** and add:

#### Essential FTP Credentials:
```
Secret Name: FTP_SERVER
Secret Value: ftp.yourdomain.com (or IP address)

Secret Name: FTP_USERNAME  
Secret Value: u123456789 (your hosting username)

Secret Name: FTP_PASSWORD
Secret Value: your_hosting_password
```

#### Optional Custom Paths (only if needed):
```
Secret Name: BROKERS_FTP_DIR
Secret Value: /domains/conventionalmortgagebrokers.com/public_html/

Secret Name: LOANS_FTP_DIR
Secret Value: /domains/conventionalmortgageloans.com/public_html/

Secret Name: HELOC_FTP_DIR
Secret Value: /domains/helocloanofficers.com/public_html/
```

---

## 🧪 Step 5: Test the Setup

### Manual Test
1. Make a small change to any content file
2. Commit and push:
   ```bash
   git add .
   git commit -m "Test deployment"
   git push origin main
   ```
3. Go to GitHub → Actions tab
4. Watch the deployment workflow run
5. Check your domains to see if files deployed

### Verify Each Domain
Visit your domains and check:
- ✅ Pages load correctly
- ✅ Images and CSS work
- ✅ Navigation functions
- ✅ Blog posts appear

---

## 🔧 Common Hostinger Configurations

### For Hostinger Premium/Business
- FTP Server: `ftp.yourdomain.com`
- Directory: `/domains/yourdomain.com/public_html/`
- Multiple domains supported

### For Hostinger Single/Shared
- FTP Server: Usually an IP address
- Directory: `/public_html/`
- May need subdirectory approach

### For Hostinger VPS/Cloud
- Full control over directory structure
- Can use any configuration option
- May have SSH access available

---

## 🚨 Troubleshooting

### FTP Connection Issues
- **Check server address**: Try both domain and IP
- **Verify credentials**: Test in FTP client first
- **Port settings**: Usually 21, sometimes 2121
- **Passive mode**: Enable in FTP settings

### Directory Permission Issues
- **Ensure write permissions** on target directories
- **Check ownership** (usually your hosting user)
- **Create missing directories** manually if needed

### Deployment Failures
1. Check GitHub Actions logs for specific errors
2. Verify FTP paths match your Hostinger structure
3. Test FTP connection manually
4. Check file permissions in Hostinger

---

## 📞 Need Help?

### Hostinger Support
- **Live Chat**: Available 24/7 in control panel
- **Help Articles**: Search for "FTP setup" or "domain configuration"
- **Community Forum**: Ask hosting-specific questions

### Common Questions to Ask Hostinger Support
1. "What's my exact FTP server address?"
2. "How do I set up multiple domains?"
3. "What's the correct directory structure for my plan?"
4. "How do I enable FTP access?"

---

## ✅ Final Checklist

Before proceeding, ensure you have:

- [ ] Domains added and configured in Hostinger
- [ ] FTP credentials tested and working
- [ ] Directory structure created and accessible
- [ ] GitHub Secrets configured with FTP details
- [ ] Test deployment completed successfully
- [ ] All domains loading your landing pages

Once everything is checked off, your automatic deployment system is fully operational! 🚀

---

*💡 Tip: Keep your FTP credentials secure and never share them. GitHub Secrets are encrypted and safe to use.*