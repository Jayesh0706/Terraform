provider "aws"{
    region = "ap-south-1"
}

resource "aws_instance" "jayesh-ec2"{
    ami = "ami-0e306788ff2473ccb"
    instance_type = "t2.micro"
    tags = {
        Name = "free-tier-ec2"
    }
    key_name = "new_acc"
    subnet_id = "subnet-0a4308172696cf152"
}
