#!/bin/bash

# Variables (edit these for different Tomcat versions)
TOMCAT_VERSION=10.1.26
TOMCAT_MAJOR=10
TOMCAT_USER=tomcat

# 1. Install Java
sudo apt update
sudo apt install -y default-jdk wget

# 2. Create Tomcat user
sudo useradd -m -U -d /opt/tomcat -s /bin/false $TOMCAT_USER

# 3. Download and extract Tomcat
cd /tmp
wget https://dlcdn.apache.org/tomcat/tomcat-${TOMCAT_MAJOR}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz
sudo mkdir -p /opt/tomcat
sudo tar -xzf apache-tomcat-${TOMCAT_VERSION}.tar.gz -C /opt/tomcat --strip-components=1

# 4. Set permissions
sudo chown -R $TOMCAT_USER: /opt/tomcat
sudo chmod -R u+x /opt/tomcat/bin

# 5. Create systemd service file for Tomcat
sudo tee /etc/systemd/system/tomcat.service > /dev/null <<EOF
[Unit]
Description=Apache Tomcat Web Application Container
After=network.target

[Service]
Type=forking

User=$TOMCAT_USER
Group=$TOMCAT_USER

Environment="JAVA_HOME=$(dirname $(dirname $(readlink -f $(which javac))))"
Environment="CATALINA_PID=/opt/tomcat/temp/tomcat.pid"
Environment="CATALINA_HOME=/opt/tomcat"
Environment="CATALINA_BASE=/opt/tomcat"
Environment="CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC"
Environment="JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom"

ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/opt/tomcat/bin/shutdown.sh

[Install]
WantedBy=multi-user.target
EOF

# 6. Reload systemd and start Tomcat
sudo systemctl daemon-reload
sudo systemctl start tomcat
sudo systemctl enable tomcat

echo "Tomcat installation complete!"
echo "Access Tomcat at: http://<$(curl -s ifconfig.me)>:8080"
echo "Private IP: $(hostname -I)"; echo "Public IP: $(curl -s ifconfig.me)"

