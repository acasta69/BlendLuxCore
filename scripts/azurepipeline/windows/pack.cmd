:: Setting up dependencies

if "%1" EQU "blender280" (
    set LUX_VERSION=%VERSION_STRING%-blender2.80
    set BLC_VERSION=_280
) else (
    set LUX_VERSION=%VERSION_STRING%
    set BLC_VERSION=""
    git checkout 2_79_maintenance
)

:: Set up add-on directory for packing
xcopy . ..\BlendLuxCore%BLC_VERSION% /S /I
rmdir /S /Q ..\BlendLuxCore%BLC_VERSION%\.github
rmdir /S /Q ..\BlendLuxCore%BLC_VERSION%\scripts
del ..\BlendLuxCore%BLC_VERSION%\.gitignore ..\BlendLuxCore%BLC_VERSION%\.travis.yml
cd ..

::==========================================================================
:: Packing OpenCL-less version
::==========================================================================

.\WindowsCompile\support\bin\wget https://github.com/LuxCoreRender/LuxCore/releases/download/latest/luxcorerender-%LUX_VERSION%-win64.zip
7z x luxcorerender-%LUX_VERSION%-win64.zip
python3 .\BlendLuxCore%BLC_VERSION%\bin\get_binaries.py --overwrite .\luxcorerender-%LUX_VERSION%-win64
cp .\oidn-1.0.0.x64.vc14.windows\bin\denoise.exe .\BlendLuxCore%BLC_VERSION%\bin
7z a -tzip BlendLuxCore%BLC_VERSION%-%VERSION_STRING%-win64.zip BlendLuxCore%BLC_VERSION%\ -xr!*.gitignore
cp BlendLuxCore%BLC_VERSION%-%VERSION_STRING%-win64.zip %BUILD_ARTIFACTSTAGINGDIRECTORY%/BlendLuxCore%BLC_VERSION%-%VERSION_STRING%-win64.zip

::==========================================================================
:: Packing OpenCL version
::==========================================================================

.\WindowsCompile\support\bin\wget https://github.com/LuxCoreRender/LuxCore/releases/download/latest/luxcorerender-%LUX_VERSION%-win64-opencl.zip
7z x luxcorerender-%LUX_VERSION%-win64-opencl.zip
python3 .\BlendLuxCore%BLC_VERSION%\bin\get_binaries.py --overwrite .\luxcorerender-%LUX_VERSION%-win64-opencl
cp .\oidn-1.0.0.x64.vc14.windows\bin\denoise.exe .\BlendLuxCore%BLC_VERSION%\bin
7z a -tzip BlendLuxCore%BLC_VERSION%-%VERSION_STRING%-win64-opencl.zip BlendLuxCore%BLC_VERSION%\ -xr!*.gitignore
cp BlendLuxCore%BLC_VERSION%-%VERSION_STRING%-win64-opencl.zip %BUILD_ARTIFACTSTAGINGDIRECTORY%/BlendLuxCore%BLC_VERSION%-%VERSION_STRING%-win64-opencl.zip

rmdir /S /Q BlendLuxCore%BLC_VERSION%
