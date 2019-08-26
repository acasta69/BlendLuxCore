#!/bin/bash

# Install deps
sudo apt-get -qq update
#sudo apt-get install -y wget libtool git cmake3 g++ flex bison libbz2-dev libopenimageio-dev libtiff5-dev libpng12-dev libgtk-3-dev libopenexr-dev libgl1-mesa-dev python3-dev python3-pip python3-numpy ocl-icd-opencl-dev
sudo apt-get install -y git

# Clone LinuxCompile
#git clone https://github.com/LuxCoreRender/LinuxCompile.git

# Set up correct names for release version
if [[ -z "$VERSION_STRING" ]] ; then
    VERSION_STRING=latest
fi

if [[ "$BLENDER280" == "TRUE" ]] ; then
    VERSION_STRING=$VERSION_STRING-blender2.80
    git checkout blender2.80
    git config user.email "email"
    git config user.name "name"
    git merge --no-commit origin/$BUILD_SOURCEBRANCHNAME
fi

# Set up paths
# cd LinuxCompile

#==========================================================================
# Packing OpenCL-less version"
#==========================================================================

# Clone LuxCore (this is a bit a waste but LinuxCompile procedure
# doesn't work with symbolic links)
# git clone .. LuxCore$SDK_BUILD
# ./build-64-sse2 LuxCore$SDK_BUILD
cd ..
7z a -tzip BlendLuxCore-$VERSION_STRING-linux64.zip $SYSTEM_DEFAULTWORKINGDIRECTORY -x!.git -x!.github -x!.gitignore -x!.travis.yml -x!*.yml -x!scripts -x!auto_load.py
cp BlendLuxCore-$VERSION_STRING-linux64.zip $BUILD_ARTIFACTSTAGINGDIRECTORY/BlendLuxCore-$VERSION_STRING-linux64.zip
# mv target-64-sse2/LuxCore$SDK_BUILD.tar.bz2 $BUILD_ARTIFACTSTAGINGDIRECTORY/luxcorerender-$VERSION_STRING-linux64$SDK_BUILD.tar.bz2

#==========================================================================
# Packing OpenCL version"
#==========================================================================

# Clone LuxCore (this is a bit a waste but LinuxCompile procedure
# doesn't work with symbolic links)
# git clone .. LuxCore-opencl$SDK_BUILD
# ./build-64-sse2 LuxCore-opencl$SDK_BUILD 5
# cp target-64-sse2/LuxCore-opencl$SDK_BUILD.tar.bz2 target-64-sse2/luxcorerender-$VERSION_STRING-linux64-opencl$SDK_BUILD.tar.bz2
# mv target-64-sse2/LuxCore-opencl$SDK_BUILD.tar.bz2 $BUILD_ARTIFACTSTAGINGDIRECTORY/luxcorerender-$VERSION_STRING-linux64-opencl$SDK_BUILD.tar.bz2

# cd ..
