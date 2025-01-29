#!/bin/bash

set -e

# Get the latest Go version number
LATEST_VERSION=$(curl -s https://go.dev/VERSION?m=text | grep go)
GO_URL="https://go.dev/dl/${LATEST_VERSION}.linux-amd64.tar.gz"

# Define installation directory
INSTALL_DIR="/usr/local"
GO_BIN="/usr/local/go/bin"

echo "Latest Go version: $LATEST_VERSION"
echo "Downloading Go from: $GO_URL"

# Remove any existing Go installation
if [ -d "$GO_BIN" ]; then
    echo "Removing existing Go installation..."
    sudo rm -rf /usr/local/go
fi

# Download the latest Go tarball
curl -LO "$GO_URL"

# Extract and install
echo "Installing Go..."
sudo tar -C "$INSTALL_DIR" -xzf "${LATEST_VERSION}.linux-amd64.tar.gz"

# Clean up downloaded file
rm "${LATEST_VERSION}.linux-amd64.tar.gz"

# Add Go to PATH if not already added
if ! grep -q 'export PATH=$PATH:/usr/local/go/bin' ~/.bashrc; then
    echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
fi

if ! grep -q 'export PATH=$PATH:/usr/local/go/bin' ~/.profile; then
    echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.profile
fi

echo "Go installation completed. Restart your terminal or run 'source ~/.bashrc' to apply changes."
