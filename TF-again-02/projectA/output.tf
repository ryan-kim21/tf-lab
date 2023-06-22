output "my_vpc_id"{
    value = module.my_vpc_default.vpc_id
}

output "my_vpc_cidr"{
    value = module.my_vpc_default.vpc_cidr
}
# example 출력값
#my_vpc_cidr = 10.0.0.0/24

output "my_public_subnet_ids"{
    value = module.my_vpc_default.public_subnet_ids
}

output "my_private_subnet_ids"{
    value = module.my_vpc_default.private_subnets_ids
}