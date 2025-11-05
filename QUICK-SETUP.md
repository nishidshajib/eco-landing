## 🚀 Quick Hostinger Setup for Auto-Deployment

### 1️⃣ Get FTP Details
**Hostinger Control Panel → Files → FTP Accounts**
- Server: `ftp.yourdomain.com` or IP
- Username: `u123456789` (your hosting user)
- Password: Your hosting password

### 2️⃣ Add GitHub Secrets
**GitHub Repo → Settings → Secrets → Actions → New repository secret**

**Required:**
- `FTP_SERVER` = Your FTP server address
- `FTP_USERNAME` = Your hosting username  
- `FTP_PASSWORD` = Your hosting password

### 3️⃣ Domain Structure Options

**Option A - Separate Domains (Recommended):**
```
conventionalmortgagebrokers.com
conventionalmortgageloans.com
helocloanofficers.com
```

**Option B - Subdomains:**
```
brokers.yourdomain.com
loans.yourdomain.com
heloc.yourdomain.com
```

### 4️⃣ Test Deployment
```bash
git add .
git commit -m "Test"
git push origin main
```
Then check GitHub Actions tab!

### 🆘 Need Help?
- Hostinger Live Chat (24/7)
- Check `HOSTINGER-SETUP.md` for detailed guide