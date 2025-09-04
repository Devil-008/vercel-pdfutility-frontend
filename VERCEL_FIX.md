# Vercel Deployment - Step by Step Fix

## The Problem
You're getting "Could not find index.html" because Vercel is looking in `/vercel/path0/public` but your React app is in a subdirectory.

## Solution 1: Quick Fix (Update Vercel Settings)

1. **Go to Vercel Dashboard**
2. **Select your project**
3. **Go to Settings → Build & Development Settings**
4. **Update these settings:**
   ```
   Framework Preset: Create React App
   Root Directory: frontend (IMPORTANT!)
   Build Command: npm run build
   Output Directory: build
   Install Command: npm install
   ```

## Solution 2: Create Frontend-Only Repository (Recommended)

Since you're deploying from a monorepo, create a separate frontend repository:

### Step 1: Create the deployment script
```bash
# Run this in your frontend directory
./prepare-deploy.bat
```

### Step 2: Create new GitHub repository
1. Go to GitHub and create new repository: `pdf-management-frontend`
2. Don't initialize with README (you'll push existing code)

### Step 3: Push frontend-only code
```bash
cd pdf-frontend-deploy
git remote add origin https://github.com/Devil-008/pdf-management-frontend.git
git push -u origin main
```

### Step 4: Deploy on Vercel
1. Import the new `pdf-management-frontend` repository
2. Vercel will auto-detect it as Create React App
3. Add environment variables:
   ```
   REACT_APP_API_URL=https://your-backend-url.herokuapp.com
   GENERATE_SOURCEMAP=false
   CI=false
   ```

## Solution 3: Alternative - Deploy Build Folder Manually

1. **Build locally:**
   ```bash
   cd frontend
   npm run build
   ```

2. **Deploy build folder directly:**
   - Drag and drop the `build` folder to Vercel
   - Or use Vercel CLI: `vercel --prod ./build`

## Environment Variables You Need to Set

In Vercel Dashboard → Project → Settings → Environment Variables:

| Name | Value |
|------|-------|
| `REACT_APP_API_URL` | `https://your-backend-url.herokuapp.com` |
| `GENERATE_SOURCEMAP` | `false` |
| `CI` | `false` |

## Why This Happens

- You have both `backend/` and `frontend/` folders
- Vercel looks for `public/index.html` in the root
- But your `index.html` is in `frontend/public/index.html`
- Setting Root Directory to `frontend` fixes this

## Test Locally First

Before deploying, test the build locally:

```bash
cd frontend
npm run build
npx serve -s build
```

If this works, the deployment will work too.

## Quick Commands Summary

```bash
# In frontend directory
npm run build                    # Test build locally
./prepare-deploy.bat            # Create clean deployment repo
# Then deploy the new repo to Vercel
```

The easiest fix is **Solution 1** - just update your Vercel project settings to use `frontend` as the Root Directory!
