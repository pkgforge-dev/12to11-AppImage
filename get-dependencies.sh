#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
	gawk         \
	imake        \
	libdrm       \
	libglvnd     \
	libx11       \
	libxcb       \
	libxi        \
	libxkbfile   \
	libxpresent  \
	libxrandr    \
	libxshmfence \
	pixman       \
	wayland

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

# Comment this out if you need an AUR package
#make-aur-package PACKAGENAME

git clone --depth 1 https://git.linuxping.win/12to11/12to11 ./12to11
cd ./12to11
# fix transparency issue with EGL renderer
# this will break compat with nvidia prop driver unfortunately
sed -i \
	-e 's|egl_config_attribs[1] = 32|egl_config_attribs[1] = 24|' \
	-e 's|egl_config_attribs[9] = 8|egl_config_attribs[9] = 0|'   \
	./egl.c
xmkmf
make
install -Dm755 12to11 /usr/bin/12to11
git rev-parse --short HEAD > ~/version
