variable "vpc_id" {
  description = "The VPC ID"
  type        = string
}

variable "public_subnet_id" {
  description = "Public subnet for NAT Gateway"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}
