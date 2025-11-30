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