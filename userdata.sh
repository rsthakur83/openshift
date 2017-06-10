#!/bin/bash
yum -y install httpd wget git
systemctl start httpd
chmod 777 -R /var/www/html
cd /var/www/html
echo "<html lang="en"><head>" > index.html
echo "<title>Example page</title>" >> index.html
echo "<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">" >> index.html
echo "</head>" >> index.html
echo "<body>" >> index.html
echo "<p><font size="100" color="green"><h1>            GREEN       </h1></p>" >> index.html
echo "</body></html>" >> index.html
