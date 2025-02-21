provider "aws"{
    region = "ap-south-1"
}

variable "ami"{
    description = "The AMI ID to use for the instance"
}

variable "instance_type"{
    description = "The type of instance to launch"
    default = "t2.micro"
}



module "ec2"{
    source = "./modules/ec2"
    ami= var.ami
    instance_type = var.instance_type
}