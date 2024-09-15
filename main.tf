terraform {
  backend "s3" {
    bucket = "beaver-tfstates"
    key    = "first-tfstate/key"
    region = "ap-southeast-1"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "ap-southeast-1"
}

resource "aws_instance" "sample" {
  ami           = "ami-0acbb557db23991cc"
  instance_type = "t2.micro"
  user_data = "${file("launch-portfolio-cont.sh")}"
  tags = {
    Name = "tf-via-gha"
  }
}