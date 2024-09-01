#!/bin/bash

# Define colors for output
RED='\033[0;31m'
NOCOLOR='\033[0m'

# Define the URL of the .deb file
DEB_URL="https://radia-deb-pkg.s3.amazonaws.com/repo/pool/main/r/radia_0.1.0_arm64.deb"

# Define the folder and path where the .deb file will be downloaded
SAVE_DIR="/radia/bin/"
DEB_FILE="$SAVE_DIR/radia_0.1.0_arm64.deb"

# Ensure the directory exists, if not, create it
mkdir -p "$SAVE_DIR"

# Check for required commands
for cmd in wget dpkg systemctl; do
    if ! command -v $cmd &>/dev/null; then
        echo -e "${RED}Error: $cmd command not found. Please install it and try again.${NOCOLOR}"
        exit 1
    fi
done

# Download the .deb file from S3
echo "Downloading .deb file from S3..."
wget -qO "$DEB_FILE" "$DEB_URL"

# Check if the download was successful
if [ $? -ne 0 ]; then
    echo -e "${RED}Error: Failed to download the .deb file. Exiting.${NOCOLOR}"
    exit 1
fi

# Install the .deb file
echo "Installing .deb file..."
sudo dpkg -i "$DEB_FILE"

# Check if the installation was successful
if [ $? -ne 0 ]; then
    echo -e "${RED}Error: Failed to install the .deb file. Quitting installation.${NOCOLOR}"
    exit 1
fi

# Fix missing dependencies
echo "Fixing dependencies..."
sudo apt-get install -f --yes

# Reload systemd to recognize the new service
echo "Reloading systemd..."
sudo systemctl daemon-reload

# Start the service
echo "Starting the Radia client service..."
sudo systemctl start radia

# Enable the service to start on boot
echo "Enabling the Radia client service to start on boot..."
sudo systemctl enable radia

# Check the status of the service
echo "Checking the service status..."
sudo systemctl status radia --no-pager

echo "Installation and startup completed successfully."
