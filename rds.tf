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

variable "db_instances" {
  description = "Propriedades das instâncias de banco a serem criadas"
  type        = map(object({
    identifier = string
    db_name = string
  }))

default = {
    "db_pedido" = {
      identifier = "sgr-rds-instance-producao"
      db_name = "sgr_database_pedido"
    },
    "db_producao" = {
      identifier = "sgr-rds-instance-producao"
      db_name = "sgr_database_producao"
    }
    # Add more accounts as needed
  }

}

# create the rds instance
resource "aws_db_instance" "mysql_instances" {
  for_each = var.db_instances

  engine              = "mysql"
  engine_version      = "8.0.31"
  multi_az            = false
  identifier          = each.value.identifier
  username            = "root"
  password            = var.mssql_login_pwd
  instance_class      = "db.t2.micro"
  allocated_storage   = 200
  publicly_accessible = true
  db_name             = each.value.db_name
}