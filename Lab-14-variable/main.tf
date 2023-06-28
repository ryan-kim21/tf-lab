provider "aws"{
    region = "ap-northeast-2"
}

resource "aws_iam_user" "user"{
    for_each = toset(var.aws_users)
    name = each.value
}

resource "aws_instance" "my_server"{
    count = 4
    ami = "ami-"
    instance_type = "t3.micro"

    tags = {
        Name = "Server-${count.index +1}"
        Owner = "Ryan Kim"
    }
}