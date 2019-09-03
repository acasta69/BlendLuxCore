#!/bin/bash

if [[ "$1" == "blender280" ]] ; then
    LUX_VERSION=$VERSION_STRING-blender2.80
    BLC_VERSION=_280
else
    LUX_VERSION=$VERSION_STRING
    git checkout 2_79_maintenance
fi

cd release
python3 ./package_releases.py $VERSION_STRING
