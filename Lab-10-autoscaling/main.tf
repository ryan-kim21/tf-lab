#------------------------------------------------------------------
#  Terraform - From Zero to Certified Professional
#
# Provision Highly Availabe Web Cluster in any Region Default VPC
# Create:
#    - Security Group for Web Server and ALB
#    - Launch Template with Auto AMI Lookup
#    - Auto Scaling Group using 2 Availability Zones
#    - Application Load Balancer in 2 Availability Zones
#    - Application Load Balancer TargetGroup
# Update to Web Servers will be via Green/Blue Deployment Strategy
# Developed by Ryan Kim
#------------------------------------------------------------------
provider "aws" {
  region = "ap-northeast-2"

  default_tags {
    tags = {
      Owner     = "Ryan Kim"
      CreatedBy = "Terraform"
      Course    = "From Zero to Certified Professional"
    }
  }
}


data "aws_availability_zones" "working" {}

data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}



