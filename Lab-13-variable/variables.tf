variable "aws_users" {
    description = "List of IAM Users to create"
    default = [
        "ryan.kim@wavve.com",
        "rrr@gttt.com"
    ]
  
}

variable "server_settings" {
    type = map(any)
    default = {
      web={
        ami = "ami-"
        instance_size = "t3.small"
        root_disksize = 20
        encrypted = true
      }

    app = {
        ami  = ""
        instance_size = "t3.micro"
        root_disksize = 10
        encrypted = false
      }
    }
}

variable "create_bastion" {
    description = "Provision Bastion Server YES/NO"
    default = "YES"
}