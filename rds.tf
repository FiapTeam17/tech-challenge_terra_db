# configured aws provider with proper credentials
provider "aws" {
  region  = "us-east-2"
  profile = "gabro"
}

# create the rds instance
resource "aws_db_instance" "db_instance" {
  engine                  = "mysql"
  engine_version          = "8.0.31"
  multi_az                = false
  identifier              = "sgr-rds-instance"
  username                = "root"
  password                = "senhamysqlrds"
  instance_class          = "db.t2.micro"
  allocated_storage       = 200
  publicly_accessible     = true
  db_name                 = "sgr_database"
}