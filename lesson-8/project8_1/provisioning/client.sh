#!/bin/bash

# Update system
apt-get update
# apt-get upgrade -y

# Add domain to hosts file
echo "192.168.121.240 aboba.dom www.aboba.dom" >> /etc/hosts

# Install ca-certificates package
apt-get install -y ca-certificates

# Copy and trust the self-signed certificate
cp /vagrant/provisioning/aboba.dom.crt /usr/local/share/ca-certificates/aboba.dom.crt
update-ca-certificates


update-ca-certificates --fresh

# Test HTTPS connection (optional)
apt-get install -y curl
echo "Testing HTTPS connection to aboba.dom..."
curl -I https://aboba.dom
