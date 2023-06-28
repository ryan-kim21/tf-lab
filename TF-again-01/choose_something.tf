variable "env" {
    default = "prod"
}

variable "allow_port" {
  default = {
    prod = ["80", "443"]
    rest = ["80", "443", "8080", "22"]
  }
}


variable "ami_id_per_region" {
    description = "my custom AMI id per Region"
    default = {
        "ap-northeast-2" = "ami-1234555"
        "ap-northeast-3" = "ami-12333333"
    }
  
}


resource "aws_instance" "my_server" {
    ami = var.ami_id_per_region[data.aws_region.current.name]
  
}

resource "aws_security_group" "my_server" {

    name = " test"
    dynamic "ingress" {
        for_each = lookup(var.allow_port, var.env, var.allow_port["rest"]) # default가 dev 일땐 80,443, 8080, 22 / prod 일땐 80, 443 
      
    }
  
}


for_each = var.env == "prod" ? [true] : []
