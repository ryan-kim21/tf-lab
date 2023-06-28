# terraform {
#   required_version = ">= 1.0"

#   # backend "s3" {
#   #   bucket = ""
#   #   key = "terraform.tfstate"
#     region = "ap-northeast-2"
#   #   dynamodb_table = "test-db-tf-lock"
#   #   encrypt = "true"
#   # }
# }

provider "aws" {
  region = var.aws_region
}

data "aws_availability_zones" "available" {
  exclude_names = ["ap-northeast-2a","ap-northeast-2c"]
}