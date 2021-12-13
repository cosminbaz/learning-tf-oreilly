terraform {
  required_version = ">= 1.0.8"
  
  backend "s3" {
  bucket         = "devup-terraform-state"
  key            = "prod/webserver-cluster/terraform.tfstate"
  region         = "us-east-1"
  encrypt        = true
  }
}

provider "aws" {
  region = "us-east-1"
}

module "webserver_cluster" {
  source = "../../../modules/services/webserver-cluster"

  cluster_name           = var.cluster_name
  db_remote_state_bucket = var.db_remote_state_bucket
  db_remote_state_key    = var.db_remote_state_key

  instance_type = "t2.micro"
  min_size      = 1
  max_size      = 2
}

resource "aws_autoscaling_schedule" "scale_out_during_business_hours" {
  scheduled_action_name = "scale-out-during-business-hours"
  min_size              = 1
  max_size              = 2
  desired_capacity      = 1
  recurrence            = "0 9 * * *"

  autoscaling_group_name = module.webserver_cluster.asg_name
}

resource "aws_autoscaling_schedule" "scale_in_at_night" {
  scheduled_action_name = "scale-in-at-night"
  min_size              = 1
  max_size              = 2
  desired_capacity      = 1
  recurrence            = "0 17 * * *"

  autoscaling_group_name = module.webserver_cluster.asg_name
}

