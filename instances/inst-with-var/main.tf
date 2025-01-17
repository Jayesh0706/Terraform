provider "aws" {
    region = "ap-south-1"
}

variable "instance_type"{
    description = "The type of instance to launch"
    default = "t2.micro"
}

variable "t2_ami_id"{
    description = "The AMI ID to launch"
    default = "ami-0e306788ff2473ccb"
}

resource "aws_instance" "web" {
    ami = var.t2_ami_id
    instance_type = var.instance_type
}

output "instance_ip" {
    description = "The public IP address of the web server"
    value = aws_instance.web.public_ip
}