# PDF Management Frontend - Vercel Deployment Guide

## Quick Fix for Current Error

The error "Could not find a required file. Name: index.html" occurs because Vercel is looking in the wrong directory. Here are the solutions:

### Option 1: Deploy Frontend Only (Recommended)

1. **Create a new repository for frontend only:**
   ```bash
   # Create a new repo on GitHub called "pdf-management-frontend"
   # Then copy only the frontend files
   ```

2. **Copy frontend files to new repo:**
   ```bash
   cp -r frontend/* /path/to/new/pdf-management-frontend/
   cd /path/to/new/pdf-management-frontend/
   git init
   git add .
   git commit -m "Initial frontend deployment"
   git remote add origin https://github.com/Devil-008/pdf-management-frontend.git
   git push -u origin main
   ```

3. **Connect the new repo to Vercel**

### Option 2: Use Root Directory Configuration

If you want to deploy from the current repo structure, update your Vercel project settings:

1. **In Vercel Dashboard:**
   - Go to Project Settings
   - Build & Development Settings
   - Root Directory: `frontend`
   - Build Command: `npm run build`
   - Output Directory: `build`
   - Install Command: `npm install`

### Option 3: Create Deployment Script

Use this script to prepare for deployment:

```bash
# Create a deployment branch with only frontend
git checkout -b frontend-deploy
git filter-branch --subdirectory-filter frontend
git push origin frontend-deploy
```

Then deploy the `frontend-deploy` branch on Vercel.

## Environment Variables for Vercel

Add these environment variables in your Vercel project settings:

```
REACT_APP_API_URL=https://your-backend-url.herokuapp.com
GENERATE_SOURCEMAP=false
CI=false
```

## Backend URL Configuration

Update the `REACT_APP_API_URL` in your environment variables to point to your deployed backend:

- **Heroku**: `https://your-app-name.herokuapp.com`
- **Railway**: `https://your-app-name.up.railway.app`
- **Render**: `https://your-app-name.onrender.com`

## Build Settings for Vercel

```json
{
  "buildCommand": "npm run build",
  "outputDirectory": "build",
  "installCommand": "npm install"
}
```

## Troubleshooting

### Common Issues:

1. **"Could not find index.html"**
   - Solution: Set Root Directory to `frontend` in Vercel settings

2. **Build fails with lint errors**
   - Solution: The build script already includes `CI=false` to ignore warnings

3. **API calls fail**
   - Solution: Update `REACT_APP_API_URL` environment variable

4. **Routing doesn't work**
   - Solution: The `vercel.json` file already includes SPA routing configuration

## Recommended Deployment Steps:

1. Create a separate repository for frontend
2. Copy all files from the `frontend` folder to the new repo
3. Connect the new repo to Vercel
4. Set environment variables in Vercel dashboard
5. Deploy!

## Alternative: One-Click Deploy

You can also use this button once you create a frontend-only repository:

[![Deploy with Vercel](https://vercel.com/button)](https://vercel.com/new)

## Files Ready for Deployment:

- ✅ `vercel.json` - Vercel configuration
- ✅ `package.json` - Build scripts configured
- ✅ `.env.production` - Production environment template
- ✅ `public/index.html` - Required entry point
- ✅ Build optimizations applied
