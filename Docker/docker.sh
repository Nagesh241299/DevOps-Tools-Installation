#!/bin/bash

# Enable debug mode (optional)
#set -x

# Update package list
sudo apt update

# Install dependencies for Docker
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

# Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Add Docker's repository to APT sources
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Update package list again to include Docker packages
sudo apt update

# Install Docker Engine (Community Edition)
sudo apt install -y docker-ce

# Start and enable Docker service
sudo systemctl start docker
sudo systemctl enable docker

# (Optional) Add current user to the docker group to run docker without sudo
sudo usermod -aG docker $USER

# Install Docker Compose (latest version)
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" \
  -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Print Docker and Docker Compose versions to verify installation
docker --version
docker-compose --version

echo "Docker and Docker Compose installation complete!"
echo "You may need to log out and log back in for group changes to take effect."
