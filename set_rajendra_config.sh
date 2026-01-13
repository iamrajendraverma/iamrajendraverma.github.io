#!/bin/bash

# --- Direct Configuration Script for Local Git User Settings ---

# Define the values you want to set
GIT_NAME="iamrajendra"
GIT_EMAIL="rajendrarajaramv@gmail.com"

echo "--- Git Local Configuration Setter ---"

# 1. Check if the current directory is inside a Git repository
if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    echo "🚨 Error: This script must be run inside a Git repository."
    echo "       Please navigate to your project folder and try again."
    exit 1
fi

# 2. Set the Configuration using the --local flag
# This writes directly to the .git/config file in the current repo.

echo "Setting user.name to: $GIT_NAME"
git config --local user.name "$GIT_NAME"

echo "Setting user.email to: $GIT_EMAIL"
git config --local user.email "$GIT_EMAIL"

# 3. Verify the settings
echo ""
echo "--- Verification (Local Settings) ---"
echo "user.name: $(git config --local user.name)"
echo "user.email: $(git config --local user.email)"

echo ""
echo "✅ Git local configuration updated successfully for this repository."