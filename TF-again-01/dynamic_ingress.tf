resource "aws_security_group" "general" {
    name = "My Security Group"
    dynamic "ingress" {
        for_each = ["80", "443", "22", "3389"]

        content {
            from_port = ingress.value
            to_port = ingress.value
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
      
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "My SecurityGroup"
    }
  
}