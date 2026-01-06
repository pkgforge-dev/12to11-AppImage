#!/bin/sh

set -eu

ARCH=$(uname -m)
export ARCH
export OUTPATH=./dist
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=DUMMY
export DESKTOP=DUMMY
export DEPLOY_OPENGL=1

# Deploy dependencies
quick-sharun /usr/bin/12to11

# Additional changes can be done in between here

# Turn AppDir into AppImage
quick-sharun --make-appimage
