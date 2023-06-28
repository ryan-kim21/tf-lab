provider "aws" {
    region = "ap-northeast-2"
  
}

resource "aws_iam_user" "user" {
    for_each = toset(var.aws_users)
    name = each.value
}

resource "aws_instance" "my_server" {
    for_each = toset["DEV", "STG", "PRD"]
    ami = "ami-0e~~"
    instance_type = "t3.micro"
    tags = {
        Name = "Server-${each.value}"
        Owner = "Ryan Kim"
    }
  
}


resource "aws_instance" "server" {
    for_each = var.server_settings
    ami = each.value["ami"]
    instance_type = each.value["instance_type"]

    root_block_device {
      volume_size = each.value["root_disksize"]
      encrypted = each.value["encrypted"]
    }

    volume_tags = {
      Name = "Disk-${each.key}"
    }

    tags = {
        Name = "Server-${each.key}"
        Owner = "Ryan Kim"
    }
}

resource "aws_instance" "bastion_server" {
    for_each = var.create_bastion == "YES" ? toset(["bastion"]) : [] //yes이면 bastion 실행 아니면 []
    ami = "ami-"
    instance_type = "t3.micro"

    tags = {
        Name = "Bastion Server"
        Owner = "Ryan Kim"
    }
}