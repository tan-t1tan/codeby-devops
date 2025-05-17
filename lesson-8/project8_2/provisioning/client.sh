#!/bin/bash

SERVER_IP=$1

# Update system
apt-get update
apt-get install -y curl netcat ca-certificates


mkdir -p /usr/local/share/ca-certificates/aboba.dom

cp /vagrant/provisioning/ssl/aboba.dom.* /usr/local/share/ca-certificates/aboba.dom
update-ca-certificates --fresh

# Добавляем запись в hosts
echo "${SERVER_IP} aboba.dom" >> /etc/hosts

# Проверяем подключение
curl -I https://aboba.dom
