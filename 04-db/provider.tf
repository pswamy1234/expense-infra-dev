terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 5.92.0" 
    }
  }
  backend "s3" {
    bucket         = "swamy-jenkins"
    key            = "jenkins-db-test1"
    region         = "us-east-1"
    dynamodb_table = "swamy-locking"
  }
}

#provide authentication here
provider "aws" {
  region = "us-east-1"
}