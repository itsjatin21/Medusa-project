variable "vpc_id" {
  description = "The ID of the VPC where the security group will be created"
  type        = string  
  
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for the ECS service"
  type        = list(string)
  
}

variable "db_password" {
  description = "Password for the RDS database"
  type        = string
  sensitive   = true
  
}

variable "vpc_security_group_ids" {
  description = "List of security group IDs to associate with the RDS instance"
  type        = list(string)
  default     = []
  
}