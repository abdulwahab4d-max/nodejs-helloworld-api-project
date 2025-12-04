# providers.tf

provider "aws" {
  region = "eu-north-1"  # Change to your desired region
}

terraform {
  backend "s3" {
    bucket = "terraform-bucket-aw123"
    key = "state/terraform.tfstate"
    region = "eu-north-1"
  }
}

# Ip of the Instance created by teraform
output "ec2_public_ip" {
  value = aws_instance.ubuntu.public_ip
}

