#!/bin/bash

# Define colors for output
RED='\033[0;31m'
NOCOLOR='\033[0m'

# Define the URL of the .deb file (change this to your EC2 IP address or domain)
EC2_IP="54.174.127.110"
DEB_URL="http://$EC2_IP/radia_0.1.1_arm64.deb"

# Define the folder and path where the .deb file will be downloaded
SAVE_DIR="/etc/radia/bin/"
DEB_FILE="$SAVE_DIR/radia_0.1.1_arm64.deb"

# Define the folder and path for the config file
CONFIG_DIR="/etc/radia/"
CONFIG_FILE="$CONFIG_DIR/config.json"

# Ensure the directories exist, if not, create them
mkdir -p "$SAVE_DIR"
mkdir -p "$CONFIG_DIR"

# Check for required commands
for cmd in wget dpkg systemctl; do
    if ! command -v $cmd &>/dev/null; then
        echo -e "${RED}Error: $cmd command not found. Please install it and try again.${NOCOLOR}"
        exit 1
    fi
done

# Download the .deb file from EC2 host
echo "Downloading .deb file from EC2..."
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

# Create config.json with predefined content
echo "Creating config.json..."
cat <<EOL > "$CONFIG_FILE"
{
    "device_name": "MerryIoTHotspotV1",
    "os": "debian",
    "architecture": "arm64"
}
EOL

# Check if the config file was created successfully
if [ $? -eq 0 ]; then
    echo "Config file created successfully at $CONFIG_FILE."
else
    echo -e "${RED}Error: Failed to create config file.${NOCOLOR}"
    exit 1
fi

echo "Installation and startup completed successfully."
