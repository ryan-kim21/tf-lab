provider "aws" {
    region = "ap-northeast-2"  
}

resource "aws_iam_user" "user"{
    for_each = toset(var.aws_users)
    name = each.value
}


resource "aws_instance" "my_server"{
    count = 4
    ami = ""
    instance_type = "t3.micro"
    tags = {
        Name = "Server-${count.index+1}"
        Owner = ""
    }
}


output "instance_ids"{
    value = aws_instance.my_server[*].id
}

output "instances_publice_ips"{
    value = aws_instance.my_serverp[*].public_ip

}

output "server_id_ip"{
    value = [
        for x in aws_instance.my_server:
        "Server with ID: ${x.id} has public IP: ${x.public_ip}"
    ]
}

output "server_id_ip_map" {
    value = {
        for x in aws_instance.my_server :
        x.id => x.public_ip // "i-12341235" = "15.55.55.55"
    }
  
}

 










