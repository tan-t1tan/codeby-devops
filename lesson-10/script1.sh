#!/bin/bash
mkdir -p ~/myfolder
echo "DevOps'eram privet, ostalnim soboleznuyu" > ~/myfolder/file1
echo "$(date)" >> ~/myfolder/file1
touch ~/myfolder/file2
chmod 777 ~/myfolder/file2
head /dev/urandom | tr -dc A-Za-z0-9 | head -c 20 > ~/myfolder/file3
echo >> ~/myfolder/file3
touch ~/myfolder/file4
touch ~/myfolder/file5
