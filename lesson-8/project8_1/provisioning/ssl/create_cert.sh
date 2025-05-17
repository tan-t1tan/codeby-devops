#!/bin/bash
mkdir -p /vagrant/provisioning/ssl
# Create SSL certificate
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /vagrant/provisioning/ssl/aboba.dom.key \
    -out /vagrant/provisioning/ssl/aboba.dom.crt \
    -subj "/C=US/ST=State/L=City/O=Company/CN=aboba.dom"

# Copy certificate to client provisioning directory
cp /vagrant/provisioning/ssl/aboba.dom.crt /vagrant/provisioning/


