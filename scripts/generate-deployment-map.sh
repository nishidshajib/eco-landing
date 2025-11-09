#!/bin/bash

# Generate Deployment Map for All Domains
# This script creates deployment instructions for GitHub Actions

set -e

echo "🗺️  Generating deployment map for all domains..."
echo ""

# Find all config directories (exclude _default)
CONFIG_DIRS=$(find config -mindepth 1 -maxdepth 1 -type d ! -name "_default" | sort)

if [ -z "$CONFIG_DIRS" ]; then
    echo "❌ No domain configurations found"
    exit 1
fi

echo "# Domain Deployment Map"
echo "# Generated: $(date)"
echo ""
echo "| Domain Name | Base URL | FTP Directory | Public Folder |"
echo "|-------------|----------|---------------|---------------|"

# Process each domain
for CONFIG_DIR in $CONFIG_DIRS; do
    DOMAIN_NAME=$(basename "$CONFIG_DIR")
    CONFIG_FILE="$CONFIG_DIR/hugo.toml"
    
    if [ ! -f "$CONFIG_FILE" ]; then
        continue
    fi
    
    # Extract baseURL
    BASE_URL=$(grep -E "^baseURL" "$CONFIG_FILE" | cut -d"'" -f2 | head -1)
    if [ -z "$BASE_URL" ]; then
        BASE_URL=$(grep -E "^baseURL" "$CONFIG_FILE" | cut -d'"' -f2 | head -1)
    fi
    
    # Extract domain from baseURL
    DOMAIN=$(echo "$BASE_URL" | sed 's|https\?://||' | sed 's|www\.||' | sed 's|/.*||')
    
    # Generate FTP path
    FTP_PATH="/domains/${DOMAIN}/public_html/"
    
    # Public folder path
    PUBLIC_PATH="./public/${DOMAIN_NAME}/"
    
    echo "| $DOMAIN_NAME | $BASE_URL | $FTP_PATH | $PUBLIC_PATH |"
done

echo ""
echo ""
echo "📋 Deployment Instructions:"
echo ""
echo "For GitHub Actions, you need these secrets:"
echo "  - FTP_SERVER (your Hostinger FTP server)"
echo "  - FTP_USERNAME (your FTP username)"
echo "  - FTP_PASSWORD (your FTP password)"
echo ""
echo "Optional per-domain FTP directory overrides:"

for CONFIG_DIR in $CONFIG_DIRS; do
    DOMAIN_NAME=$(basename "$CONFIG_DIR")
    CONFIG_FILE="$CONFIG_DIR/hugo.toml"
    
    if [ ! -f "$CONFIG_FILE" ]; then
        continue
    fi
    
    # Convert domain name to uppercase with underscores for secret name
    SECRET_NAME=$(echo "$DOMAIN_NAME" | tr '[:lower:]' '[:upper:]')_FTP_DIR
    
    # Extract baseURL
    BASE_URL=$(grep -E "^baseURL" "$CONFIG_FILE" | cut -d"'" -f2 | head -1)
    if [ -z "$BASE_URL" ]; then
        BASE_URL=$(grep -E "^baseURL" "$CONFIG_FILE" | cut -d'"' -f2 | head -1)
    fi
    
    # Extract domain
    DOMAIN=$(echo "$BASE_URL" | sed 's|https\?://||' | sed 's|www\.||' | sed 's|/.*||')
    
    echo "  - $SECRET_NAME (default: /domains/${DOMAIN}/public_html/)"
done
