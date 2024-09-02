#!/bin/bash

# Define colors for output
RED='\033[0;31m'
NOCOLOR='\033[0m'

# Define the folder and path where the .deb file was downloaded
SAVE_DIR="/radia/bin/"
DEB_FILE="$SAVE_DIR/radia_0.1.0_arm64.deb"

# Define the package name
PACKAGE_NAME="radia"

# Check for required commands
for cmd in dpkg systemctl; do
    if ! command -v $cmd &>/dev/null; then
        echo -e "${RED}Error: $cmd command not found. Please install it and try again.${NOCOLOR}"
        exit 1
    fi
done

# Stop the service
echo "Stopping the Radia client service..."
sudo systemctl stop radia

# Disable the service from starting on boot
echo "Disabling the Radia client service from starting on boot..."
sudo systemctl disable radia

# Remove the systemd service file if it exists
if [ -f /lib/systemd/system/radia.service ]; then
    echo "Removing the Radia client service file..."
    sudo rm -f /lib/systemd/system/radia.service
    # Reload systemd to reflect changes
    sudo systemctl daemon-reload
fi

# Uninstall the .deb package
echo "Uninstalling the .deb package..."
sudo dpkg -r $PACKAGE_NAME

# Remove the downloaded .deb file
echo "Removing the downloaded .deb file..."
rm -f "$DEB_FILE"

# Optionally, remove any residual files if needed
# echo "Removing residual files..."
# rm -rf /path/to/residual/files
sudo rm -rf /radia /usr/bin/radia

# Clean up any remaining dependencies
echo "Removing unused dependencies..."
sudo apt-get autoremove --yes

echo "Uninstallation completed successfully."
