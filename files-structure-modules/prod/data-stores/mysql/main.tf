terraform {
  required_version = ">= 1.0.8"
  
  backend "s3" {
  bucket         = "devup-terraform-state"
  key            = "prod/data-stores/terraform.tfstate"
  region         = "us-east-1"
  encrypt        = true
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_db_instance" "example" {
  identifier_prefix   = "terraform-up-and-running"
  engine              = "mysql"
  allocated_storage   = 10
  instance_class      = "db.t2.micro"
  name                = var.db_name
  username            = "admin"
  password            = random_string.password.result
  skip_final_snapshot = true
}

resource "random_string" "password" {
  length = 16
  special = true
  override_special = "_%"
}
