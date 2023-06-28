provider "aws" {
    region = "ap-northeast-2"
}

resource "aws_iam_user" "user"{
    for_each = toset(var.aws_users)
    name = each.value
}


variable "aws_users" {
    description = "List of IAM users"
    default = [
        "ttt@ttt.net",
        "ttt@tasdf.com"
    ]
  
}


output "user_arn"{
    value = values(aws_iam_user.user)[*].arn
}