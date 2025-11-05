#!/bin/bash

# Domain Setup Helper Script for Hostinger
# This script helps configure your Hugo sites for automatic domain-based deployment

echo "🚀 Eco-Landing Domain Setup Helper"
echo "=================================="

# Function to update Hugo config baseURL
update_baseurl() {
    local config_file=$1
    local domain=$2
    
    if [ -f "$config_file" ]; then
        echo "📝 Updating $config_file with domain: $domain"
        
        # Backup original file
        cp "$config_file" "$config_file.backup"
        
        # Update or add baseURL
        if grep -q "^baseURL" "$config_file"; then
            sed -i "s|^baseURL.*|baseURL = \"https://$domain\"|g" "$config_file"
        else
            echo "baseURL = \"https://$domain\"" >> "$config_file"
        fi
        
        echo "✅ Updated $config_file"
    else
        echo "❌ Config file not found: $config_file"
    fi
}

# Get domain information
echo ""
echo "Enter your domain names (press Enter for default suggestions):"

# Conventional Mortgage Brokers
echo ""
read -p "🏢 Conventional Mortgage Brokers domain [conventionalmortgagebrokers.com]: " brokers_domain
brokers_domain=${brokers_domain:-conventionalmortgagebrokers.com}

# Conventional Mortgage Loans  
read -p "🏠 Conventional Mortgage Loans domain [conventionalmortgageloans.com]: " loans_domain
loans_domain=${loans_domain:-conventionalmortgageloans.com}

# HELOC Loan Officers
read -p "💰 HELOC Loan Officers domain [helocloanofficers.com]: " heloc_domain
heloc_domain=${heloc_domain:-helocloanofficers.com}

echo ""
echo "🔧 Updating Hugo configuration files..."

# Update configuration files
update_baseurl "config/conventionalmortgagebrokers/hugo.toml" "$brokers_domain"
update_baseurl "config/conventionalmortgageloans/hugo.toml" "$loans_domain"
update_baseurl "config/helocloanofficers/hugo.toml" "$heloc_domain"

echo ""
echo "📋 Hostinger Directory Structure Expected:"
echo "├── /domains/$brokers_domain/public_html/"
echo "├── /domains/$loans_domain/public_html/" 
echo "└── /domains/$heloc_domain/public_html/"

echo ""
echo "🔐 GitHub Secrets to Configure:"
echo "Required:"
echo "  - FTP_SERVER: Your Hostinger FTP server"
echo "  - FTP_USERNAME: Your Hostinger FTP username"
echo "  - FTP_PASSWORD: Your Hostinger FTP password"
echo ""
echo "Optional (if Hostinger uses different paths):"
echo "  - BROKERS_FTP_DIR: /domains/$brokers_domain/public_html/"
echo "  - LOANS_FTP_DIR: /domains/$loans_domain/public_html/"
echo "  - HELOC_FTP_DIR: /domains/$heloc_domain/public_html/"

echo ""
echo "✅ Setup complete! Commit and push these changes to trigger automatic deployment."
echo ""
echo "Next steps:"
echo "1. Configure GitHub Secrets in your repository"
echo "2. Ensure domains are set up in Hostinger"
echo "3. Commit and push changes: git add . && git commit -m 'Configure domains' && git push"