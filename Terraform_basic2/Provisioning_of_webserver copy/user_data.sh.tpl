#!/bin/bash
yum -y update
yum -y install httpd
MYIP=`curl http`
cat <<EOF > /var/www/html/index.html 


echo "<h2> terrfom install </h2>" > /var/www/html/index.html

Server Owner is : ${f_name} ${l_name} <br>
EOF
start httpd start
chkconfig httpd on
