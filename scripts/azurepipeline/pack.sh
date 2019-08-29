#!/bin/bash

if [[ "$2" == "blender280" ]] ; then
    LUX_VERSION=$VERSION_STRING-blender2.80
    BLC_VERSION=_280
    #git checkout master
else
    LUX_VERSION=$VERSION_STRING
    git checkout 2_79_maintenance
fi

if [[ "$1" == "linux64" ]] ; then
    FILE_EXT=tar.bz2
    UNZIP_CMD='tar -xvjf'
    LUXCORE_DIR=LuxCore
elif [[ "$1" == "win64" ]] ; then
    FILE_EXT=zip
    UNZIP_CMD=unzip
    LUXCORE_DIR=luxcorerender-$LUX_VERSION-$1
fi

# Set up add-on directory for packing
mkdir ../BlendLuxCore$BLC_VERSION
cp -R * ../BlendLuxCore$BLC_VERSION/
rm -rf ../BlendLuxCore$BLC_VERSION/scripts
cd ..

#==========================================================================
# Packing OpenCL-less version
#==========================================================================

wget https://github.com/LuxCoreRender/LuxCore/releases/download/latest/luxcorerender-$LUX_VERSION-$1.$FILE_EXT
$UNZIP_CMD luxcorerender-$LUX_VERSION-$1.$FILE_EXT
python3 ./BlendLuxCore$BLC_VERSION/bin/get_binaries.py --overwrite ./$LUXCORE_DIR
cp ./oidn-1.0.0.x86_64.linux/bin/denoise ./BlendLuxCore$BLC_VERSION/bin
zip -r BlendLuxCore$BLC_VERSION-$VERSION_STRING-$1.zip BlendLuxCore$BLC_VERSION -x .git .github *.gitignore* .travis.yml *.yml
cp BlendLuxCore$BLC_VERSION-$VERSION_STRING-$1.zip $BUILD_ARTIFACTSTAGINGDIRECTORY/BlendLuxCore$BLC_VERSION-$VERSION_STRING-$1.zip

#==========================================================================
# Packing OpenCL version
#==========================================================================

wget https://github.com/LuxCoreRender/LuxCore/releases/download/latest/luxcorerender-$LUX_VERSION-$1-opencl.$FILE_EXT
$UNZIP_CMD luxcorerender-$LUX_VERSION-$1-opencl.$FILE_EXT
python3 ./BlendLuxCore/bin/get_binaries.py --overwrite ./$LUXCORE_DIR-opencl
cp ./oidn-1.0.0.x86_64.linux/bin/denoise ./BlendLuxCore$BLC_VERSION/bin
zip -r BlendLuxCore$BLC_VERSION-$VERSION_STRING-$1-opencl.zip BlendLuxCore$BLC_VERSION -x .git .github *.gitignore* .travis.yml *.yml
cp BlendLuxCore$BLC_VERSION-$VERSION_STRING-$1-opencl.zip $BUILD_ARTIFACTSTAGINGDIRECTORY/BlendLuxCore$BLC_VERSION-$VERSION_STRING-$1-opencl.zip

rm -rf BlendLuxCore$BLC_VERSION
