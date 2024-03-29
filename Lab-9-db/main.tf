provider "aws" {
    region = "ap-northeast-2"
}

resource "aws_db_instance" "prod" {

    identifier =  "prod-mysql-rds"
    allocated_storage = 20
    storage_type = "gp2"
    engine = "mysql"
    engine_version = "5.7"
    instance_class = "db.t2.micro"
    parameter_group_name = "default.mysql5.7"
    skip_final_snapshot = true
    apply_immediately = true
    username = "administrator"
    password = data.aws_ssm_parameter.rds_password.value
    
}


// Generate Password
resource "random_password" "main" {

    length = 20
    special = true
    override_special = "#! ()_"
  
}

// Store Password
resource "aws_ssm_parameter" "rds_password" {
  name = "/prod/prod-mysql-rds/password"
  description = "Master Password for RDS Database"
  type = "SecureString"
  value = random_password.main.result
}


data "aws_ssm_parameter" "rds_password"{
    name = "/prod/prod-mysql-rds/password"
    depends_on = [ aws_ssm_parameter.rds_password ]
}


#---

output "rds_address" {
    value=aws_db_instance.prod.address
}
