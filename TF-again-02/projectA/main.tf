provider "aws" {
    region = ap-northeast-2
}


module "my_vpc_default" {
    source = "../modules/aws_network"
}


module "my_vpc_staging" {
    source = "../modules/aws_network"
    env = "staging"
    vpc_cidr = "10.100.0.0/16"
    public_subnet_cidrs = ["10.100.1.0/24","10.100./2.0/24"]
    private_subnets_ids = []
}

module "my_vpc_prod" {
    source = "../modules/aws_network"
    env = "staging"
    vpc_cidr = "10.100.0.0/16"
    public_subnet_cidrs = ["10.200.1.0/24","10.200.2.0/24", "10.200.3.0/24"]
    private_subnets_ids = ["10.200.111.0/24", "10.200.22.0/24", "10.200.33.0/24"]
    tags ={
        Owner = "Ryan Kim"
        Code = "5124131"
        Project = "Project2023"
    }
}


