# Quick Reference - Automated Multi-Domain System

## 🚀 For Users: How to Use the System

### Automatic Deployment (Recommended)

**Just push your changes!** Everything is automatic:

```bash
git add .
git commit -m "Update content"
git push origin main
```

All 11 landing pages will automatically:
1. Build with Hugo
2. Deploy to Hostinger
3. Show up live on their domains

### Build Locally (Optional)

```bash
# Build all 11 domains at once
bash scripts/build-all-domains.sh

# View what will deploy where
bash scripts/generate-deployment-map.sh
```

### Add a New Landing Page

1. Create config file: `config/mynewdomain/hugo.toml`
2. Add this content:
   ```toml
   baseURL = 'https://mynewdomain.com/'
   title = 'My New Domain'
   theme = 'heloc-blog'
   contentDir = 'content/mynewdomain'
   publishDir = 'public/mynewdomain'
   ```
3. Create content directory: `content/mynewdomain/`
4. Push to GitHub

**Done!** The system will automatically discover, build, and deploy it.

### Schedule Blog Posts

```bash
# Use the helper script
bash create-scheduled-post.sh

# Follow prompts to create a scheduled post
# It will auto-publish when the date is reached
```

---

## 🛠️ For Developers: How It Works

### Architecture

1. **scripts/build-all-domains.sh**
   - Scans `config/` directory for all domains (excludes `_default`)
   - Builds each domain with `hugo --config --minify --destination`
   - Shows detailed progress and statistics

2. **GitHub Actions Workflows**
   - **deploy.yml**: Main deployment workflow
     - Triggers on push to main
     - Runs build-all-domains.sh
     - Deploys each domain via FTP to Hostinger
   
   - **auto-publish.yml**: Scheduled post publishing
     - Runs hourly to check for scheduled posts
     - Publishes posts when publishdate is reached
     - Rebuilds and redeploys affected domains
   
   - **simple-deploy.yml**: Simplified deployment
     - Builds all domains
     - Deploys to single FTP directory

### Domain Discovery Logic

```bash
# Find all config directories (exclude _default)
CONFIG_DIRS=$(find config -mindepth 1 -maxdepth 1 -type d ! -name "_default" | sort)

# For each domain:
for CONFIG_DIR in $CONFIG_DIRS; do
  DOMAIN_NAME=$(basename "$CONFIG_DIR")
  CONFIG_FILE="$CONFIG_DIR/hugo.toml"
  
  # Extract baseURL
  BASE_URL=$(grep -E "^baseURL" "$CONFIG_FILE" | cut -d"'" -f2)
  
  # Build
  hugo --config "$CONFIG_FILE" --minify --destination "public/$DOMAIN_NAME"
done
```

### FTP Deployment Logic

Each domain deploys to:
```
/domains/{domain-name}/public_html/
```

For example:
- `public/helocloanofficers/` → `/domains/helocloanofficers.com/public_html/`
- `public/mtglenders/` → `/domains/mtglenders.com/public_html/`

Custom paths can be overridden with GitHub secrets:
- `DOMAINNAME_FTP_DIR` (uppercase with underscores)

### Required GitHub Secrets

**Minimum Required (3):**
- `FTP_SERVER` - Hostinger FTP server address
- `FTP_USERNAME` - FTP username
- `FTP_PASSWORD` - FTP password

**Optional (per-domain overrides):**
- `BADCREDITLOANSPECIALIST_FTP_DIR`
- `CONFORMINGMORTGAGELOANS_FTP_DIR`
- `CONVENTIONALMORTGAGEBROKERS_FTP_DIR`
- (etc. for each domain)

### Files Modified

**Workflows:**
- `.github/workflows/deploy.yml` - Now builds and deploys all 11 domains
- `.github/workflows/auto-publish.yml` - Auto-publishes to all domains
- `.github/workflows/simple-deploy.yml` - Simplified deployment

**Scripts:**
- `scripts/build-all-domains.sh` - NEW: Automated build script
- `scripts/generate-deployment-map.sh` - NEW: Deployment map generator

**Hugo:**
- `layouts/index.html` - Fixed template error (.Site.Lastmod → .Site.LastChange)

**Documentation:**
- `DEPLOYMENT.md` - NEW: Comprehensive deployment guide
- `README.md` - Updated with automated system info

### Testing Changes

1. **Test builds locally:**
   ```bash
   bash scripts/build-all-domains.sh
   ```

2. **Check deployment map:**
   ```bash
   bash scripts/generate-deployment-map.sh
   ```

3. **Validate Hugo configs:**
   ```bash
   for config in config/*/hugo.toml; do
     hugo --config "$config" --quiet
   done
   ```

### Adding New Workflow Steps

If you need to add a new domain to the workflows:

**You don't!** The system automatically discovers all domains. Just add the config file and it works.

However, if you need custom FTP paths, add to the workflow:

```yaml
- name: Deploy NewDomain
  if: hashFiles('public/newdomain/**') != ''
  uses: SamKirkland/FTP-Deploy-Action@v4.3.4
  with:
    server: ${{ secrets.FTP_SERVER }}
    username: ${{ secrets.FTP_USERNAME }}
    password: ${{ secrets.FTP_PASSWORD }}
    local-dir: ./public/newdomain/
    server-dir: ${{ secrets.NEWDOMAIN_FTP_DIR || '/domains/newdomain.com/public_html/' }}
```

---

## 📊 Monitoring

### Check Build Status

1. Go to GitHub → **Actions** tab
2. Click on latest workflow run
3. View "Build All Landing Page Domains" step

### Check Deployment Status

Each domain has its own deployment step:
- Expand step to see FTP upload logs
- Check for errors or warnings
- Verify file count uploaded

### Troubleshooting

**Build fails for one domain:**
- Check that domain's Hugo config
- Verify content files are valid markdown
- Look for template errors

**Deploy fails for one domain:**
- Check FTP credentials in GitHub secrets
- Verify Hostinger directory exists
- Check FTP path is correct

**All domains fail:**
- Check Hugo installation in workflow
- Verify scripts have execute permissions
- Check for syntax errors in scripts

---

## 🎯 Best Practices

1. **Always test locally first:**
   ```bash
   bash scripts/build-all-domains.sh
   ```

2. **Use descriptive commit messages:**
   ```bash
   git commit -m "Add new blog post to helocloanofficers domain"
   ```

3. **Check deployment logs** after pushing

4. **Monitor GitHub Actions** for any warnings

5. **Keep baseURL consistent** in config files

---

## 🔗 Resources

- [Hugo Documentation](https://gohugo.io/documentation/)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [FTP-Deploy-Action](https://github.com/SamKirkland/FTP-Deploy-Action)
- [Hostinger Support](https://support.hostinger.com/)

---

**Last Updated:** November 2025  
**System Version:** 1.0 - Fully Automated Multi-Domain
