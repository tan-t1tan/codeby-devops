#!/bin/bash

# Установка Apache
apt-get update
apt-get install -y apache2

# Останавливаем Apache для настройки
systemctl stop apache2

# Создаем директории
mkdir -p /etc/apache2/ssl
mkdir -p /vagrant/provisioning/ssl

# Генерируем SSL сертификат
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /vagrant/provisioning/ssl/aboba.dom.key \
    -out /vagrant/provisioning/ssl/aboba.dom.crt \
    -subj "/C=US/ST=State/L=City/O=Company/CN=aboba.dom"

# Копируем сертификаты
cp /vagrant/provisioning/ssl/aboba.dom.crt /etc/apache2/ssl/
cp /vagrant/provisioning/ssl/aboba.dom.key /etc/apache2/ssl/

# Настройка Apache
cat > /etc/apache2/sites-available/aboba.dom.conf <<EOF
<VirtualHost *:80>
    ServerName aboba.dom
    ServerAlias www.aboba.dom
    Redirect permanent / https://aboba.dom/
</VirtualHost>

<VirtualHost *:443>
    ServerName aboba.dom
    DocumentRoot /var/www/html

    SSLEngine on
    SSLCertificateFile /etc/apache2/ssl/aboba.dom.crt
    SSLCertificateKeyFile /etc/apache2/ssl/aboba.dom.key

    <Directory /var/www/html>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
EOF

# Включаем модули и сайт
a2enmod ssl rewrite
a2ensite aboba.dom.conf
a2dissite 000-default.conf

# Открываем порты
ufw allow 443/tcp
ufw allow 80/tcp

# Проверка и запуск Apache
apache2ctl configtest
systemctl restart apache2
systemctl status apache2

# Проверка работы
ss -tulnp | grep apache2
