#!/bin/bash

# Update system
apt-get update
# apt-get upgrade -y

# Install Apache
apt-get install -y apache2

systemctl stop apache2


# Enable required modules
a2enmod ssl
a2enmod rewrite

# Create directory for SSL certificates
mkdir -p /etc/apache2/ssl


###

mkdir -p /vagrant/provisioning/ssl
# Create SSL certificate
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /vagrant/provisioning/ssl/aboba.dom.key \
    -out /vagrant/provisioning/ssl/aboba.dom.crt \
    -subj "/C=US/ST=State/L=City/O=Company/CN=aboba.dom"

# Copy certificate to client provisioning directory
cp /vagrant/provisioning/ssl/aboba.dom.crt /vagrant/provisioning/


###

# Copy generated certificate (created by create_cert.sh)
cp /vagrant/provisioning/ssl/aboba.dom.crt /etc/apache2/ssl/
cp /vagrant/provisioning/ssl/aboba.dom.key /etc/apache2/ssl/

# Configure Apache
cat > /etc/apache2/sites-available/aboba.dom.conf <<EOF
<VirtualHost *:80>
    ServerName aboba.dom
    ServerAlias www.aboba.dom
    Redirect permanent / https://aboba.dom/
</VirtualHost>

<VirtualHost *:443>
    ServerName aboba.dom
    ServerAlias www.aboba.dom
    DocumentRoot /var/www/html

    SSLEngine on
    SSLCertificateFile /etc/apache2/ssl/aboba.dom.crt
    SSLCertificateKeyFile /etc/apache2/ssl/aboba.dom.key

    <Directory /var/www/html>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    RewriteEngine on
    RewriteCond %{HTTP_HOST} ^www\.aboba\.dom [NC]
    RewriteRule ^(.*)$ https://aboba.dom\$1 [L,R=301]
</VirtualHost>
EOF

# Enable site and disable default
a2ensite aboba.dom.conf
a2dissite 000-default.conf

# Restart Apache
systemctl restart apache2
