resource "aws_instance" "my_server1" {

    depends_on = [ aws_instance.my_server_db ]   //my_server_db 실행 후 실행됨
  
}

resource "aws_instance" "my_server_db" {
    Name = "test "
  
}

