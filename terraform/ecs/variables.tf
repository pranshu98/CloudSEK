variable "app_name" {
  description = "Name of the application"
}
variable "s3_bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
  default     = ""
}

variable "security_group" {
  description = "Security group ID for the ECS service"
  type        = string
}

variable "subnets" {
  description = "List of subnet IDs"
  type        = list(string)
}
