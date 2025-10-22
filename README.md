# HELOC Loan Officers Blog - Hugo Setup

A modern Hugo blog system with pagination that automatically generates static blog pages from Markdown files. Features professional pagination, responsive design, and seamless integration with your landing page.

## 📁 Project Structure

```
dynamic-landing/
├── hugo.toml                    # Hugo configuration with pagination
├── content/
│   ├── _index.md               # Homepage content
│   └── posts/                  # Blog posts (Markdown files)
│       ├── heloc-rates-q4-2025.md
│       ├── heloc-closing-costs-explained.md
│       └── [other-posts].md
├── layouts/
│   └── index.html              # Landing page template
├── themes/
│   └── heloc-blog/             # Custom theme
│       ├── layouts/
│       │   ├── _default/
│       │   │   ├── baseof.html # Base template
│       │   │   ├── list.html   # Blog archive with pagination
│       │   │   └── single.html # Individual post template
│       │   └── partials/
│       │       ├── header.html
│       │       └── footer.html
│       └── static/             # Static assets
└── public/                     # Generated static files (output)
```

## 🚀 Quick Start Guide

### Prerequisites

1. **Install Hugo Extended** (if not already installed):
   ```powershell
   # Install using Windows Package Manager
   winget install Hugo.Hugo.Extended
   ```

2. **Navigate to project directory**:
   ```powershell
   cd "C:\Users\Nishi\Desktop\Landing Page\dynamic-landing"
   ```

### Development Server Commands

#### Start Development Server
```powershell
# Add Hugo to PATH (run in each new PowerShell session)
$env:PATH += ";C:\Users\Nishi\AppData\Local\Microsoft\WinGet\Packages\Hugo.Hugo.Extended_Microsoft.Winget.Source_8wekyb3d8bbwe"

# Start server (default port 1313)
hugo server

# Start server on specific port
hugo server --port 1319

# Start server with drafts enabled
hugo server --buildDrafts --port 1319

# Start server with clean build
hugo server --cleanDestinationDir --port 1319
```

#### Development URLs
- **Landing Page**: http://localhost:1319/
- **Blog Archive**: http://localhost:1319/posts/
- **Individual Posts**: http://localhost:1319/blog/[post-slug]/

### Build Commands

#### Production Build
```powershell
# Clean build for production
hugo --cleanDestinationDir

# Build with minification
hugo --minify

# Build including drafts (for staging)
hugo --buildDrafts
```

#### Development Build
```powershell
# Quick build for testing
hugo

# Verbose build (shows detailed output)
hugo --logLevel info
```

### Creating New Blog Posts

1. **Create a new Markdown file** in `content/posts/`:
   ```powershell
   # Navigate to posts directory
   cd content/posts

   # Create new post file
   New-Item "your-post-title.md" -ItemType File
   ```

2. **Add frontmatter** with required fields:
   ```markdown
   ---
   title: "Your Blog Post Title"
   date: 2025-10-22
   draft: false
   category: "Market Trends"
   excerpt: "Brief description of the post (under 200 characters)"
   image: "https://images.unsplash.com/photo-example"
   tags: ["heloc", "market-trends", "financial-planning"]
   readTime: 5
   ---

   Your blog content here using Markdown formatting...

   ## Section Headers
   - Bullet points
   - **Bold text**
   - *Italic text*

   [Link example](https://example.com)
   ```

## 📝 Frontmatter Reference

| Field | Required | Type | Description | Example |
|-------|----------|------|-------------|---------|
| `title` | ✅ Yes | String | Post title (SEO optimized) | `"HELOC Rates Hit New Lows"` |
| `date` | ✅ Yes | Date | Publication date (YYYY-MM-DD) | `2025-10-22` |
| `draft` | ✅ Yes | Boolean | Set to `false` to publish | `false` |
| `category` | ❌ No | String | Display category badge | `"Market Trends"` |
| `excerpt` | ✅ Yes | String | Short description (under 200 chars) | `"Latest HELOC rate analysis..."` |
| `image` | ✅ Yes | URL | Featured image (1600px+ width) | `"https://images.unsplash.com/..."` |
| `tags` | ❌ No | Array | SEO tags (3-5 recommended) | `["heloc", "rates", "trends"]` |
| `readTime` | ❌ No | Number | Estimated reading time (minutes) | `5` |

