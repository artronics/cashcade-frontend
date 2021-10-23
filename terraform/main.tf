terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
  backend "s3" {
    bucket = "cashcade-terraform"
    region = "eu-west-2"
  }
}

provider "aws" {
  region = "eu-west-2"
}
resource aws_s3_bucket b {
  bucket = "jsalaly-tf-test-bucket"
  acl    = "private"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
