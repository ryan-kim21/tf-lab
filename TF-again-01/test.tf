resource "aws_instance" "my_server_app" {
  
}


output "web_private_ip"{
    value = aws_instance.my_server_app.private_ip
}