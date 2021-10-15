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
  subnet_list            = values(data.terraform_remote_state.vpc.outputs.subnet_ids)
  elb-securitygroup      = [data.terraform_remote_state.vpc.outputs.elb_sg_id]
  instance-securitygroup = [data.terraform_remote_state.vpc.outputs.instance_sg_id]
  key_name               = module.key.mykeypair
  AMI = var.AMI
}
provider "aws" {
  region = var.AWS_REGION
}
terraform {
  backend "s3" {}
}