#!/bin/bash

# Update package list
echo "Updating package list..."
sudo apt update -y

# Install Apache2
echo "Installing Apache..."
sudo apt install apache2 -y

# Enable necessary Apache proxy modules
echo "Enabling mod_proxy modules..."
sudo a2enmod proxy
sudo a2enmod proxy_http
sudo a2enmod proxy_balancer
sudo a2enmod lbmethod_byrequests

# Restart Apache to apply changes
echo "Restarting Apache..."
sudo systemctl restart apache2

# Check Apache status
sudo systemctl status apache2

echo "Apache with mod_proxy setup completed successfully."

echo "Access Apache at: http://<$(curl -s ifconfig.me)>:80"
echo "Private IP: $(hostname -I)"; echo "Public IP: $(curl -s ifconfig.me)"

## Disable default site if needed
#sudo a2dissite 000-default.conf

# Enable your new reverse proxy config
#sudo a2ensite reverse-proxy.conf

# Test Apache config syntax
#sudo apache2ctl configtest

# Restart Apache to apply changes
#sudo systemctl restart apache2