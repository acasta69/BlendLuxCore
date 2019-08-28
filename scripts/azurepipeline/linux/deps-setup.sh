#!/bin/bash

# Install deps
sudo apt-get -qq update
#sudo apt-get install -y wget libtool git cmake3 g++ flex bison libbz2-dev libopenimageio-dev libtiff5-dev libpng12-dev libgtk-3-dev libopenexr-dev libgl1-mesa-dev python3-dev python3-pip python3-numpy ocl-icd-opencl-dev
sudo apt-get install -y git zip wget bzip2

# Get Intel OIDN
cd ..
wget https://github.com/OpenImageDenoise/oidn/releases/download/v1.0.0/oidn-1.0.0.x86_64.linux.tar.gz
tar -xvzf oidn-1.0.0.x86_64.linux.tar.gz
