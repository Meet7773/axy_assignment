variable "aws_region" {
  default = "ap-south-1"
}

variable "project_name" {
  default = "axy-app"
}

variable "certificate_arn" {
  description = "ACM cert ARN for HTTPS"
  default     = "arn:aws:acm:ap-south-1:111111111111:certificate/placeholder"
}
