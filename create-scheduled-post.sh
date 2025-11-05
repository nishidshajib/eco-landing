#!/bin/bash

# Scheduled Post Creator for Eco-Landing
# This script helps you create posts with scheduled publishing dates

echo "📝 Eco-Landing Scheduled Post Creator"
echo "===================================="

# Function to create a scheduled post
create_scheduled_post() {
    local site_type=$1
    local title="$2"
    local publish_date="$3"
    local author="$4"
    local tags="$5"
    local categories="$6"
    
    # Determine the content directory
    case $site_type in
        "brokers")
            content_dir="content/conventionalmortgagebrokers/blogs"
            ;;
        "loans") 
            content_dir="content/conventionalmortgageloans/blogs"
            ;;
        "heloc")
            content_dir="content/helocloanofficers/blogs"
            ;;
        *)
            content_dir="content/blogs"
            ;;
    esac
    
    # Create directory if it doesn't exist
    mkdir -p "$content_dir"
    
    # Generate filename from title
    filename=$(echo "$title" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/--*/-/g' | sed 's/^-\|-$//g')
    filepath="$content_dir/${filename}.md"
    
    # Check if file already exists
    if [ -f "$filepath" ]; then
        echo "❌ File already exists: $filepath"
        return 1
    fi
    
    # Create the post with front matter
    cat > "$filepath" << EOF
---
title: "$title"
date: $(date -u +"%Y-%m-%dT%H:%M:%SZ")
publishdate: "$publish_date"
draft: true
author: "$author"
tags: [$tags]
categories: [$categories]
description: "Add your post description here"
---

# $title

Write your post content here...

## Introduction

Add your introduction here.

## Main Content

Add your main content here.

## Conclusion

Add your conclusion here.
EOF

    echo "✅ Created scheduled post: $filepath"
    echo "📅 Will be published on: $publish_date"
    return 0
}

# Get user input
echo ""
echo "Select the site type:"
echo "1) Conventional Mortgage Brokers"
echo "2) Conventional Mortgage Loans" 
echo "3) HELOC Loan Officers"
echo "4) Main Site"
echo ""
read -p "Enter choice (1-4): " site_choice

case $site_choice in
    1) site_type="brokers" ;;
    2) site_type="loans" ;;
    3) site_type="heloc" ;;
    4) site_type="main" ;;
    *) echo "❌ Invalid choice"; exit 1 ;;
esac

echo ""
read -p "📝 Post title: " title
if [ -z "$title" ]; then
    echo "❌ Title is required"
    exit 1
fi

echo ""
echo "📅 Publish date (when the post should go live):"
echo "Examples:"
echo "  - 2025-11-06T10:00:00Z (Today at 10 AM UTC)"
echo "  - 2025-11-07T15:30:00Z (Tomorrow at 3:30 PM UTC)"
echo "  - 2025-12-01T08:00:00Z (December 1st at 8 AM UTC)"
echo ""
read -p "🕐 Publish date (YYYY-MM-DDTHH:MM:SSZ): " publish_date

if [ -z "$publish_date" ]; then
    echo "❌ Publish date is required"
    exit 1
fi

# Validate date format
if ! date -d "$publish_date" >/dev/null 2>&1; then
    echo "❌ Invalid date format. Please use: YYYY-MM-DDTHH:MM:SSZ"
    exit 1
fi

echo ""
read -p "👤 Author name [Blog Admin]: " author
author=${author:-"Blog Admin"}

echo ""
read -p "🏷️  Tags (comma-separated): " tags_input
# Format tags for YAML
tags=$(echo "$tags_input" | sed 's/,/", "/g' | sed 's/^/"/' | sed 's/$/"/')

echo ""
read -p "📂 Categories (comma-separated): " categories_input
# Format categories for YAML  
categories=$(echo "$categories_input" | sed 's/,/", "/g' | sed 's/^/"/' | sed 's/$/"/')

echo ""
echo "📋 Post Summary:"
echo "----------------"
echo "Site: $site_type"
echo "Title: $title"
echo "Publish Date: $publish_date"
echo "Author: $author"
echo "Tags: $tags"
echo "Categories: $categories"

echo ""
read -p "✅ Create this scheduled post? (y/N): " confirm

if [[ $confirm =~ ^[Yy]$ ]]; then
    if create_scheduled_post "$site_type" "$title" "$publish_date" "$author" "$tags" "$categories"; then
        echo ""
        echo "🎉 Scheduled post created successfully!"
        echo ""
        echo "📋 Next steps:"
        echo "1. Edit the post content in your preferred editor"
        echo "2. Commit and push to GitHub:"
        echo "   git add ."
        echo "   git commit -m \"Add scheduled post: $title\""
        echo "   git push origin main"
        echo ""
        echo "3. The post will automatically publish on: $publish_date"
        echo "4. GitHub Actions will check every hour and publish when ready"
    fi
else
    echo "❌ Post creation cancelled"
fi