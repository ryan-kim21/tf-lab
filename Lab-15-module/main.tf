provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_vpc" "main"{
    cidr_block = var.vpc_cidr
    tags = {
        Name = "${var.env}-vpc"
        Owner = "Ryan Kim"
    }
}