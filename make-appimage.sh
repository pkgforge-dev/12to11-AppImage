#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q 12to11-git | awk '{print $2; exit}') # example command to get version of application here
export ARCH VERSION
export OUTPATH=./dist
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=DUMMY
export DESKTOP=DUMMY
export MAIN_BIN=12to11
export DEPLOY_OPENGL=1

# Deploy dependencies
quick-sharun /usr/bin/12to11

# Additional changes can be done in between here

# Turn AppDir into AppImage
quick-sharun --make-appimage

# test the final app
quick-sharun --test ./dist/*.AppImage
