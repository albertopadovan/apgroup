#!/bin/bash
set -e

# Ensure we're on the source branch
current_branch=$(git branch --show-current)
if [ "$current_branch" != "source" ]; then
    echo "Error: must run from the source branch (currently on '$current_branch')"
    exit 1
fi

# Ensure working tree is clean before switching branches
if ! git diff --quiet || ! git diff --cached --quiet; then
    echo "Error: you have uncommitted changes. Please commit or stash them first."
    exit 1
fi

# Build the site
bundle exec jekyll build || { echo "Jekyll build failed"; exit 1; }

# Copy built site to a temp directory (before switching branches)
tmpdir=$(mktemp -d)
cp -r _site/* "$tmpdir"/

# Switch to gh-pages branch
git checkout gh-pages || { echo "Failed to checkout gh-pages"; rm -rf "$tmpdir"; exit 1; }

# Remove old files
git rm -rf . || true

# Copy built site from temp directory
cp -r "$tmpdir"/* ./
rm -rf "$tmpdir"

# Add .nojekyll to avoid GitHub Pages processing
touch .nojekyll

# Commit and push
git add .
git commit -m "Deploy static site $(date +'%Y-%m-%d %H:%M:%S')"
git push origin gh-pages --force

# Switch back to source branch
git checkout source
