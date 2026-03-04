cat << 'EOF' > deploy_princity.sh
#!/bin/bash

# 1. Update and Install Java
echo "Installing Java..."
apt update && apt install -y wget unzip openjdk-17-jre-headless

# 2. Setup directory and download agent
echo "Downloading Princity Agent..."
mkdir -p /opt/princity-agent
cd /opt/princity-agent
wget https://princity.cloud/download/princity-agent.zip -O agent.zip
unzip -o agent.zip

# 3. Create the remotePanel config
echo "Enabling Remote Panel flag..."
echo "remotePanel=true" > /opt/princity-agent/agent.config

# 4. Run the interactive installer to handle the Agent Key
echo "Starting Princity Installer..."
echo "Please enter your Agent Key when prompted below:"
sh ./install_linux.sh

# 5. Start the service
echo "Starting Princity-Agent service..."
chmod +x ./Princity-Agent
./Princity-Agent start

echo "------------------------------------------------"
echo "Setup complete. Verify the agent is online in your dashboard."
echo "------------------------------------------------"
EOF

chmod +x deploy_princity.sh
./deploy_princity.sh
