terraform {
  backend "s3" {
    bucket = "jayesh-2101"
    key    = "jayesh/terraform.tfstate"
    region = "ap-south-1"
  }
}
