#!/bin/bash

# Variables (EDIT THESE!)
MYSQL_USER="nagesh"
MYSQL_PASSWORD="nageshpawar@24121999"

# 1. Update and install MySQL server
sudo apt update
sudo apt install -y mysql-server

# 2. Secure MySQL installation (non-interactive, sets root password to blank and disables remote root)
sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '';"
sudo mysql -e "DELETE FROM mysql.user WHERE User='';"
sudo mysql -e "DROP DATABASE IF EXISTS test;"
sudo mysql -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';"
sudo mysql -e "FLUSH PRIVILEGES;"

# 3. Configure MySQL to listen on all interfaces
sudo sed -i "s/^bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf

# 4. Restart MySQL
sudo systemctl restart mysql

# 5. Create remote user and grant privileges
sudo mysql -u root <<MYSQL_SCRIPT
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON *.* TO '${MYSQL_USER}'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
MYSQL_SCRIPT

# 6. Open MySQL port in the firewall
#sudo ufw allow 3306/tcp
#3306

echo "MySQL installation and public access configuration complete."
echo "Remote user: $MYSQL_USER"
echo "Password: $MYSQL_PASSWORD"
