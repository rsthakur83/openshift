#!/bin/bash
yum -y install httpd wget git
systemctl start httpd
chmod 777 -R /var/www/html
git init
git clone --depth 1 --branch release-0.05 git://github.com/rsthakur83/release.git
mv release/* /var/www/html
