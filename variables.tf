
variable "aws_region" {
  type        = string
  description = "AWS Region"
  default = "us-east-1"
}

variable "aws_cloudwatch_retention_in_days" {
  type        = number
  description = "AWS CloudWatch Logs Retention in Days"
  default     = 1
}

variable "app_name" {
  type        = string
  description = "Application Name"
}

variable "app_environment" {
  type        = string
  description = "Application Environment"
}

variable "cidr" {
  description = "The CIDR block for the VPC."
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "List of public subnets"
}

variable "private_subnets" {
  description = "List of private subnets"
}

variable "availability_zones" {
  description = "List of availability zones"
}

variable "route53_zone_id" {
  type = string
  description = "List of private subnets"
  default = "Z00720392J3FWBMEHGJQ1"  
}

variable "bucket_name" {
  type = string
  default = "leadsigma-terraform-state.tfstate"  
  description = "backend bucket for state file"
}

variable "bucket_key" {
  default = "stateterraform_state.tfstate"
  description = "key value for backend bucket"
  
}