### Recommended Categories
- `"Market Trends"` - Rate updates, forecasts
- `"Education"` - How-to guides, explanations  
- `"Comparison"` - Product comparisons
- `"Financial Planning"` - Strategy guides
- `"Tax Planning"` - Tax-related content
- `"Investment"` - Investment strategies
- `"Retirement Planning"` - Senior-focused content

## 🔄 Pagination System

The blog features professional pagination with 12 posts per page:

### Configuration
```toml
# In hugo.toml
[pagination]
pagerSize = 12    # Posts per page
path = "page"     # URL path (/posts/page/2/)
```

### Pagination Features
- ✅ **12 posts per page** (configurable)
- ✅ **Page numbers** with current page highlighting
- ✅ **Previous/Next buttons** with proper disabled states  
- ✅ **First/Last page links** when needed
- ✅ **Ellipsis (...)** for large page counts
- ✅ **Responsive design** for all devices
- ✅ **SEO-friendly URLs** (/posts/page/2/, /posts/page/3/)

### URLs
- Page 1: `/posts/` (14 posts → shows 12)
- Page 2: `/posts/page/2/` (remaining 2 posts)

## 🔗 Landing Page Integration

### "View All Articles" Button
The landing page includes a "View All Articles" button that links to `/posts/` (the paginated blog archive).

### JSON Feed Generation
Hugo automatically generates a JSON feed at `/index.json` for API consumption:

```json
[
  {
    "title": "HELOC Rates Hit New Lows",
    "date": "October 22, 2025", 
    "category": "Market Trends",
    "excerpt": "Latest rate analysis and borrower implications...",
    "image": "https://images.unsplash.com/photo-example",
    "permalink": "/blog/heloc-rates-hit-new-lows/",
    "tags": ["heloc", "rates", "market-trends"]
  }
]
```

## 🚀 Deployment Workflow

### Development to Production

1. **Create/Edit Posts**:
   ```powershell
   # Create new post
   New-Item "content/posts/new-post.md" -ItemType File
   # Edit in VS Code or preferred editor
   ```

2. **Test Locally**:
   ```powershell
   # Start development server
   hugo server --port 1319
   # View at http://localhost:1319/posts/
   ```

3. **Build for Production**:
   ```powershell
   # Clean build with minification
   hugo --cleanDestinationDir --minify
   ```

4. **Deploy** - Upload `public/` folder contents:
   ```powershell
   # After build, Hugo generates files in public/ directory
   # Upload CONTENTS of public/ folder (not the folder itself) to your web hosting
   
   # What to upload:
   # ✅ Upload: public/index.html, public/posts/, public/blog/, etc.
   # ❌ Don't upload: The "public" folder itself
   
   # Via FTP/SFTP:
   # Upload everything INSIDE public/ to your domain's root directory
   # Example: public/index.html → yourdomain.com/index.html
   #         public/posts/ → yourdomain.com/posts/
   ```

### 📁 What to Upload After Build

After running `hugo --cleanDestinationDir --minify`, you'll have:

```
public/
├── index.html              # Landing page
├── index.json             # JSON feed
├── sitemap.xml            # SEO sitemap
├── posts/                 # Blog archive pages
│   ├── index.html         # Page 1 of blog
│   └── page/
│       └── 2/
│           └── index.html # Page 2 of blog
├── blog/                  # Individual post pages
│   ├── heloc-rates-hit-new-lows/
│   │   └── index.html
│   └── [other-posts]/
└── [other-generated-files]
```

**🎯 IMPORTANT**: Upload **CONTENTS** of `public/` folder, NOT the folder itself!

