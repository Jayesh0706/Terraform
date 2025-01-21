provider "aws" {
  region = "us-east-1"
}

module "ec2-instances"{
    source = "./ec2_mod"    
    ami            = var.ami
    instance_type  = var.instance_type
    key_name       = var.key_name
    env            = var.env
    
}