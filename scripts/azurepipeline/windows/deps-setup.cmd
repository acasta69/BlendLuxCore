:: Setting up dependencies

git clone --branch master https://github.com/LuxCoreRender/WindowsCompile ..\WindowsCompile

:: Copy pipeline scripts to have them available for all branches
xcopy scripts ../scripts /S /I

:: Get Intel OIDN
cd ..
.\WindowsCompile\support\bin\wget https://github.com/OpenImageDenoise/oidn/releases/download/v1.0.0/oidn-1.0.0.x64.vc14.windows.zip
7z x oidn-1.0.0.x64.vc14.windows.zip
