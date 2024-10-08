variable "region" {
  description = "AWS region to deploy"
  default     = "us-east-1"
}

variable "app_name" {
  description = "Name of the application"
  default     = "nodejs-app"
}

variable "subnets" {
  description = "List of subnet IDs"
  type        = list(string)
}