### Traditional Web Hosting (cPanel, FTP, etc.)
```powershell
# 1. Build the site
hugo --cleanDestinationDir --minify

# 2. Navigate to public folder
cd public

# 3. Upload ALL files and folders inside public/ to your domain root:
# ✅ Correct: Upload index.html, posts/, blog/, etc. to yourdomain.com/
# ❌ Wrong: Upload public/ folder to yourdomain.com/public/
```

### Automated Deployment Options
- **GitHub Pages**: Push repository, auto-deploy from `public/`
- **Netlify**: Connect repository, auto-build on push
- **Vercel**: Git integration with preview deployments
- **Traditional Hosting**: Manual FTP/SFTP upload of `public/` contents

## ⚙️ Configuration & Customization

### Hugo Configuration (`hugo.toml`)
```toml
baseURL = 'https://helocloanofficers.com/'
languageCode = 'en-us'
title = 'HELOC Loan Officers Blog'
theme = 'heloc-blog'

# Pagination settings
[pagination]
pagerSize = 12        # Posts per page
path = "page"         # URL structure

[params]
description = 'Latest HELOC insights, tips, and guidance'
author = 'Browse Lenders'

# Output formats (includes JSON feed)
[outputs]
home = ["HTML", "RSS", "JSON"]
section = ["HTML", "RSS"]

# URL structure for posts
[permalinks]
posts = '/blog/:slug/'
```

### Theme Customization
```
themes/heloc-blog/
├── layouts/
│   ├── _default/
│   │   ├── baseof.html      # Base HTML structure
│   │   ├── list.html        # Blog archive + pagination
│   │   └── single.html      # Individual post layout
│   └── partials/
│       ├── header.html      # Site header
│       └── footer.html      # Site footer
└── static/                  # CSS, JS, images
```

## 📋 Complete Commands Reference

### Setup Commands
```powershell
# Install Hugo (one-time setup)
winget install Hugo.Hugo.Extended

# Navigate to project
cd "C:\Users\Nishi\Desktop\Landing Page\dynamic-landing"

# Add Hugo to PATH (required each PowerShell session)
$env:PATH += ";C:\Users\Nishi\AppData\Local\Microsoft\WinGet\Packages\Hugo.Hugo.Extended_Microsoft.Winget.Source_8wekyb3d8bbwe"
```

### Development Commands
```powershell
# Basic development server
hugo server

# Development with custom port
hugo server --port 1319

# Include draft posts
hugo server --buildDrafts --port 1319

# Clean build + server
hugo server --cleanDestinationDir --port 1319

# Disable fast render (for debugging)
hugo server --disableFastRender --port 1319

# Check Hugo version
hugo version
```

### Build Commands
```powershell
# Production build
hugo --cleanDestinationDir --minify

# Development build
hugo

# Build with drafts (staging)
hugo --buildDrafts

# Verbose build (debugging)
hugo --logLevel info

# Check site configuration
hugo config
```

### Content Management Commands
```powershell
# Create new post
New-Item "content/posts/post-title.md" -ItemType File

# List all posts
Get-ChildItem "content/posts" -Filter "*.md"

# Count total posts
@(Get-ChildItem "content/posts" -Filter "*.md").Count

# Check for errors in specific post
hugo --logLevel warn
```

### Troubleshooting Commands
```powershell
# Clean everything and rebuild
Remove-Item "public" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "resources" -Recurse -Force -ErrorAction SilentlyContinue  
hugo --cleanDestinationDir

# Check for Hugo updates
winget upgrade Hugo.Hugo.Extended

# Verify Hugo installation
where.exe hugo
hugo env
```

## ✍️ Content Management Workflow

### Adding New Posts
1. **Create file**: `content/posts/descriptive-title.md`
2. **Add frontmatter** (see reference above)
3. **Write content** using Markdown
4. **Test locally**: `hugo server --port 1319`
5. **Build**: `hugo --cleanDestinationDir --minify`

