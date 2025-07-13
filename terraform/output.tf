output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_id" {
  value = module.vpc.public_subnets
}

output "private_subnet_ids" {
  value = module.vpc.private_subnets
}

output "rds_endpoint" {
  value = module.rds.db_endpoint
}

output "redis_endpoint" {
  value = module.redis.redis_endpoint
}

output "ecs_cluster_name" {
  value = module.ecs.ecs_cluster_name
  description = "Name of the ECS cluster"
}
