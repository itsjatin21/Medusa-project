resource "aws_elasticache_subnet_group" "redis" {
  name       = "medusa-redis-subnet"
  subnet_ids = var.private_subnet_ids
  
}

resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "medusa-redis"
  engine               = "redis"
  node_type            = "cache.t3.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis7"
  port                 = 6379
  subnet_group_name    = aws_elasticache_subnet_group.redis.name 
  
}

