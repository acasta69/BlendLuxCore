#!/bin/bash

if [[ "$1" == "blender280" ]] ; then
    LUX_VERSION=$VERSION_STRING-blender2.80
    BLC_VERSION=_280
else
    LUX_VERSION=$VERSION_STRING
    git checkout 2_79_maintenance
fi

# Set up add-on directory for packing
mkdir ../BlendLuxCore$BLC_VERSION
cp -R * ../BlendLuxCore$BLC_VERSION/
rm -rf ../BlendLuxCore$BLC_VERSION/scripts
cd ..

#==========================================================================
# Packing OpenCL-less version
#==========================================================================

wget https://github.com/LuxCoreRender/LuxCore/releases/download/latest/luxcorerender-$LUX_VERSION-linux64.tar.bz2
tar -xvjf luxcorerender-$LUX_VERSION-linux64.tar.bz2
python3 ./BlendLuxCore$BLC_VERSION/bin/get_binaries.py --overwrite ./LuxCore
cp ./oidn-1.0.0.x86_64.linux/bin/denoise ./BlendLuxCore$BLC_VERSION/bin
zip -r BlendLuxCore$BLC_VERSION-$VERSION_STRING-linux64.zip BlendLuxCore$BLC_VERSION -x .git .github *.gitignore* .travis.yml *.yml
cp BlendLuxCore$BLC_VERSION-$VERSION_STRING-linux64.zip $BUILD_ARTIFACTSTAGINGDIRECTORY/BlendLuxCore$BLC_VERSION-$VERSION_STRING-linux64.zip

#==========================================================================
# Packing OpenCL version
#==========================================================================

wget https://github.com/LuxCoreRender/LuxCore/releases/download/latest/luxcorerender-$LUX_VERSION-linux64-opencl.tar.bz2
tar -xvjf luxcorerender-$LUX_VERSION-linux64-opencl.tar.bz2
python3 ./BlendLuxCore/bin/get_binaries.py --overwrite ./LuxCore-opencl
cp ./oidn-1.0.0.x86_64.linux/bin/denoise ./BlendLuxCore$BLC_VERSION/bin
zip -r BlendLuxCore$BLC_VERSION-$VERSION_STRING-linux64-opencl.zip BlendLuxCore$BLC_VERSION -x .git .github *.gitignore* .travis.yml *.yml
cp BlendLuxCore$BLC_VERSION-$VERSION_STRING-linux64-opencl.zip $BUILD_ARTIFACTSTAGINGDIRECTORY/BlendLuxCore$BLC_VERSION-$VERSION_STRING-linux64-opencl.zip

rm -rf BlendLuxCore$BLC_VERSION
