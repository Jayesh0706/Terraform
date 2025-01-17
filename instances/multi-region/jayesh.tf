provider "aws"{
    alias = "reg1"
    region = "ap-south-1"
}
provider "aws"{
    alias = "reg2"
    region = "us-east-1"
}

resource "aws_instance" "jayesh"{
    provider = aws.reg1
    ami = "ami-0d2614eafc1b0e4d2"
    instance_type = "t2.micro"
}

resource "aws_instance" "jayesh2"{
    provider = aws.reg2
    ami = "ami-0df8c184d5f6ae949"
    instance_type = "t2.micro"
}