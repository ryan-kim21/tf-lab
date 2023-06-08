#!/bin/bash

yum -y update
yum -y install httpd

myip=`curl http://~~`

cat <<EOF > /var/www/html/index.html

<html>
</html>

EOF

service httpd start
chkconfig httpd on