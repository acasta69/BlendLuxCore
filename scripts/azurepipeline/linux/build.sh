#!/bin/bash

# Install deps
sudo apt-get -qq update
#sudo apt-get install -y wget libtool git cmake3 g++ flex bison libbz2-dev libopenimageio-dev libtiff5-dev libpng12-dev libgtk-3-dev libopenexr-dev libgl1-mesa-dev python3-dev python3-pip python3-numpy ocl-icd-opencl-dev
sudo apt-get install -y git zip wget bzip2

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

# Get Intel OIDN
cd ,,
wget https://github.com/OpenImageDenoise/oidn/releases/download/v1.0.0/oidn-1.0.0.x86_64.linux.tar.gz
tar -xvzf oidn-1.0.0.x86_64.linux.tar.gz
cd $SYSTEM_DEFAULTWORKINGDIRECTORY

#==========================================================================
# Packing OpenCL-less version"
#==========================================================================

# Clone LuxCore (this is a bit a waste but LinuxCompile procedure
# doesn't work with symbolic links)
# git clone .. LuxCore$SDK_BUILD
# ./build-64-sse2 LuxCore$SDK_BUILD
mkdir ../BlendLuxCore
cp -R * ../BlendLuxCore/
rm -rf ../BlendLuxCore/scripts
cd ..
wget https://github.com/LuxCoreRender/LuxCore/releases/download/latest/luxcorerender-$VERSION_STRING-linux64.tar.bz2
tar -xvjf luxcorerender-$VERSION_STRING-linux64.tar.bz2
cp ./LuxCore/lib*.* ./BlendLuxCore/bin
cp ./LuxCore/pyluxcore.so ./BlendLuxCore/bin
cp ./LuxCore/pyluxcoretools.zip ./BlendLuxCore/bin
cp ./oidn-1.0.0.x86_64.linux/bin/denoise ./BlendLuxCore/bin
zip -r BlendLuxCore-$VERSION_STRING-linux64.zip BlendLuxCore -x .git .github *.gitignore* .travis.yml *.yml ./BlendLuxCore/auto_load.py
cp BlendLuxCore-$VERSION_STRING-linux64.zip $BUILD_ARTIFACTSTAGINGDIRECTORY/BlendLuxCore-$VERSION_STRING-linux64.zip

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
