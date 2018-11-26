#!/bin/bash

DL=${DL:-dl}

mkdir -p $DL
SIMPLICITY_STUDIO_TAG=v4
SIMPLICITY_STUDIO_URL=https://www.silabs.com/documents/login/software/SimplicityStudio-v4.tgz
SIMPLICITY_STUDIO_TAR=${DL}/simplicity-studio-${SIMPLICITY_STUDIO_TAG}.tgz
SIMPLICITY_STUDIO_DIR=simplicity-studio

function downloadApp() {
  echo "Downloading Simplicity Studio"
  curl -SLv ${SIMPLICITY_STUDIO_URL} -o ${SIMPLICITY_STUDIO_TAR}
  mkdir -p ${SIMPLICITY_STUDIO_DIR}
  tar -xzf ${SIMPLICITY_STUDIO_TAR} --strip-components=1 --directory=${SIMPLICITY_STUDIO_DIR}
}

downloadApp
# Create directories that will be used to share data within container and host
mkdir shared workspace

function createLaunchIcon() {
  # Create .desktop file
  if [ ! -d "$HOME/.local/share/applications" ]; then
  	mkdir -p "$HOME/.local/share/applications"
  fi

  # Create desktop icon to easy to launch application
  cat << EOF > "$HOME/.local/share/applications/simplicity-studio.desktop"
[Desktop Entry]
Version=1.0
Type=Application
Terminal=false
Exec=$PWD/run.sh
Name=Simplicity Studio v4
Icon=$PWD/$SIMPLICITY_STUDIO_DIR/icon.xpm
EOF
}
createLaunchIcon

echo "The setup is done. You can now run build.sh to start programming the world :)"
