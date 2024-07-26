#!/bin/bash

# URL of the WordPress latest ZIP file
url="https://wordpress.org/latest.zip"

# Download the ZIP file
curl -o latest.zip $url

# Unzip the downloaded file in the current directory
unzip latest.zip

# Optionally, remove the ZIP file after unzipping
rm latest.zip

# Prompt the user for database details
read -p "Enter database name: " db_name
read -p "Enter database user: " db_user
read -sp "Enter database password: " db_password
echo
# Create or overwrite the .env file with the provided details
cat <<EOL > .env
export DB_NAME=$db_name
export DB_USER=$db_user
export DB_PASSWORD=$db_password
export DB_HOST=db
EOL

echo ".env file created successfully."
bash .env

echo "updating wp-config file"
cd wordpress
mv wp-config-sample.php wp-config.php

# Load the database details from the .env file
if [ -f ../.env ]; then
  export $(cat ../.env | xargs)
else
  echo ".env file not found!"
  exit 1
fi

# Check if wp-config.php exists
if [ ! -f wp-config.php ]; then
  echo "wp-config.php not found!"
  exit 1
fi

# Update wp-config.php with the database details
sed -e "s/database_name_here/$DB_NAME/;s/username_here/$DB_USER/;s/password_here/$DB_PASSWORD/;s/localhost/$DB_HOST/" wp-config.php > /tmp/tempfile.tmp
mv /tmp/tempfile.tmp wp-config.php
echo "wp-config.php updated successfully."
echo "wordpress files ready to be deployed"
echo "run: docker-compose up -d to proceed with deploying wordpress app container"