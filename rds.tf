terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.52.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
  }
  required_version = ">= 1.1.0"

  cloud {
    organization = "sgr-fiap-17"

    workspaces {
      name = "rds-workspace"
    }
  }
}
provider "aws" {
  region = "us-east-2"
}

# create the rds instance
resource "aws_db_instance" "db_instance" {
  engine              = "mysql"
  engine_version      = "8.0.31"
  multi_az            = false
  identifier          = "sgr-rds-instance"
  username            = "root"
  password            = "senhamysqlrds"
  instance_class      = "db.t2.micro"
  allocated_storage   = 200
  publicly_accessible = true
  db_name             = "sgr_database"
}