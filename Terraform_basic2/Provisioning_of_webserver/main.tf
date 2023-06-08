provider "aws"{
    region  = "ap-northeast-2"
}

resource "aws_instance" "web" {
    ami = "ami-03f54df9441e9b380"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.web.id]
    user_data = templatefile("user_data.sh.tpl",{
        f_name = "Jong"
        l_name = "Kim"
        names = ["jong", "angel","david"]
    })
    tags = {
        Name = "Test webserver"
        Owner = "Jong"
    }
}


resource "aws_security_group" "web" {
    name = "Websever-SG"
    description = "Security group my webserver"

    ingress {
        from_port =80
        to_port = 80
        protocol ="tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    ingress {
        from_port =443
        to_port = 443
        protocol ="tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress{
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        
    }

    tags = {
        Name = "webserver built by terraform"
        owner = "Jong"
    }

}




