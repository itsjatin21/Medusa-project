variable "aws_region" {
  description = "AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

variable "db_password" {
  description = "Password for the Medusa PostgreSQL database"
  type        = string
  sensitive   = true
  default     = "jatin1234"
}

variable "docker_image" {
  description = "Docker image for Medusa from Docker Hub"
  type        = string
  default     = "docker.io/itsjatinsharma/medusa-app:latest"
}