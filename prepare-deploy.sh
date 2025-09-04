#!/bin/bash

# Script to prepare frontend for Vercel deployment
# This creates a clean frontend-only structure

echo "🚀 Preparing frontend for Vercel deployment..."

# Create a temporary directory for clean frontend
TEMP_DIR="pdf-frontend-deploy"

if [ -d "$TEMP_DIR" ]; then
    rm -rf "$TEMP_DIR"
fi

mkdir "$TEMP_DIR"

echo "📁 Copying frontend files..."

# Copy all frontend files except node_modules and build
cp -r public "$TEMP_DIR/"
cp -r src "$TEMP_DIR/"
cp package.json "$TEMP_DIR/"
cp package-lock.json "$TEMP_DIR/" 2>/dev/null || echo "No package-lock.json found"
cp .gitignore "$TEMP_DIR/"
cp .env.example "$TEMP_DIR/"
cp .env.production "$TEMP_DIR/"
cp vercel.json "$TEMP_DIR/"
cp postcss.config.js "$TEMP_DIR/"
cp tailwind.config.js "$TEMP_DIR/"
cp README.md "$TEMP_DIR/" 2>/dev/null || echo "No README.md found"
cp DEPLOYMENT.md "$TEMP_DIR/" 2>/dev/null || echo "No DEPLOYMENT.md found"

echo "✅ Frontend files copied to $TEMP_DIR"

# Create a new git repository
cd "$TEMP_DIR"
git init
git add .
git commit -m "Initial commit: Frontend for Vercel deployment"

echo "✅ Git repository initialized"

echo ""
echo "🎉 Frontend is ready for deployment!"
echo ""
echo "Next steps:"
echo "1. Create a new repository on GitHub (e.g., 'pdf-management-frontend')"
echo "2. Add the remote origin:"
echo "   git remote add origin https://github.com/Devil-008/pdf-management-frontend.git"
echo "3. Push to GitHub:"
echo "   git push -u origin main"
echo "4. Connect this repository to Vercel"
echo "5. Set environment variables in Vercel dashboard"
echo ""
echo "The frontend is now in the '$TEMP_DIR' directory"
