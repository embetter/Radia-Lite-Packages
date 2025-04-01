# Radia-Lite-Packages

## Overview
Radia-Lite-Packages is a package manager designed to install, manage, and run **DePIN (Decentralized Physical Infrastructure Network) projects** on Debian-based devices. It provides an API that allows users to install or uninstall DePIN projects seamlessly.

## Repository Structure

- **`MerryIoTHotspotV1/`**: Contains the installation script that sets up and runs the Radia-Lite API.
- **`anon/`**: A DePIN project that can be managed via Radia-Lite.
- **`gateway-rs/`**: Another DePIN project managed through this package manager.
- **`mawari/`**: DePIN project available for installation.
- **`packet-forwarder/`**: A DePIN project that enables packet forwarding.
- **`postgres/`**: A test environment for development purposes only.
- **`packages.json`**: Defines the available packages and their metadata.

---

## Installation & Setup
To install and run the **Radia-Lite API**, follow these steps:

1. Clone this repository:
   ```sh
   git clone https://github.com/embetter/Radia-Lite-Packages.git
   cd Radia-Lite-Packages/MerryIoTHotspotV1
   ```

2. Run the install script:
   ```sh
   sh install.sh
   ```

3. The Radia-Lite API will now be running and ready to manage DePIN projects on your Debian device.

---

## Using Radia-Lite API
Once installed, the API provides commands to install or uninstall DePIN projects:

- **Install a DePIN project:**
  ```sh
  curl -X POST http://localhost:PORT/install -d '{"package": "gateway-rs"}'
  ```

- **Uninstall a DePIN project:**
  ```sh
  curl -X POST http://localhost:PORT/uninstall -d '{"package": "gateway-rs"}'
  ```

- **List available packages:**
  ```sh
  curl http://localhost:PORT/packages
  ```

Replace `PORT` with the actual running port of the Radia-Lite API.

---

## Deployment on Debian Devices
Radia-Lite is designed for Debian-based devices. Ensure your system meets the following requirements:
- Debian-based OS (Ubuntu, Raspberry Pi OS, etc.)
- Internet access for downloading packages

To deploy, simply follow the **Installation & Setup** steps.

---

## Development & Testing
For development purposes, a **PostgreSQL** environment is included in the repository under `postgres/`. This is used only for testing and does not affect the actual package manager.

---


