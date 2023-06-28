variable "env" {
    default = "dev" 
}

variable "vpc_cidr" {
    default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
    default = [
        "10.0.1.0/24",
        "10.0.2.0/24",
    ]
  
}

variable "private_subnets_ids" {
    default =[
        "10.0.11.0/24",
        "10.0.22.0/24",
    ]
  
}

variable "tags" {
    default = {
        Owner = "Ryan Kim"
        Project = "Project2023"
    }
}