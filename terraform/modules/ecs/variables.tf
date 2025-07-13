variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs"
  type        = list(string)
}

variable "public_subnet_ids" {
  description = "Public subnet IDs"
  type        = list(string)
}

variable "db_endpoint" {
  description = "Database endpoint URL"
  type        = string
}

variable "redis_endpoint" {
  description = "Redis endpoint URL"
  type        = string
}

variable "task_exec_role_arn" {
  description = "ARN of ECS task execution role"
  type        = string
}

variable "task_role_arn" {
  description = "ARN of ECS task role"
  type        = string
}

variable "security_groups" {
  description = "List of security group IDs"
  type        = list(string)
}
