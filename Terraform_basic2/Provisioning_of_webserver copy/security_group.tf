resource "aws_security_group" "web" {
    name = "Websever-SG"
    description = "Security group my webserver"

    ingress {
        from_port =80
        to_port = 80
        protocol ="tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    dynamic "ingress" {
        for_each = ["80","8080", "443","1000","8443"]
        content{
            description = "Allow port HTTP"
            from_port = ingress.value
            to_port = ingress.value
            protocol ="tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
      
    }

    ingress {
        description = "Allow port SSH"
        from_port = 22
        to_port = 22
        protocol ="tcp"
        cidr_blocks = ["10.0.0.0/16"]
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




