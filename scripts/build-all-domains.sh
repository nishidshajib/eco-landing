#!/bin/bash

# Build All Landing Pages Automatically
# This script discovers all domain configurations and builds each one

set -e

echo "🚀 Starting automatic multi-domain build process..."
echo ""

# Color codes for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Counter for built sites
BUILT_COUNT=0
FAILED_COUNT=0

# Find all config directories (exclude _default)
CONFIG_DIRS=$(find config -mindepth 1 -maxdepth 1 -type d ! -name "_default" | sort)

if [ -z "$CONFIG_DIRS" ]; then
    echo "❌ No domain configurations found in config/ directory"
    exit 1
fi

echo "📋 Found $(echo "$CONFIG_DIRS" | wc -l) domain configurations:"
echo "$CONFIG_DIRS" | sed 's|config/||' | sed 's/^/  - /'
echo ""

# Build each domain
for CONFIG_DIR in $CONFIG_DIRS; do
    DOMAIN_NAME=$(basename "$CONFIG_DIR")
    CONFIG_FILE="$CONFIG_DIR/hugo.toml"
    
    if [ ! -f "$CONFIG_FILE" ]; then
        echo -e "${YELLOW}⚠️  Skipping $DOMAIN_NAME - no hugo.toml found${NC}"
        continue
    fi
    
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${GREEN}🏗️  Building: $DOMAIN_NAME${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    
    # Extract baseURL from config
    BASE_URL=$(grep -E "^baseURL" "$CONFIG_FILE" | cut -d"'" -f2 | head -1)
    if [ -z "$BASE_URL" ]; then
        BASE_URL=$(grep -E "^baseURL" "$CONFIG_FILE" | cut -d'"' -f2 | head -1)
    fi
    
    echo "  📍 Base URL: $BASE_URL"
    echo "  📂 Config: $CONFIG_FILE"
    echo "  📤 Output: public/$DOMAIN_NAME/"
    echo ""
    
    # Build the site
    if hugo --config "$CONFIG_FILE" --minify --destination "public/$DOMAIN_NAME" 2>&1; then
        echo -e "${GREEN}✅ Successfully built $DOMAIN_NAME${NC}"
        BUILT_COUNT=$((BUILT_COUNT + 1))
        
        # Show stats
        if [ -d "public/$DOMAIN_NAME" ]; then
            HTML_COUNT=$(find "public/$DOMAIN_NAME" -name "*.html" 2>/dev/null | wc -l)
            echo "  📊 Generated $HTML_COUNT HTML files"
        fi
    else
        echo -e "${YELLOW}❌ Failed to build $DOMAIN_NAME${NC}"
        FAILED_COUNT=$((FAILED_COUNT + 1))
    fi
    
    echo ""
done

# Summary
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}📊 Build Summary${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "  ✅ Successfully built: ${GREEN}$BUILT_COUNT${NC} sites"
if [ $FAILED_COUNT -gt 0 ]; then
    echo -e "  ❌ Failed: ${YELLOW}$FAILED_COUNT${NC} sites"
fi

# List all built directories
echo ""
echo "📁 Built public directories:"
if [ -d "public" ]; then
    find public -mindepth 1 -maxdepth 1 -type d | sed 's|public/||' | sort | sed 's/^/  - /'
fi

echo ""
if [ $BUILT_COUNT -gt 0 ]; then
    echo -e "${GREEN}✨ All sites built successfully!${NC}"
    exit 0
else
    echo -e "${YELLOW}⚠️  No sites were built successfully${NC}"
    exit 1
fi
