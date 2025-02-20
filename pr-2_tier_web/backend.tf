terraform {
  backend "s3" {
    bucket = "jayesh-2101"
    key = "pr2/two_tier_web.tfstate"
    region = "ap-south-1"
    dynamodb_table = "remote-backend"
  }
}