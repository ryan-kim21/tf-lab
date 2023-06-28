# taraform plan -var AWS_REGION = "us-east-1" 이렇게 확인 해볼 수도 있음.

data "aws_availability_zones" "avilable"{}

data "aws_ami" "latest_ubuntu"{
    most_recent =  true
    owners = [""]

    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
    }

    filter{
        name = "virtualiztion-type"
    }
}

resource "aws_instance" "MyFisrstInstance"{
    ami = data.aws_ami.latest_ubuntu.id
    instance_type = "t2.micro"
    availability_zone = data.aws_availability_zones.avilable.names[1]

    provisioner "local-exec" {
      command = "echo aws_instance.MyFirstInstance.private_ip >> my_private_ips.txt"
    }

    tags = {
        Name = "custom_instance"
    }

    output "public_ip" {
        value = aws_instance.MyFirstInstance.public_ip
    }
}