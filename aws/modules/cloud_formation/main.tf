provider "aws" {
  region = var.AWS_REGION
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = var.vpc_state_bucket
    key    = var.vpc_state_key
    region = var.AWS_REGION
  }
}

module "key" {
  source = "./modules/keypair"
}

module "app" {
  source                 = "./modules/application"
  subnet_1               = data.terraform_remote_state.vpc.outputs.subnet_ids[0]
  subnet_2               = data.terraform_remote_state.vpc.outputs.subnet_ids[1]
  elb_securitygroup      = data.terraform_remote_state.vpc.outputs.elb_sg_id
  instance_securitygroup = data.terraform_remote_state.vpc.outputs.instance_sg_id
  AMI                    = var.AMI
  key_name               = module.key.mykeypair
}
terraform {
  backend "s3" {}
}

