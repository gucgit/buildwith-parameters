variable "aws_region" {
  description = "AWS region to deploy in (eg. ap-south-1)"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "env" {
  description = "Environment name (dev/test/prod)"
  type        = string
  default     = "dev"
}
