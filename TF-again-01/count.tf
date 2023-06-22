provider "aws" {
    region = "ap-northeast-2"
  
}

#create 4 instance, tags
resource "aws_instance" "servers" {
    count = 4
    ami = "api-0e472933a1395e172"
    instance_type = "t2-micro"

    tags = {
        Name = "Server Number ${count.index+1}"
    }
  
}



resource "aws_iam_user" "user" {
    count = length(var.aws_users)
    name = element(var.aws_users, count.index)
}

resource "aws_instance" "bastion_server" {
  
}