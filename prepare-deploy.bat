@echo off
echo 🚀 Preparing frontend for Vercel deployment...

:: Create a temporary directory for clean frontend
set TEMP_DIR=pdf-frontend-deploy

if exist "%TEMP_DIR%" (
    rmdir /s /q "%TEMP_DIR%"
)

mkdir "%TEMP_DIR%"

echo 📁 Copying frontend files...

:: Copy all frontend files except node_modules and build
xcopy public "%TEMP_DIR%\public\" /E /I /Q
xcopy src "%TEMP_DIR%\src\" /E /I /Q
copy package.json "%TEMP_DIR%\" >nul
copy package-lock.json "%TEMP_DIR%\" >nul 2>&1
copy .gitignore "%TEMP_DIR%\" >nul
copy .env.example "%TEMP_DIR%\" >nul
copy .env.production "%TEMP_DIR%\" >nul
copy vercel.json "%TEMP_DIR%\" >nul
copy postcss.config.js "%TEMP_DIR%\" >nul
copy tailwind.config.js "%TEMP_DIR%\" >nul
copy README.md "%TEMP_DIR%\" >nul 2>&1
copy DEPLOYMENT.md "%TEMP_DIR%\" >nul 2>&1

echo ✅ Frontend files copied to %TEMP_DIR%

:: Create a new git repository
cd "%TEMP_DIR%"
git init
git add .
git commit -m "Initial commit: Frontend for Vercel deployment"

echo ✅ Git repository initialized

echo.
echo 🎉 Frontend is ready for deployment!
echo.
echo Next steps:
echo 1. Create a new repository on GitHub (e.g., 'pdf-management-frontend')
echo 2. Add the remote origin:
echo    git remote add origin https://github.com/Devil-008/pdf-management-frontend.git
echo 3. Push to GitHub:
echo    git push -u origin main
echo 4. Connect this repository to Vercel
echo 5. Set environment variables in Vercel dashboard
echo.
echo The frontend is now in the '%TEMP_DIR%' directory
echo.
pause
