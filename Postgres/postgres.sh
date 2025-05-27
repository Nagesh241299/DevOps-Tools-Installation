#!/bin/bash

# Variables (EDIT THESE!)
PG_USER="nagesh"
PG_PASSWORD="Nagesh@123"
PG_DB="remotedb"

# 1. Update and install PostgreSQL
sudo apt update
sudo apt install -y postgresql postgresql-contrib

# 2. Set the password for the postgres user and create a new user and database
sudo -u postgres psql <<EOF
CREATE USER $PG_USER WITH PASSWORD '$PG_PASSWORD';
CREATE DATABASE $PG_DB OWNER $PG_USER;
GRANT ALL PRIVILEGES ON DATABASE $PG_DB TO $PG_USER;
EOF

# 3. Allow remote connections in postgresql.conf
PG_CONF="/etc/postgresql/$(ls /etc/postgresql)/main/postgresql.conf"
sudo sed -i "s/^#listen_addresses = 'localhost'/listen_addresses = '*'/g" "$PG_CONF"

# 4. Allow remote access in pg_hba.conf
PG_HBA="/etc/postgresql/$(ls /etc/postgresql)/main/pg_hba.conf"
echo "host    all             all             0.0.0.0/0               md5" | sudo tee -a "$PG_HBA" > /dev/null

# 5. Restart PostgreSQL to apply changes
sudo systemctl restart postgresql

# 6. Open PostgreSQL port in the firewall
#sudo ufw allow 5432/tcp

#6. Open PostgreSQL port in the Security group
#5432

echo "PostgreSQL installation and public access configuration complete."
echo "Remote user: $PG_USER"
echo "Password: $PG_PASSWORD"
echo "Database: $PG_DB"
