#!/bin/bash

# Exit on error
set -e

echo "🔄 Deleting local gh-pages branch if exists..."
git branch -D gh-pages 2>/dev/null || true

echo "🌿 Creating orphan gh-pages branch..."
git checkout --orphan gh-pages

echo "🧹 Removing all files except .git, dist/, node_modules/..."
find . -mindepth 1 -maxdepth 1 \
  ! -name '.git' \
  ! -name '.gitignore' \
  ! -name '.env' \
  ! -name 'node_modules' \
  ! -name 'dist' \
  ! -name 'deploy.sh' \
  -exec rm -rf {} +

echo "📂 Copying contents of dist/ to root..."
cp -r dist/* ./
rm -rf dist/

echo "➕ Adding files to git..."
git add .

echo "✅ Committing..."
git commit -m "🚀 Deploy to GitHub Pages"

echo "📤 Pushing to gh-pages branch (force)..."
git push -f origin gh-pages

echo "✅ Deployment complete!"
