output "instance_ids"{
    value = aws_instance.server[*].id
}

output "instance_public_ips"{
    value = aws_instance.server[*].public_ip
}


output "my_securitygroup_id" {
    value = aws_security_group.general.id
} // id = "sg-asdldkfjaskldjf" 이런식으로 나옴

output "my_securitygroup_id" {
    value = aws_security_group.general
} //이건 다나옴 all details


output "my_instance_server_priavate_ip" {
    value = aws_instance.my_server_app.private_ip
  //  my_instance_server_priavate_ip ="100.300.100.22"
}