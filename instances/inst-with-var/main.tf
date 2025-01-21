provider "aws" {
    region = "ap-south-1"
}



resource "aws_instance" "web" {
    count = "${var.env == "prod" ? 1 : 0}"  # if env is "prod" = 2 instance else 0 instance
    ami = var.ami
    instance_type = var.instance_type
    tags = {
        Name = var.env
    }
}

output "instance_ip" {
    description = "The public IP address of the web server"
    value = aws_instance.web[*].public_ip  # * is used to get all the public IP addresses when count used we must use [*]
}