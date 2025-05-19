#!/bin/bash

# Update package list
echo "Updating package list..."
sudo apt update -y

# Install Nginx
echo "Installing Nginx..."
sudo apt install nginx -y

# Enable Nginx to start at boot
echo "Enabling Nginx to start on boot..."
sudo systemctl enable nginx

# Start Nginx service
echo "Starting Nginx service..."
sudo systemctl start nginx

# Check Nginx status
echo "Checking Nginx service status..."
sudo systemctl status nginx

# Display Nginx version
echo "Installed Nginx version:"
nginx -v

echo "Nginx installation and setup completed successfully."
