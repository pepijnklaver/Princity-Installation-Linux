#!/bin/bash

# 1. Update and Install Java (The only dependency needed)
echo "Installing Java..."
apt update && apt install -y wget unzip openjdk-17-jre-headless

# 2. Setup directory and download agent
echo "Downloading Princity Agent..."
mkdir -p /opt/princity-agent
cd /opt/princity-agent
wget https://vwc.its-printer.com/downloads/agent.zip
unzip -o agent.zip

# 3. Create the remotePanel config (CRITICAL for Remote Panel support)
echo "Enabling Remote Panel flag..."
echo "remotePanel=true" > /opt/princity-agent/agent.config

# 4. Run the interactive installer
echo "------------------------------------------------"
echo "Starting Princity Installer..."
echo "IMPORTANT: Key must be in format XXXX-XXXX-XXXX-XXXX"
echo "------------------------------------------------"

sh ./install_linux.sh </dev/tty

# 5. Start the service using the official binary
echo "Starting Princity-Agent service..."
chmod +x ./princity-agent
./princity-agent start

echo "------------------------------------------------"
echo "Setup complete. Check your Princity Dashboard!"
echo "------------------------------------------------"
