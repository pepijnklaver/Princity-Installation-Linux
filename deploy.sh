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
# This will pause and ask you to paste your Agent Key
echo "------------------------------------------------"
echo "Starting Princity Installer..."
echo "Please paste your Agent Key when prompted below:"
echo "------------------------------------------------"
sh ./install_linux.sh

# 5. Start the service using the official binary
echo "Starting Princity-Agent service..."
chmod +x ./Princity-Agent
./Princity-Agent start

echo "------------------------------------------------"
echo "Setup complete. Check your Princity Dashboard!"
echo "------------------------------------------------"
