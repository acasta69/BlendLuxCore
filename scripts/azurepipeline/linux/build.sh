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
cd ..
wget https://github.com/OpenImageDenoise/oidn/releases/download/v1.0.0/oidn-1.0.0.x86_64.linux.tar.gz
tar -xvzf oidn-1.0.0.x86_64.linux.tar.gz
cd $SYSTEM_DEFAULTWORKINGDIRECTORY

# Set up add-on directory for packing
mkdir ../BlendLuxCore
cp -R * ../BlendLuxCore/
rm -rf ../BlendLuxCore/scripts
cd ..

#==========================================================================
# Packing OpenCL-less version
#==========================================================================

wget https://github.com/LuxCoreRender/LuxCore/releases/download/latest/luxcorerender-$VERSION_STRING-linux64.tar.bz2
tar -xvjf luxcorerender-$VERSION_STRING-linux64.tar.bz2
# cp ./LuxCore/lib*.* ./BlendLuxCore/bin
# cp ./LuxCore/pyluxcore.so ./BlendLuxCore/bin
# cp ./LuxCore/pyluxcoretools.zip ./BlendLuxCore/bin
python3 ./BlendLuxCore/bin/get_binaries.py ./LuxCore
cp ./oidn-1.0.0.x86_64.linux/bin/denoise ./BlendLuxCore/bin
zip -r BlendLuxCore-$VERSION_STRING-linux64.zip BlendLuxCore -x .git .github *.gitignore* .travis.yml *.yml ./BlendLuxCore/auto_load.py
cp BlendLuxCore-$VERSION_STRING-linux64.zip $BUILD_ARTIFACTSTAGINGDIRECTORY/BlendLuxCore-$VERSION_STRING-linux64.zip

#==========================================================================
# Packing OpenCL version
#==========================================================================

wget https://github.com/LuxCoreRender/LuxCore/releases/download/latest/luxcorerender-$VERSION_STRING-linux64-opencl.tar.bz2
tar -xvjf luxcorerender-$VERSION_STRING-linux64-opencl.tar.bz2
# cp ./LuxCore/lib*.* ./BlendLuxCore/bin
# cp ./LuxCore/pyluxcore.so ./BlendLuxCore/bin
# cp ./LuxCore/pyluxcoretools.zip ./BlendLuxCore/bin
python3 ./BlendLuxCore/bin/get_binaries.py ./LuxCore-opencl
cp ./oidn-1.0.0.x86_64.linux/bin/denoise ./BlendLuxCore/bin
zip -r BlendLuxCore-$VERSION_STRING-linux64-opencl.zip BlendLuxCore -x .git .github *.gitignore* .travis.yml *.yml ./BlendLuxCore/auto_load.py
cp BlendLuxCore-$VERSION_STRING-linux64-opencl.zip $BUILD_ARTIFACTSTAGINGDIRECTORY/BlendLuxCore-$VERSION_STRING-linux64-opencl.zip

