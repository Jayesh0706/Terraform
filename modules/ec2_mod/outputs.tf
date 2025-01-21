output "instance_public_ip" {
    description = "The public IP address of the web server"
    value = aws_instance.eg-1.public_ip
}

output "enviroment" {
    description = "The environment the instance is running in"
    value = aws_instance.eg-1.tags["environment"]
}