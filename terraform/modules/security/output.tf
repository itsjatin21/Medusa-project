output "ecs_sg_ids" {
  value = [aws_security_group.main.id]
}

output "rds_sg_ids" {
  value = [aws_security_group.rds.id]
  
}