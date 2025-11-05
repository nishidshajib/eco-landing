# Automatic Post Publishing System

This system allows you to schedule blog posts to be automatically published at specific dates and times. Posts are created as drafts with a `publishdate` field, and GitHub Actions automatically publishes them when the date is reached.

## How It Works

1. **Create Scheduled Posts**: Use scripts to create posts with future publish dates
2. **Hourly Checks**: GitHub Actions runs every hour to check for posts ready to publish
3. **Automatic Publishing**: When a post's `publishdate` is reached, it's automatically published
4. **Auto-Deployment**: Published posts are immediately deployed to your Hostinger domains

## Creating Scheduled Posts

### Using the Helper Scripts

**On Windows:**
```bash
create-scheduled-post.bat
```

**On Linux/Mac:**
```bash
bash create-scheduled-post.sh
```

### Manual Creation

Create a new post file with this front matter structure:

```yaml
---
title: "Your Post Title"
date: 2025-11-05T12:00:00Z
publishdate: "2025-11-06T10:00:00Z"  # When to publish
draft: true                          # Keep as draft until publish date
author: "Your Name"
tags: ["tag1", "tag2"]
categories: ["category1"]
description: "Post description"
---
```

## Publishing Schedule

- **Check Frequency**: Every hour (at the top of the hour)
- **Time Zone**: All times are in UTC
- **Trigger Events**:
  - Scheduled: Every hour automatically
  - Manual: When you push changes to the repository
  - On-demand: Manual workflow trigger

## Post Status Flow

```
Draft Post Created → Scheduled → Published → Deployed
     ↓                 ↓           ↓          ↓
   draft: true    publishdate   draft: false  Live on
                   in future      (auto)     websites
```

## Example Scheduling Scenarios

### 1. Daily Blog Posts
```yaml
# Monday post
publishdate: "2025-11-11T09:00:00Z"  # 9 AM UTC Monday

# Tuesday post  
publishdate: "2025-11-12T09:00:00Z"  # 9 AM UTC Tuesday
```

### 2. Weekly Content
```yaml
# Every Friday
publishdate: "2025-11-08T17:00:00Z"  # 5 PM UTC Friday
publishdate: "2025-11-15T17:00:00Z"  # Next Friday
```

### 3. Special Campaigns
```yaml
# Holiday content
publishdate: "2025-12-24T06:00:00Z"  # Christmas Eve
publishdate: "2025-12-31T23:00:00Z"  # New Year's Eve
```

## Site-Specific Scheduling

Posts are automatically published to the correct site based on their location:

- **`content/conventionalmortgagebrokers/blogs/`** → conventionalmortgagebrokers.com
- **`content/conventionalmortgageloans/blogs/`** → conventionalmortgageloans.com  
- **`content/helocloanofficers/blogs/`** → helocloanofficers.com

## Monitoring & Logs

### Check Publishing Status
1. Go to your GitHub repository
2. Click **Actions** tab
3. Look for "Auto-Publish Scheduled Posts" workflows
4. Click on any run to see detailed logs

### Workflow Triggers
- ✅ **Hourly**: Automatic checks every hour
- ✅ **On Push**: When you update content files
- ✅ **Manual**: Click "Run workflow" button

## Advanced Features

### Batch Publishing
You can schedule multiple posts for the same time:
```yaml
# All publish at the same time
publishdate: "2025-11-06T10:00:00Z"
```

### Timezone Conversion
Convert your local time to UTC for scheduling:
- **EST (UTC-5)**: Add 5 hours to your local time
- **PST (UTC-8)**: Add 8 hours to your local time
- **GMT (UTC+0)**: Use your local time as-is

### Content Updates
You can update scheduled posts before they publish:
1. Edit the post content
2. Keep `draft: true` and the same `publishdate`
3. Push changes - the updated version will publish on schedule

## Troubleshooting

### Post Not Publishing
1. **Check the date format**: Must be `YYYY-MM-DDTHH:MM:SSZ`
2. **Verify draft status**: Must have `draft: true`
3. **Check publishdate**: Must be in the past for immediate publishing
4. **Review logs**: Check GitHub Actions for error messages

### Common Issues
- **Wrong timezone**: Remember to use UTC time
- **Malformed YAML**: Check your front matter syntax
- **Missing publishdate**: Field is required for auto-publishing
- **Future date**: Post won't publish until the date/time is reached

## Time Zone Examples

If you want to publish at 9 AM EST (UTC-5):
```yaml
publishdate: "2025-11-06T14:00:00Z"  # 9 AM EST = 2 PM UTC
```

If you want to publish at 6 PM PST (UTC-8):
```yaml
publishdate: "2025-11-06T02:00:00Z"  # 6 PM PST = 2 AM UTC next day
```

## Benefits

- 🕐 **Automated**: No manual intervention needed
- 📅 **Flexible**: Schedule posts days, weeks, or months in advance  
- 🔄 **Reliable**: Hourly checks ensure timely publishing
- 🚀 **Instant**: Published posts are immediately deployed
- 📊 **Trackable**: Full audit trail in GitHub Actions
- 🌐 **Multi-site**: Works across all your landing page domains

Your eco-landing repository now has a complete automated publishing system! 📝✨