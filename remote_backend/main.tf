provider "aws"{
    region = "ap-south-1"

}



resource "aws_instance" "my-ec2"{
    ami = "ami-0ed194d7eff6d2f81"
    instance_type = "t2.micro"
    tags = {
        Name = "jayesh"
    }
    subnet_id = "subnet-0a4308172696cf152"
}
