#!/bin/bash

# Define colors for output (optional, copy from original script)
# RED='\033[0;31m'
# NOCOLOR='\033[0m'

# Determine the screen session name (modify if different)
SESSION_NAME="radia_session"

# Stop the program running in screen
screen -S "$SESSION_NAME" -X quit

# Uninstall the .deb package
sudo apt-get remove radia --yes

# Optionally: Remove downloaded file and directory
# rm -rf /radia-bin/radia_0.1.0_arm64.deb /radia-bin/

echo "Radia stopped and uninstalled successfully."
