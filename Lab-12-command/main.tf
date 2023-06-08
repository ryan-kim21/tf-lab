provider "aws" {
    region = "ap-northeast-2"
}

resource "null_resource" "command1" {
    provisioner "local-exec" {
        command = "echo Terraform START: $(data) >> log.txt"
      
    }
  
}

resource "null_resource" "command2" {

    provisioner "local-exec" {
        command = "ping -c 5 www.google.com"
      
    }
}

resource "null_resource" "command3" {
    provisioner "local-exec" {
        interprete = ["python", "-C"]
        command = "print('Hello world from python!')"
        
    }
  
}

resource "null_resource" "command4" {
    provisioner "local-exec" {
        commnad = "echo $NAME1 $NAME2 $NAME3 >> names.txt >> log.txt"
        environment ={
            NAME1 = "John"
            NAME2 = "Mark"
            NAME3 = "Donald"
        }      
    }
}


resource "aws_instance" "myserver" {
    ami = "ami-0c9bfc21ac5bf10eb"
    instance_type = "t3.nano"
    provisioner "local-exec" {
        command = "echo ${aws_instance.myserver.private_ip} >> log.txt"
    }
}





resource "null_resource" "command5" {
    provisioner "local-exec" {
        command = "echo Terraform FINISH: $(data) >> log.txt"
      
    }

    depends_on = [ 
        null_resource.command1,
        null_resource.command2,
        null_resource.command3,
        null_resource.command4,
        null_resource.myserver
    ]
  
}














