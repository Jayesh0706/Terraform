provider "aws"{
    region = "ap-south-1"  #AWS region
}

variable "cidr"{
    default= 10.0.0.0/16
}

resource "aws_key_pair" "my-key"{
    key_name = "new_acc"
}

resource "aws_vpc" "my-vpc"{
    cidr_block = var.cidr
}

resource "aws_subnet" "subnet-1"{
    vpc_id = aws_vpc.my-vpc.id
    cidr_block ="10.0.0.0/24"
    availability_zone = "ap-south-1"
    map_public_ip_on_launch = true
}