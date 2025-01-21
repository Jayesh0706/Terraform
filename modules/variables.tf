variable "ami" {
  description = "The AMI to use for the instance"
  type        = string
  default       = "ami-0d2614eafc1b0e4d2"
  
}
variable "instance_type" {
  description = "The type of instance to launch"
  type        = string
  
}
variable "key_name" {
  description = "The key name to use for the instance"
  type        = string
  
}
variable "env" {
  description = "The environment to launch in"
  type        = string
  
}