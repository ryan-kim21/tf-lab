module "global" {
  source = "../global_vars"
}

resource "aws_default_vpc" "default" {} # This need to be added since AWS Provider v4.29+ to get VPC id

resource "aws_instance" "web-stag" {
  ami                    = data.aws_ami.latest_amazon_linux.id
  instance_type          = module.global.staging_server_size  //output에 있는 값 가져 올 수 있음
  vpc_security_group_ids = [aws_security_group.web-stag.id]
  user_data              = <<EOF
#!/bin/bash
yum -y update
yum -y install httpd
myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
echo "<h2>STAG WebServer with IP: $myip</h2><br>Build by Terraform!"  >  /var/www/html/index.html
service httpd start
chkconfig httpd on
EOF

  tags = merge({
    Name  = "STAGING WebServer"
    Owner = "Denis Astahov"
  }, module.global.tags)
}