Hugo automatically handles:
- ✅ Individual post page generation
- ✅ Blog archive pagination updates
- ✅ JSON feed updates
- ✅ Tag page creation
- ✅ SEO metadata
- ✅ Sitemap updates

### Content Guidelines

#### Images
- **Resolution**: 1600px+ width minimum
- **Format**: JPG or WebP preferred
- **Source**: Unsplash recommended for stock photos
- **Alt text**: Include descriptive alt text in Markdown

#### SEO Best Practices
- **Titles**: 50-60 characters, include primary keyword
- **Excerpts**: 150-200 characters, compelling summary
- **URLs**: Auto-generated from title (kebab-case)
- **Tags**: 3-5 relevant tags maximum
- **Internal linking**: Link to related posts when relevant

#### Writing Style
- **Scannable**: Use headers, bullet points, short paragraphs
- **Professional**: Authority tone for financial content
- **Actionable**: Include specific tips and guidance
- **Current**: Reference latest market conditions and rates

## 🔧 Troubleshooting

### Common Issues

#### "hugo: command not found"
```powershell
# Solution: Add Hugo to PATH
$env:PATH += ";C:\Users\Nishi\AppData\Local\Microsoft\WinGet\Packages\Hugo.Hugo.Extended_Microsoft.Winget.Source_8wekyb3d8bbwe"
```

#### Pagination not working
```powershell
# Check configuration syntax in hugo.toml
[pagination]
pagerSize = 12    # Not pageSize
path = "page"

# Restart server after config changes
hugo server --port 1319
```

#### Posts not showing
- ✅ Check `draft: false` in frontmatter
- ✅ Verify date is not in the future
- ✅ Ensure file is in `content/posts/` directory
- ✅ Check for frontmatter syntax errors

#### Build errors
```powershell
# Check for detailed error messages
hugo --logLevel info

# Clean build
hugo --cleanDestinationDir
```

### Performance Optimization
- **Images**: Optimize images before adding (use WebP when possible)
- **Minification**: Always use `--minify` for production builds
- **Caching**: Configure proper cache headers on web server
- **CDN**: Use CDN for static assets in production

## 📚 Resources & Documentation

### Hugo Documentation
- **Official Docs**: https://gohugo.io/documentation/
- **Pagination Guide**: https://gohugo.io/templates/pagination/
- **Content Management**: https://gohugo.io/content-management/
- **Deployment Options**: https://gohugo.io/hosting-and-deployment/

### Markdown Reference
- **Basic Syntax**: https://www.markdownguide.org/basic-syntax/
- **Extended Syntax**: https://www.markdownguide.org/extended-syntax/

### Image Resources
- **Unsplash**: https://unsplash.com/ (Free stock photos)
- **Pexels**: https://www.pexels.com/ (Free stock photos)
- **Image Optimization**: https://tinypng.com/ (Compress images)

## 🚀 Quick Deploy Reference

```powershell
# 1. Build for production
hugo --cleanDestinationDir --minify

# 2. Upload contents of public/ folder to your web hosting
# ✅ Upload: Everything INSIDE public/ folder
# ❌ Don't: Upload the public/ folder itself
```

**Files to upload**: `public/index.html`, `public/posts/`, `public/blog/`, etc.  
**Upload destination**: Root directory of your domain (where index.html goes)

## 🎯 Current Site Status

- ✅ **Hugo Version**: v0.151.2 (Extended)
- ✅ **Posts**: 14 total posts
- ✅ **Pagination**: 12 posts per page (2 pages total)  
- ✅ **Development Server**: http://localhost:1319/
- ✅ **Blog Archive**: http://localhost:1319/posts/
- ✅ **Landing Page Integration**: "View All Articles" button linked
- ✅ **JSON Feed**: Available at `/index.json`
- ✅ **SEO Ready**: Sitemap, meta tags, structured URLs
- ✅ **Production Ready**: Build with `hugo --cleanDestinationDir --minify`
