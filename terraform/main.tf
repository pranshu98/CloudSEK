terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  required_version = ">= 1.0"
}

provider "aws" {
  region = var.region
}

module "s3_bucket" {
  source   = "./s3"
  app_name = var.app_name
}

module "security_group" {
  source   = "./security"
  app_name = var.app_name
}

module "ecs_service" {
  source         = "./ecs"
  app_name       = var.app_name
  security_group = module.security_group.security_group_id
  s3_bucket_name = module.s3_bucket.bucket_name
  subnets        = var.subnets
}
