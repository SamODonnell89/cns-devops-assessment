#!/bin/bash

# Create log file
touch /var/log/bootstrap.log

# Redirect stdout and stderr to the log file
exec > >(tee -a /var/log/bootstrap.log)
exec 2>&1

# Enable exit on error
set -e

echo "Bootstrap script started at $(date)"

# Switch to the ubuntu user
sudo su - ubuntu << EOF
echo "Switched to ubuntu user"

# Update packages and install Nginx
sudo apt-get update

# Kept running into the error:
# E: Could not get lock /var/lib/dpkg/lock-frontend. It is held by process 1636 (apt-get)
# E: Unable to acquire the dpkg frontend lock (/var/lib/dpkg/lock-frontend), is another process using it?
# This checks if apt is running, if it is, we wait (max 10 seconds). Haven't found a better work around yet.

for i in {1..10}
do
    if ps aux | grep -i apt > /dev/null
    then
        echo "Waiting for apt to finish"
        sleep 1
    else
        break
    fi
done

sudo apt-get install -y nginx
echo "Updates complete"

# Start and enable Nginx
sudo systemctl start nginx && sudo systemctl enable nginx
echo "Nginx started and enabled"

# Configure Nginx
echo "server {
    listen 80;
    server_name localhost;
    location /now {
        default_type text/plain;
        return 200 '$(date +%Y-%m-%d\ %H:%M:%S)';
    }
}" | sudo tee /etc/nginx/sites-available/default

# Restart Nginx
sudo systemctl restart nginx
echo "Nginx configuration updated and restarted"
EOF

echo "Bootstrap script completed at $(date)"