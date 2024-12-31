provider "aws" {
  region = "ap-south-1" # Mumbai
}

# Create IAM Role for ec2
resource "aws_iam_role" "ec2_s3_readonly" {
  name               = "EC2-S3-ReadOnly-Role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

#attach policy to the role
resource "aws_iam_role_policy_attachment" "s3_readonly" {
  role       = aws_iam_role.ec2_s3_readonly.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

#create an instance profile for the IAM
resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec2-s3-readonly"
  role = aws_iam_role.ec2_s3_readonly.name
}

# EC2 Instance
resource "aws_instance" "http_service" {
  ami           = "ami-021e165d8c4ff761d" # Amazon Linux
  instance_type = "t2.micro"              
  key_name      = "new_acc"               #mykey

  security_groups = [aws_security_group.http_access.name]

  # Attach the IAM instance profile
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y python3 pip
              pip3 install flask boto3
              cat <<EOT >> /home/ec2-user/app.py
              ${file("httpapp.py")}
              EOT
              python3 /home/ec2-user/app.py &
              EOF

  tags = {
    Name = "http-app-ec2"
  }
}

# Security Group
resource "aws_security_group" "http_access" {
  name        = "http-app-sg"
  description = "allow http & ssh"

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # allow port 5000
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # qllow port 22
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # all outgoing traffic allow
  }
}

output "ec2_public_ip" {
  value       = aws_instance.http_service.public_ip
  description = "ec2 public ip  "
}

output "copy_paste_this" {
  value       = "http://${aws_instance.http_service.public_ip}:5000/list-bucket-content"
  description = "for checking "
}
