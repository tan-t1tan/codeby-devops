#!/bin/bash

# Sozdaem papku myfolder
mkdir -p ~/myfolder

# file1: vsem privet and data/vremya
echo "DevOps'eram privet, ostalnim soboleznuyu" > ~/myfolder/file1
echo "$(date)" >> ~/myfolder/file1

# fil2: pustoi file 777
touch ~/myfolder/file2
chmod 777 ~/myfolder/file2

# file3: 20 random simvolov
head /dev/urandom | tr -dc A-Za-z0-9 | head -c 20 > ~/myfolder/file3
echo >> ~/myfolder/file3


# file4: pustoi
touch ~/myfolder/file4

# file5: pustoi
touch ~/myfolder/file5

echo "Ura! script1 srabotal!"
