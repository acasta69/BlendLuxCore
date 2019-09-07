#!/bin/bash

echo "VERSION_STRING is $VERSION_STRING"

if [[ "$1" == "blender280" ]] ; then
    LUX_VERSION=$VERSION_STRING-blender2.80
    BLC_VERSION=280
else
    LUX_VERSION=$VERSION_STRING
    git checkout 2_79_maintenance
fi

cd release
python3 ./package_releases.py $VERSION_STRING $BLC_VERSION
