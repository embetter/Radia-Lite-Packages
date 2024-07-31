#!/bin/bash

RED='\033[0;31m'
NOCOLOR='\033[0m'

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <contact_info>"
    exit 1
fi

CONTACT_INFO="$1"

. /etc/os-release

if ! command -v sudo &>/dev/null; then
    echo "Error: sudo command not found. Please make sure that you run the installation command with sudo bin/bash .."
    exit 1
fi

sudo wget -qO- https://deb.dmz.ator.dev/anon.asc | sudo tee /etc/apt/trusted.gpg.d/anon.asc

sudo echo "deb [signed-by=/etc/apt/trusted.gpg.d/anon.asc] https://deb.dmz.ator.dev anon-live-$VERSION_CODENAME main" | sudo tee /etc/apt/sources.list.d/anon.list

sudo apt-get update --yes

sudo apt-get install anon --yes

if [ $? -ne 0 ]; then
    echo -e "${RED}\nFailed to install the Anon package. Quitting installation.\n${NOCOLOR}"
    exit 1
fi

sudo mv /etc/anon/anonrc /etc/anon/anonrc.bak

cat <<EOF | sudo tee /etc/anon/anonrc >/dev/null
Log notice file /var/log/anon/notices.log
ORPort 9001
ControlPort 9051
SocksPort 0
Nickname em000003
Contactinfo $CONTACT_INFO
EOF

sudo systemctl restart anon.service

echo "Anon installation completed successfully."
